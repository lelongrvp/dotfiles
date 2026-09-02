return {
  [1] = "akinsho/toggleterm.nvim",
  config = true,
  keys = {
    {
      [1] = "<C-/>",
      [2] = "<cmd>ToggleTerm<cr>",
      desc = "Toggle terminal",
      mode = {
        "n",
        "t"
      }
    }
  },
  opts = {
    close_on_exit = true,
    direction = "horizontal",
    hide_numbers = true,
    insert_mappings = true,
    persist_mode = true,
    persist_size = true,
    shade_filetypes = {},
    shell = "zsh",
    size = 20,
    start_in_insert = true,
    terminal_mappings = true
  },
  version = "*"
}
