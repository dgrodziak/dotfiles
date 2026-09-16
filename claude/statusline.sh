#!/usr/bin/env bash
# Claude Code statusline.
#
# Renders: model · effort · ctx N% · 5h N% (reset) · 7d N% (reset)
# Each segment is omitted when its field is absent from the payload.
#
# Reads the statusline JSON payload on stdin; writes one line, no trailing newline.
# Any failure is rendered loudly into the status line itself rather than
# degrading to a blank line.

set -eu -o pipefail

# --------------------------------------------------------------- presentation

ESC=$'\033'

# The whole status line shares one color, so retuning it for a light or dark
# terminal means changing this single value. Prefer a theme-mapped ANSI code
# (30-37) so the terminal's own palette follows the mode; 39 is the default
# foreground, which needs no change between light and dark at all.
COLOR="${ESC}[36m"
RESET="${ESC}[39m"

SEPARATOR=" · "

# Fail loudly: white-on-red, plus a line on stderr for the debug log. This is
# the one place that keeps its own colors -- it must stand out in either mode.
# Deliberately not silent: a blank status line hides breakage.
die() {
  printf '%s[101;97m statusline: %s %s[0m' "$ESC" "$*" "$ESC"
  printf 'statusline: %s\n' "$*" >&2
  exit 1
}

trap 'die "unexpected failure at line $LINENO"' ERR

# --------------------------------------------------------------- jq accessors
#
# Each accessor prints an empty string when its field is null or absent, so
# callers can test with [[ -n ... ]]. Callers must append `|| die` -- a failing
# jq (bad payload, wrong type) must surface, not silently yield "".

# String value at $1.
read_string() {
  jq -r "$1 // \"\"" <<<"$input"
}

# Percentage at $1, rounded half-up to a whole number.
read_percent() {
  jq -r "if ($1) == null then \"\" else (($1) + 0.5 | floor) end" <<<"$input"
}

# Epoch-seconds timestamp at $1, truncated to a whole second.
read_epoch() {
  jq -r "if ($1) == null then \"\" else (($1) | floor) end" <<<"$input"
}

# ----------------------------------------------------------------- formatting

# Humanize a duration in seconds, coarsest two units only: 3d4h / 4h5m / 5m.
format_duration() {
  local seconds=$1
  if (( seconds < 0 )); then
    seconds=0
  fi

  local days=$(( seconds / 86400 ))
  local hours=$(( seconds % 86400 / 3600 ))
  local minutes=$(( seconds % 3600 / 60 ))

  if (( days > 0 )); then
    printf '%dd%dh' "$days" "$hours"
  elif (( hours > 0 )); then
    printf '%dh%dm' "$hours" "$minutes"
  else
    printf '%dm' "$minutes"
  fi
}

# Render one rate-limit segment, e.g. "5h 13% (2h4m)". The time-to-reset suffix
# is included only when the payload carries a reset timestamp.
format_rate_limit() {
  local label=$1 percent=$2 resets_at=$3
  local text="${label} ${percent}%"

  if [[ -n $resets_at ]]; then
    text+=" ($(format_duration $(( resets_at - now ))))"
  fi

  printf '%s' "$text"
}

# ---------------------------------------------------------------------- input

input=$(cat)

command -v jq >/dev/null || die "jq not found on PATH"
[[ -n $input ]] || die "no JSON on stdin"
jq . >/dev/null 2>&1 <<<"$input" || die "stdin is not valid JSON"

model=$(read_string '.model.display_name')  || die "bad .model.display_name"
effort=$(read_string '.effort.level')       || die "bad .effort.level"

context_percent=$(read_percent '.context_window.used_percentage') \
  || die "bad .context_window.used_percentage"

five_hour_percent=$(read_percent '.rate_limits.five_hour.used_percentage') \
  || die "bad .rate_limits.five_hour.used_percentage"
five_hour_reset=$(read_epoch '.rate_limits.five_hour.resets_at') \
  || die "bad .rate_limits.five_hour.resets_at"

seven_day_percent=$(read_percent '.rate_limits.seven_day.used_percentage') \
  || die "bad .rate_limits.seven_day.used_percentage"
seven_day_reset=$(read_epoch '.rate_limits.seven_day.resets_at') \
  || die "bad .rate_limits.seven_day.resets_at"

now=$(date +%s) || die "date failed"

# --------------------------------------------------------------------- render

segments=()

if [[ -n $model ]]; then
  segments+=( "$model" )
fi

if [[ -n $effort ]]; then
  segments+=( "$effort" )
fi

if [[ -n $context_percent ]]; then
  segments+=( "ctx ${context_percent}%" )
fi

if [[ -n $five_hour_percent ]]; then
  segments+=( "$(format_rate_limit '5h' "$five_hour_percent" "$five_hour_reset")" )
fi

if [[ -n $seven_day_percent ]]; then
  segments+=( "$(format_rate_limit '7d' "$seven_day_percent" "$seven_day_reset")" )
fi

line=""
for index in "${!segments[@]}"; do
  if (( index > 0 )); then
    line+="$SEPARATOR"
  fi
  line+="${segments[index]}"
done

# Colorize once, around the whole line -- and emit nothing at all when there
# are no segments, rather than a bare pair of escape codes.
if [[ -n $line ]]; then
  printf '%s%s%s' "$COLOR" "$line" "$RESET"
fi
