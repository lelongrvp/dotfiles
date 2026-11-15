return {
  {
    [1] = "folke/snacks.nvim",
    opts = {
      dashboard = {
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
        formats = {
          footer = {
            [1] = "%s",
            align = "center"
          },
          header = {
            [1] = "%s",
            align = "center"
          },
        },
        pane_gap = 4,
        preset = {
          header = "            _______       ___      .______     .___________. __    __     ____    ____  ___       _______   _______ .______      \n            |       \\     /   \\     |   _  \\    |           ||  |  |  |    \\   \\  /   / /   \\     |       \\ |   ____||   _  \\     \n            |  .--.  |   /  ^  \\    |  |_)  |   `---|  |----`|  |__|  |     \\   \\/   / /  ^  \\    |  .--.  ||  |__   |  |_)  |    \n            |  |  |  |  /  /_\\  \\   |      /        |  |     |   __   |      \\      / /  /_\\  \\   |  |  |  ||   __|  |      /     \n            |  '--'  | /  _____  \\  |  |\\  \\----.   |  |     |  |  |  |       \\    / /  _____  \\  |  '--'  ||  |____ |  |\\  \\----.\n            |_______/ /__/     \\__\\ | _| `._____|   |__|     |__|  |__|        \\__/ /__/     \\__\\ |_______/ |_______|| _| `._____|",
          keys = {
            {
              action = ":lua Snacks.dashboard.pick('files')",
              desc = "Find File",
              icon = " ",
              key = "f"
            },
            {
              action = ":ene | startinsert",
              desc = "New File",
              icon = " ",
              key = "n"
            },
            {
              action = ":lua Snacks.dashboard.pick('live_grep')",
              desc = "Find Text",
              icon = " ",
              key = "g"
            },
            {
              action = ":lua Snacks.dashboard.pick('oldfiles')",
              desc = "Recent Files",
              icon = " ",
              key = "r"
            },
            {
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              desc = "Config",
              icon = " ",
              key = "c"
            },
            {
              desc = "Restore Session",
              icon = " ",
              key = "s",
              section = "session"
            },
            {
              action = ":LazyExtras",
              desc = "Lazy Extras",
              icon = " ",
              key = "x"
            },
            {
              action = ":Lazy",
              desc = "Lazy",
              icon = "󰒲 ",
              key = "L"
            },
            {
              action = ":qa",
              desc = "Quit",
              icon = " ",
              key = "q"
            }
          }
        },
        sections = {
          {
            section = "header"
          },
          {
            gap = 1,
            padding = 1,
            section = "keys"
          },
          {
            section = "startup"
          }
        },
        width = 60
      },
      picker = {
        ui_select = true,
        sources = {
          files = {
            hidden = true,
            ignored = true
          },
          grep = {
            hidden = true,
            ignored = true
          }
        }
      },
      statuscolumn = {
        enabled = true,
        folds = {
          close = true,
          open = true
        },
        format = {
          "%s",
          "%=",
          "%l",
          "%r"
        }
      }
    }
  }
}
