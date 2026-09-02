return {
  {
    [1] = "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      provider = "claude",
      provider_options = {
        claude = {
          model = "claude-haiku-4-5"
        }
      }
    }
  },
  {
    [1] = "saghen/blink.cmp",
    dependencies = {
      "milanglacier/minuet-ai.nvim"
    },
    opts = {
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "minuet"
        },
        providers = {
          minuet = {
            async = true,
            module = "minuet.blink",
            name = "minuet",
            score_offset = 50,
            timeout_ms = 3000
          }
        }
      }
    }
  }
}
