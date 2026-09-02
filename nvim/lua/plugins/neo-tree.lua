return {
  [1] = "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = {
        enabled = false
      },
      hijack_netrw_behavior = "open_current"
    },
    window = {
      position = "left"
    }
  }
}
