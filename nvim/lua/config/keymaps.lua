-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- RECONSTRUCTED 2026-08-30 from the compiled bytecode left in ~/.cache/nvim/luac.
-- The behaviour and every string constant are recovered; the exact original
-- formatting is not.

-- Closing the last buffer drops to the dashboard instead of quitting Neovim.
vim.api.nvim_create_user_command("Q", function()
  local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
  if buf_count > 1 then
    pcall(vim.cmd, "bdelete")
  else
    vim.schedule(function()
      require("snacks").dashboard.open()
    end)
  end
end, { desc = "Close buffer or show dashboard" })

-- Route a bare :q through the command above.
vim.cmd([[cnoreabbrev <expr> q (getcmdtype() == ':' && getcmdline() == 'q') ? 'Q' : 'q']])

vim.keymap.set("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "LazyExtras" })

