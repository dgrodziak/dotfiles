return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "ty", "pyrefly" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      codeLens = { enabled = true },
      servers = {
        pyright = { mason = false },
        ty = { enable = true },
        -- pyrefly runs alongside ty, restricted to what ty does not support yet:
        -- refactor code actions (move/extract/inline) and import rewriting on
        -- file rename (workspace/willRenameFiles).
        pyrefly = {
          -- ty owns diagnostics; never show pyrefly's.
          settings = { python = { pyrefly = { disableTypeErrors = true } } },
          handlers = { ["textDocument/publishDiagnostics"] = function() end },
          -- pyrefly only offers its move/delete refactors when the client accepts
          -- WorkspaceEdit.documentChanges (needed for create/delete-file edits).
          -- Neovim applies those edits but does not advertise this by default.
          capabilities = { workspace = { workspaceEdit = { documentChanges = true } } },
          -- Hide every pyrefly capability ty already provides so Neovim routes those
          -- requests to ty only. workspace.fileOperations is not a *Provider key, so
          -- file-rename support survives untouched.
          on_init = function(client)
            local keep = {
              codeActionProvider = true,
              executeCommandProvider = true,
            }
            for cap in pairs(client.server_capabilities) do
              if cap:match("Provider$") and not keep[cap] then
                client.server_capabilities[cap] = nil
              end
            end
          end,
        },
      },
    },
  },
}
