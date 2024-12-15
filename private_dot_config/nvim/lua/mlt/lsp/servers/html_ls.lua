local M = {}

M.setup = function(lspconfig, default_config)
  local config = vim.tbl_deep_extend('force', default_config, {
    filetypes = { 'html', 'liquid', 'eruby' },
    init_options = {
      provideFormatter = false,
      configurationSection = { 'html', 'css', 'javascript', 'eruby', 'ruby' },
      embeddedLanguages = {
        css = true,
        javascript = true,
        ruby = true,
      },
    },
  })

  lspconfig.html.setup(config)
end

return M
