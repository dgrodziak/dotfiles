#!/usr/bin/env bash

# Functions
# shellcheck source=shell/functions.sh
source "${HOME}/.shell/functions.sh"

# Settings
# shellcheck source=bash/settings.bash
source "${HOME}/.bash/settings.bash"

# Boostrap
# shellcheck source=shell/bootstrap.sh
source "${HOME}/.shell/bootstrap.sh"

# External settings
# shellcheck source=shell/external.sh
source "${HOME}/.shell/external.sh"

# Aliases
# shellcheck source=shell/aliases.sh
source "${HOME}/.shell/aliases.sh"

# Custom prompt
if command -v starship &> /dev/null; then
  if [ -s "${HOME}/.config/starship.local.toml" ]; then
    export STARSHIP_CONFIG="${HOME}/.config/starship.local.toml"
  else
    export STARSHIP_CONFIG="${HOME}/.config/starship.toml"
  fi
  eval "$(starship init bash)"
else
  # shellcheck source=bash/prompt.bash
  source "${HOME}/.bash/prompt.bash"
fi

# Plugins
# shellcheck source=bash/plugins.bash
source "${HOME}/.bash/plugins.bash"

# Allow local customizations (not checked in to version control)
if [ -f "${HOME}/.shell.local.sh" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.shell.local.sh"
fi
