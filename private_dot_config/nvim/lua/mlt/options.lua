vim.opt.termguicolors = true -- enable terminal colors
vim.opt.background = 'dark'  -- set background color to dark

vim.opt.number = true        -- Show line numbers
vim.opt.cursorline = true    -- highlight current line
vim.opt.list = true          -- enable list mode
vim.opt.showmode = false     -- disable mode line

vim.opt.splitbelow = true    -- open horizontal split windows below the current one
vim.opt.splitright = true    -- open vertical split windows to the right of the current one

vim.opt.expandtab = true     -- expand tabs to spaces
vim.opt.shiftwidth = 2       -- set tab width to 2
vim.opt.softtabstop = 2      -- set soft tab width to 2, does not mess with tabstop, cf :h tabstop

vim.opt.undofile = true      -- enable undo
vim.opt.clipboard = 'unnamedplus'
vim.opt.laststatus = 2

-- Use rg for :grep
if vim.fn.executable 'rg' then
  vim.opt.grepprg = 'rg -H --no-heading --vimgrep'
  vim.opt.grepformat = '%f:%l:%c:%m'
end
