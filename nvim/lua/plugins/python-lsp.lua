-- For some reason, I'm getting errors that 'pyrefly' and 'ty' aren't discoverable by nvim-lspconfig. However, the language servers are definitely working when I open a python file.
-- This is annoying, but is fine for now while I'm testing these out.
vim.lsp.enable("pyrefly")
vim.lsp.enable("ty")

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyrefly", "ty" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = { mason = false, autostart = false },
        ruff = { mason = false, autostart = false },
        pyrefly = {},
        --ty = { },
      },
    },
  },
}
