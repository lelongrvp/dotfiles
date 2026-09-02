return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          throttle = 0,
          softwrap = 30,
          multilines = {
            enabled = true,
            always_show = true,
          },
          show_all_diags_on_cursorline = true,
          enable_on_insert = false,
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
