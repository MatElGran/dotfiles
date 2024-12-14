-- Fixes `gf` and `^Wf` in ERB files
-- cf https://github.com/tpope/vim-rails/issues/602#issuecomment-2270498684
if vim.fn.RailsDetect() then
  vim.cmd 'cmap <buffer><script><expr> <Plug><cfile> rails#ruby_cfile()'
end
