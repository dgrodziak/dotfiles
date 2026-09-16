-- Terminal toggles for CLI coding agents.
-- Claude Code is handled separately by the lazyvim.plugins.extras.ai.claudecode extra.

-- Snacks keys terminals by cmd + cwd + env + count. LazyVim.root.git() resolves
-- per-buffer, so resolve it once and reuse it for the lifetime of this nvim
-- instance -- otherwise toggling from a buffer outside the repo silently opens a
-- second terminal for the same agent instead of returning the one you left.
local root ---@type string?

local function agent_root()
  root = root or LazyVim.root.git()
  return root
end

---@param cmd string|string[]
local function toggle(cmd)
  return function()
    Snacks.terminal.toggle(cmd, {
      cwd = agent_root(),
      win = { position = "right", width = 0.40, wo = { winbar = "" } },
    })
  end
end

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>al", toggle("claude"), desc = "Toggle Claude (term)" },
    { "<leader>aL", toggle({ "claude", "--resume" }), desc = "Resume Claude (term)" },
    { "<leader>ax", toggle({ "codex", "--profile", "local" }), desc = "Toggle Codex" },
    { "<leader>aX", toggle({ "codex", "resume", "--profile", "local" }), desc = "Resume Codex" },
    { "<leader>au", toggle("cursor-agent"), desc = "Toggle Cursor Agent" },
    { "<leader>aU", toggle({ "cursor-agent", "--resume" }), desc = "Resume Cursor Agent" },
  },
}
