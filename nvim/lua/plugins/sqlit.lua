return {
  "Maxteabag/sqlit.nvim",
  opts = {},
  keys = {
    {
      "<leader>Q",
      function()
        require("sqlit").open()
      end,
      desc = "Database (sqlit)",
    },
  },
}
