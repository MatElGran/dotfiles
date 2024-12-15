local lspconfig_found, lspconfig = pcall(require, "lspconfig")
if not lspconfig_found then
  mlt.notify_error("nvim-lspconfig not found")
  return
end

-- Enable trace logging
-- vim.lsp.set_log_level 'trace'
-- require('vim.lsp.log').set_format_func(vim.inspect)

-- Enable debug logging
-- vim.lsp.set_log_level("debug")

require("mlt.lsp.handlers")

local default_config = require("mlt.lsp.config").default

-- Clojure
require("mlt.lsp.servers.clojure_ls").setup(lspconfig, default_config)

-- HTML
require("mlt.lsp.servers.html_ls").setup(lspconfig, default_config)

-- CSS
require("mlt.lsp.servers.css_ls").setup(lspconfig, default_config)

-- TailwindCSS
require("mlt.lsp.servers.tailwindcss_ls").setup(lspconfig, default_config)

-- Golang
lspconfig.golangci_lint_ls.setup(default_config)
lspconfig.gopls.setup(default_config)

-- Ruby
lspconfig.ruby_lsp.setup(default_config)

-- Lua
lspconfig.lua_ls.setup(default_config)

-- JavaScript / TypeScript
lspconfig.ts_ls.setup(default_config)
lspconfig.eslint.setup(default_config)
lspconfig.jsonls.setup(default_config)

-- TODO: Add schemas from schemastore
-- local jsonls_opts = require("mlt.lsp.settings.jsonls")
-- lspconfig.jsonls.setup(vim.tbl_deep_extend("force", default_opts, jsonls_opts)
