-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function vertical_terminal(cwd)
  Snacks.terminal.focus(nil, {
    cwd = cwd,
    count = 2,
    win = { position = "right", width = 0.4 },
  })
end

vim.keymap.set({ "n", "t" }, "<leader>fv", function()
  vertical_terminal(LazyVim.root())
end, { desc = "Terminal Vertical (Root Dir)" })

vim.keymap.set({ "n", "t" }, "<leader>fV", function()
  vertical_terminal(vim.fn.getcwd(0))
end, { desc = "Terminal Vertical (cwd)" })
