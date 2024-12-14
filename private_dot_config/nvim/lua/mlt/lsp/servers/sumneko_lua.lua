local M = {}

M.setup = function(lspconfig, default_config)
  local config = vim.tbl_deep_extend('force', default_config, {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.stdpath 'config' .. '/lua'] = true,
            '${3rd}/luv/library',
          },
        },
      },
    },
  })

  lspconfig.lua_ls.setup(config)
end

return M
