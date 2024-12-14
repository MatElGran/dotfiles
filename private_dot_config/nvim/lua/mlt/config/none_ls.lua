local has_null_ls, null_ls = pcall(require, 'null-ls')
if not has_null_ls then
  mlt.notify_error 'null-ls not found'
  return
end

local function has_standard()
  return vim.fn.filereadable '.standard.yml' == 1
end

local sources = {
  null_ls.builtins.code_actions.gomodifytags,
  null_ls.builtins.code_actions.refactoring.with {
    extra_filetypes = { 'ruby' },
  },

  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.goimports_reviser,
  null_ls.builtins.formatting.golines,

  null_ls.builtins.formatting.stylua,

  null_ls.builtins.formatting.erb_lint,
  null_ls.builtins.diagnostics.erb_lint,
}

if has_standard() then
  vim.notify 'standard detected'
  table.insert(sources, null_ls.builtins.formatting.standardrb)
  table.insert(sources, null_ls.builtins.diagnostics.standardrb)
end

null_ls.setup {
  on_attach = require('mlt.lsp.handlers').on_attach,
  sources = sources,
}
