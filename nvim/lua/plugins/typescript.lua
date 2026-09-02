return {
  [1] = "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          javascript = {
            preferences = {
              importModuleSpecifier = "shortest"
            }
          },
          typescript = {
            preferences = {
              importModuleSpecifier = "shortest"
            }
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true
              }
            }
          }
        }
      }
    }
  }
}
