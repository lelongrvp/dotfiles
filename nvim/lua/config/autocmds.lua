-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Restart LSP servers when their config files are saved
-- so they always pick up the latest tsconfig, eslint, tailwind settings
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("lsp_config_reload"),
  callback = function(args)
    local fname = vim.fn.fnamemodify(args.file, ":t")
    local path = args.file

    -- TypeScript: tsconfig changes → restart vtsls
    if fname:match("^tsconfig.*%.json$") then
      vim.cmd("LspRestart vtsls")
      return
    end

    -- ESLint: config changes → restart eslint
    if fname:match("^eslint%.config%.[mc]?[jt]s$") or fname:match("^%.eslintrc") then
      vim.cmd("LspRestart eslint")
      return
    end

    -- Tailwind v4: postcss config or CSS entry file changes → restart tailwindcss
    if fname:match("^postcss%.config%.") then
      vim.cmd("LspRestart tailwindcss")
      return
    end
    -- Tailwind v4 CSS entry (e.g. globals.css with @import "tailwindcss")
    if fname:match("%.css$") then
      local ok, lines = pcall(vim.fn.readfile, path)
      if ok then
        for _, line in ipairs(lines) do
          if line:match("@import.+tailwindcss") then
            vim.cmd("LspRestart tailwindcss")
            return
          end
        end
      end
    end
  end,
})

-- Organize TypeScript/JavaScript imports on save via vtsls source.organizeImports.
-- Must stay synchronous (BufWritePre needs the edit applied before the write
-- proceeds), but capped well below the old 3s so a slow/stuck LSP can't stall
-- a save for long.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("ts_organize_imports"),
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.vue" },
  callback = function()
    local client = vim.lsp.get_clients({ name = "vtsls", bufnr = 0 })[1]
    if not client then
      return
    end
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { "source.organizeImports" }, diagnostics = {} }
    local responses = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 800)
    for _, response in pairs(responses or {}) do
      for _, action in ipairs(response.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
        end
      end
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Scan the cwd for project markers now (this file already loads on VeryLazy,
-- after VimEnter, so a VimEnter autocmd here would never fire) and rescan on
-- :cd so :ProjectInfo stays accurate if you switch projects mid-session.
require("config.project").scan()

vim.api.nvim_create_autocmd("DirChanged", {
  group = augroup("project_detect"),
  callback = function()
    require("config.project").scan()
  end,
})
