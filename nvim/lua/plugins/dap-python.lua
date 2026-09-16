return {
  {
    "mfussenegger/nvim-dap-python",
    keys = {
      {
        "<leader>dm",
        function()
          local dap = require("dap")
          local filepath = vim.fn.expand("%:p")

          -- Find project root by walking up looking for pyproject.toml
          local dir = vim.fn.fnamemodify(filepath, ":h")
          local root = nil
          while dir ~= "/" do
            if vim.fn.filereadable(dir .. "/pyproject.toml") == 1 then
              root = dir
              break
            end
            dir = vim.fn.fnamemodify(dir, ":h")
          end

          if not root then
            vim.notify("No pyproject.toml found above " .. filepath, vim.log.levels.WARN)
            return
          end

          -- Get relative path from project root
          local rel = filepath:sub(#root + 2) -- strip root and trailing /

          -- Handle src-layout: strip src/ prefix when src/ is not a Python package
          if rel:find("^src/") and vim.fn.filereadable(root .. "/src/__init__.py") == 0 then
            rel = rel:sub(5)
          end

          -- Convert to module path
          local module = rel:gsub("%.py$", ""):gsub("/__init__$", ""):gsub("/", ".")

          -- Resolve Python interpreter
          local python_path = nil
          local ok, venv_selector = pcall(require, "venv-selector")
          if ok and venv_selector.python and venv_selector.python() then
            python_path = venv_selector.python()
          else
            local venv_python = root .. "/.venv/bin/python"
            if vim.fn.executable(venv_python) == 1 then
              python_path = venv_python
            end
          end

          local config = {
            type = "python",
            request = "launch",
            name = "Debug Module: " .. module,
            module = module,
            cwd = root,
            console = "integratedTerminal",
          }
          if python_path then
            config.pythonPath = python_path
          end

          dap.run(config)
        end,
        ft = "python",
        desc = "Debug Module",
      },
      {
        "<leader>dM",
        function()
          local dap = require("dap")
          local filepath = vim.fn.expand("%:p")

          -- Find project root by walking up looking for pyproject.toml
          local dir = vim.fn.fnamemodify(filepath, ":h")
          local root = nil
          while dir ~= "/" do
            if vim.fn.filereadable(dir .. "/pyproject.toml") == 1 then
              root = dir
              break
            end
            dir = vim.fn.fnamemodify(dir, ":h")
          end

          if not root then
            vim.notify("No pyproject.toml found above " .. filepath, vim.log.levels.WARN)
            return
          end

          -- Get relative path from project root
          local rel = filepath:sub(#root + 2)

          -- Handle src-layout: strip src/ prefix when src/ is not a Python package
          if rel:find("^src/") and vim.fn.filereadable(root .. "/src/__init__.py") == 0 then
            rel = rel:sub(5)
          end

          -- Convert to module path
          local module = rel:gsub("%.py$", ""):gsub("/__init__$", ""):gsub("/", ".")

          -- Resolve Python interpreter
          local python_path = nil
          local ok, venv_selector = pcall(require, "venv-selector")
          if ok and venv_selector.python and venv_selector.python() then
            python_path = venv_selector.python()
          else
            local venv_python = root .. "/.venv/bin/python"
            if vim.fn.executable(venv_python) == 1 then
              python_path = venv_python
            end
          end

          -- Prompt for args
          vim.ui.input({ prompt = "Arguments: " }, function(input)
            if input == nil then
              return
            end

            local args = {}
            for arg in input:gmatch("%S+") do
              table.insert(args, arg)
            end

            local config = {
              type = "python",
              request = "launch",
              name = "Debug Module: " .. module,
              module = module,
              cwd = root,
              console = "integratedTerminal",
              args = args,
            }
            if python_path then
              config.pythonPath = python_path
            end

            dap.run(config)
          end)
        end,
        ft = "python",
        desc = "Debug Module with Args",
      },
    },
  },
}
