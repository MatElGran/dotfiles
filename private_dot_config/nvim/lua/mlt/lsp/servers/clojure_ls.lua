local M = {}

M.setup = function(lspconfig, default_config)
  lspconfig.clojure_lsp.setup(default_config)
end
return M
