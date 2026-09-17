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
        -- pyrefly runs alongside ty and provides only what ty does not: today that is
        -- refactor code actions (move/extract/inline) and import rewriting on file
        -- rename (workspace/willRenameFiles). Anything pyrefly adds later that is not
        -- in the `ty_provides` list below becomes available automatically.
        pyrefly = {
          -- ty owns diagnostics; never show pyrefly's.
          settings = { python = { pyrefly = { disableTypeErrors = true } } },
          handlers = { ["textDocument/publishDiagnostics"] = function() end },
          -- pyrefly only offers its move/delete refactors when the client accepts
          -- WorkspaceEdit.documentChanges (needed for create/delete-file edits).
          -- Neovim applies those edits but does not advertise this by default.
          capabilities = { workspace = { workspaceEdit = { documentChanges = true } } },
          -- Remove from pyrefly every capability ty already provides (as of ty 0.0.81),
          -- so Neovim routes those requests to ty only. Code actions
          -- are deliberately left on both. If ty later gains something pyrefly also
          -- has, results will show up twice until it is added here.
          on_init = function(client)
            local ty_provides = {
              "callHierarchyProvider",
              "completionProvider",
              "declarationProvider",
              "definitionProvider",
              "diagnosticProvider",
              "documentHighlightProvider",
              "documentSymbolProvider",
              "foldingRangeProvider",
              "hoverProvider",
              "implementationProvider",
              "inlayHintProvider",
              "referencesProvider",
              "renameProvider",
              "selectionRangeProvider",
              "semanticTokensProvider",
              "signatureHelpProvider",
              "typeDefinitionProvider",
              "typeHierarchyProvider",
              "workspaceSymbolProvider",
              -- ruff owns formatting (ty defers to it too)
              "documentFormattingProvider",
              "documentRangeFormattingProvider",
              "documentOnTypeFormattingProvider",
              -- not ty's, but pyrefly's code lenses are Run/Test buttons bound to
              -- VS Code-only commands, so they do nothing useful in Neovim
              "codeLensProvider",
            }
            for _, cap in ipairs(ty_provides) do
              client.server_capabilities[cap] = nil
            end
          end,
        },
      },
    },
  },
}
