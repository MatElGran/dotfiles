local lspconfig_found, lspconfig = pcall(require, "lspconfig")
if not lspconfig_found then
	mlt.notify_error("nvim-lspconfig not found")
	return
end

-- Enable trace logging
-- vim.lsp.set_log_level 'trace'
-- require('vim.lsp.log').set_format_func(vim.inspect)

local handlers = require("mlt.lsp.handlers")
handlers.setup()

local default_config = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

-- Ruby
require("lspconfig").ruby_lsp.setup({})

-- Lua
require("mlt.lsp.servers.sumneko_lua").setup(lspconfig, default_config)

-- Clojure
require("mlt.lsp.servers.clojure_lsp").setup(lspconfig, default_config)

-- HTML
require("mlt.lsp.servers.html").setup(lspconfig, default_config)

-- CSS
require("mlt.lsp.servers.cssls").setup(lspconfig, default_config)

-- Golang
require("lspconfig").golangci_lint_ls.setup({})
require("lspconfig").gopls.setup({})

-- JavaScript / TypeScript
require("lspconfig").ts_ls.setup({})
require("lspconfig").eslint.setup({})
require("lspconfig").jsonls.setup({})

-- TailwindCSS
local tailwind_default_config = lspconfig.tailwindcss.config_def.default_config
local tailwind_filetypes = {}
for k, v in pairs(tailwind_default_config.filetypes) do
	tailwind_filetypes[k] = v
end
table.insert(tailwind_filetypes, "ruby")

local tailwind_config = vim.tbl_deep_extend("force", default_config, {
	root_dir = lspconfig.util.root_pattern("config/tailwind.config.js", "tailwind.config.js", "tailwind.config.ts"),
	filetypes = tailwind_filetypes,
	settings = {
		tailwindCSS = {
			includeLanguages = {
				ruby = "html",
			},
			experimental = {
				classRegex = {
					[[class: "([^"]*)]],
					[[class: '([^']*)]],
					[[form_class: "([^"]*)]],
					[[form_class: '([^']*)]],
				},
			},
		},
	},
})

lspconfig.tailwindcss.setup(tailwind_config)

--

-- TODO: add missing servers
-- jsonls, emmet_ls, crystalline, tsserver, eslint

-- TODO: Add schemas from schemastore
-- local jsonls_opts = require("mlt.lsp.settings.jsonls")
-- lspconfig.jsonls.setup(vim.tbl_deep_extend("force", default_opts, jsonls_opts)
