local M = {}

local cmp_nvim_lsp_found, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_found then
  mlt.notify_error 'cmp_nvim_lsp not found'
end

local keymaps = require 'mlt.lsp.keymaps'

local function setup_diagnostics()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  vim.diagnostic.config {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_on_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      source = true,
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      header = '',
      prefix = '',
    },
  }
end

local function setup_handlers()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local augroup = vim.api.nvim_create_augroup('mlt_lsp', { clear = true })
local function lsp_format_on_save(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 5000, bufnr = bufnr }
      end,
      desc = 'Format on save',
    })
  end
end

M.on_attach = function(client, bufnr)
  keymaps.setup(client, bufnr)
  lsp_format_on_save(client, bufnr)
end

-- There is no need to set the whole capabilities table anymore as
-- lspconfig will deep extend the defaults with what you pass to the server setup method
-- cf https://github.com/neovim/nvim-lspconfig/commit/b6d9e427c9fafca5b84a1f429bef4df3ef63244b
if cmp_nvim_lsp_found then
  M.capabilities = cmp_nvim_lsp.default_capabilities()
else
  M.capabilities = {}
end

M.setup = function()
  setup_diagnostics()
  setup_handlers()
end

return M
