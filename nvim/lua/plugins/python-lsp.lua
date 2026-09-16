return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "ty" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      codeLens = { enabled = true },
      servers = {
        pyright = { mason = false },
        ty = {
          enable = true,
        },
      },
    },
  },
}
