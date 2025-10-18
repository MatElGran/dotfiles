local cmp_nvim_lsp_found, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_found then
  mlt.notify_error("cmp_nvim_lsp not found")
end

local default_config = {}

local augroup = vim.api.nvim_create_augroup("mlt_lsp", { clear = true })
local function lsp_format_on_save(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 5000, bufnr = bufnr })
      end,
      desc = "Format on save",
    })
  end
end

local keymaps = require("mlt.lsp.keymaps")
local on_attach = function(client, bufnr)
  keymaps.setup(client, bufnr)
  lsp_format_on_save(client, bufnr)
end

default_config.on_attach = on_attach
if cmp_nvim_lsp_found then
  default_config.capabilities = cmp_nvim_lsp.default_capabilities()
end

return {
  default = default_config,
}
