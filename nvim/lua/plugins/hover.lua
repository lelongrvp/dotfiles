return {
  "lewis6991/hover.nvim",
  keys = {
    {
      "K",
      function()
        if vim.bo.filetype == "help" or vim.bo.filetype == "man" then
          return vim.cmd("normal! K")
        end
        require("hover").hover()
      end,
      desc = "Hover (LSP, diagnostics)",
    },
  },
  opts = {
    init = function()
      require("hover.providers.lsp")
      require("hover.providers.diagnostic")
    end,
    preview_opts = {
      border = "rounded",
      max_width = 110,
      max_height = 28,
    },
    title = true,
  },
}
