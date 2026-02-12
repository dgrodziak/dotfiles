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
        pyright = { mason = false },
        taplo = { mason = false },
        ty = { enable = true },
      },
    },
  },
}
