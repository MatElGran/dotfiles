_G.mlt = {}

mlt.notify_error = function(message)
  vim.notify(message, vim.log.levels.ERROR)
end

mlt.buf_keymap = function(bufnr)
  return {
    set = function(mode, key, command, custom_opts)
      local opts = vim.tbl_extend('force', { noremap = true, silent = true }, custom_opts)
      vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts)
    end,
  }
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require 'mlt.options'
local specs = require 'mlt.plugins'

-- Automatically install lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  print 'Could not initialize Lazy'
else
  lazy.setup(specs)
end

require 'mlt.keymaps'
require 'mlt.lsp'
require 'mlt.autocmd'
