# Utilities

## Agent Notifications

`bin/agent-notify` rings the tmux pane's bell when Claude Code or Codex finishes
a turn, leaving the `!` flag on an inactive window until you visit it. It is
wired up from `claude/settings.json` (`Stop`) and `codex/config.toml` (`notify`).
It writes directly to the pane's tty, so it also works from inside Neovim.

To check it, run this inside tmux and switch to another window before it fires:

```sh
sleep 2; agent-notify
```

`AGENT_NOTIFY_DISABLE=1` silences the notifier. Outside tmux it does nothing.
