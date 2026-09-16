return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              -- Allow PyYAML custom tags used by MkDocs / PyMdown Extensions
              -- so they aren't flagged as "Unresolved tag". yamlls matches
              -- the fully-resolved tag URI, not the `!!` shorthand.
              customTags = {
                "tag:yaml.org,2002:python/name:pymdownx.superfences.fence_code_format",
                "tag:yaml.org,2002:python/name:material.extensions.emoji.twemoji",
                "tag:yaml.org,2002:python/name:material.extensions.emoji.to_svg",
                "!ENV scalar",
                "!ENV sequence",
              },
            },
          },
        },
      },
    },
  },
}
