return {
  "folke/persistence.nvim",
  opts = {},
  init = function()
    -- Restore the previous session when nvim is started without file arguments.
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("persistence").load()
      end)
    end
  end,
}
