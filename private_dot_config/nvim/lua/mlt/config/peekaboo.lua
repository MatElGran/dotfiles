local M = {}

function M.create_window()
  local buf = vim.api.nvim_create_buf(true, false)
  local width = 80
  local ui = vim.api.nvim_list_uis()[1]
  local opts = {
    relative = 'editor',
    width = width,
    height = ui.height,
    row = 0,
    col = ui.width,
    anchor = 'NE',
    border = 'single',
    style = 'minimal',
  }
  vim.api.nvim_open_win(buf, true, opts)
end

vim.g.peekaboo_window = "call v:lua.require'mlt.config.peekaboo'.create_window()"

return M
