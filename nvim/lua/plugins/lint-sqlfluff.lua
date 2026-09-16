return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      sqlfluff = {
        args = {
          "lint",
          "--format=json",
          "--stdin-filename",
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
          "-",
        },
      },
    },
  },
}
