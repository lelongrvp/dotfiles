return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      ["sort-locale-keys"] = {
        command = "jq",
        args = { "-S", "." },
        stdin = true,
        -- RECONSTRUCTED: rebuilt from the bytecode constants
        -- ("%packages/i18n/messages/.*%.json$", ctx, filename, match).
        condition = function(_, ctx)
          return ctx.filename:match("packages/i18n/messages/.*%.json$") ~= nil
        end,
      },
    },
    formatters_by_ft = {
      css = { "prettier" },
      graphql = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "sort-locale-keys", "prettier" },
      jsonc = { "sort-locale-keys", "prettier" },
      lua = { "stylua" },
      sh = { "shfmt" },
      markdown = { "prettier" },
      mdx = { "prettier" },
      scss = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      yaml = { "prettier" },
    },
  },
}
