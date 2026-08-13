-- Overrides for the lazyvim.plugins.extras.ai.claudecode extra.
-- lazy.nvim deep-merges opts across specs, so the extra's keymaps stay intact.
return {
  "coder/claudecode.nvim",
  opts = {
    terminal = {
      split_width_percentage = 0.40, -- match the codex/cursor splits in ai-terminals.lua
    },
  },
}
