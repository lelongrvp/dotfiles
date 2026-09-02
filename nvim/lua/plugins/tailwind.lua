-- PARTIALLY RECONSTRUCTED 2026-08-30. The settings table below is exact (recovered
-- from the compiled spec). The two functions are rebuilt from the string constants
-- left in the bytecode -- their behaviour is right but the original wording is not
-- guaranteed. Constants recovered: lspconfig.util / root_pattern /
-- "pnpm-workspace.yaml" / on_dir / fname / nvim_buf_get_name / bufnr /
-- "/apps/main/src/styles/globals.css" / filereadable / experimental.configFile /
-- editor.tabSize / get_effective_tabstop / tbl_deep_extend "keep".
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {
        -- Anchor the server at the pnpm workspace root, not the nearest package.
        root_dir = function(fname, on_dir)
          local util = require("lspconfig.util")
          on_dir(util.root_pattern("pnpm-workspace.yaml")(fname))
        end,
        before_init = function(_, config)
          local bufnr = vim.api.nvim_get_current_buf()
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local css_entry = config.root_dir .. "/apps/main/src/styles/globals.css"
          if vim.fn.filereadable(css_entry) == 1 then
            config.settings = vim.tbl_deep_extend("keep", config.settings or {}, {
              tailwindCSS = {
                experimental = { configFile = css_entry },
              },
            })
          end
          config.settings = vim.tbl_deep_extend("keep", config.settings or {}, {
            editor = { tabSize = vim.lsp.util.get_effective_tabstop(bufnr) },
          })
          local _ = fname
        end,
        settings = {
          tailwindCSS = {
            classFunctions = { "cn", "cva" },
            includeLanguages = {
              typescript = "javascript",
              typescriptreact = "javascript",
            },
            validate = true,
          },
        },
      },
    },
  },
}
