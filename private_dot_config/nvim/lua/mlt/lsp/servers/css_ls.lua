local M = {}

M.setup = function(lspconfig, default_config)
  local config = vim.tbl_deep_extend('force', default_config, {})

  lspconfig.cssls.setup(config)
end

return M
