-- For some reason, I'm getting errors that 'pyrefly' and 'ty' aren't discoverable by nvim-lspconfig. However, the language servers are definitely working when I open a python file.
-- This is annoying, but is fine for now while I'm testing these out.
-- vim.lsp.enable("pyrefly")
vim.lsp.enable("ty")

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "ty" },
      automatic_enable = { "ty" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Including this comment as reminder of some other configs I've played around with.
        -- pyright = { enable = false, mason = false, autostart = false },
        pyright = { mason = false },
        -- LazyVim's default configurations use ruff if available. Thus, even though I exclude it here from mason
        -- (and I tried other configurations to exclude it entirely), it will still pick up ruff from my PATH.
        -- Keep that in mind, as I won't be able to have ruff installed as a uv tool until I sort through this
        -- configuration nuance.
        ruff = { mason = false },
        taplo = { mason = false },
        ty = { enable = true },
      },
    },
  },
}
