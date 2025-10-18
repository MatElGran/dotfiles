local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
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
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
})
