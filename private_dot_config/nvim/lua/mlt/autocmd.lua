local augroup = vim.api.nvim_create_augroup("mlt_general", {})

-- Create ctags on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  pattern = "*.lua,*.rb,*.js,*.rs",
  command = 'silent execute "!ctags &"',
})

-- Autoread externally modified files (set autoread does not work in terminal
-- per https://stackoverflow.com/a/10962191/1645401)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup,
  pattern = "*",
  command = "silent! checktime",
})

-- Trim trailing whitespaces on save
local function trim_whitespaces()
  local current_line = vim.fn.line(".")
  local current_column = vim.fn.col(".")
  vim.cmd([[keepp %s/\s\+$//e]]) -- do not add the searched pattern to search history
  vim.fn.cursor({ current_line, current_column })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = augroup,
  callback = trim_whitespaces,
})

-- Do not show CursorLine on inactive windows
local function hide_cursor_line()
  vim.opt.cursorline = false
end

local function show_cursor_line()
  vim.opt.cursorline = true
end

vim.api.nvim_create_autocmd("WinLeave", {
  group = augroup,
  callback = hide_cursor_line,
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = augroup,
  callback = show_cursor_line,
})

-- Update helptags when help files are modified
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  pattern = vim.fn.stdpath("config") .. "/doc/*",
  command = "helptags " .. vim.fn.stdpath("config") .. "/doc",
})
