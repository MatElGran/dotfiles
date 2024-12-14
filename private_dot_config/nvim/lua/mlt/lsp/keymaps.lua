local M = {}

function M.setup(client, bufnr)
  local capabilities = client.server_capabilities
  local buf_keymap = mlt.buf_keymap(bufnr)

  buf_keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Go to previous diagnostic' })
  buf_keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Go to next diagnostic' })
  buf_keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Show diagnostic' })
  buf_keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>',
    { desc = 'Write buffer diagnostics to the location list' })

  if capabilities.declarationProvider then
    buf_keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Go to declaration' })
  end

  if capabilities.definitionProvider then
    buf_keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Go to definition' })
    buf_keymap.set('n', '<C-w><C-d>', '<C-w>v<cmd>lua vim.lsp.buf.definition()<CR>',
      { desc = 'Open definition in vertical split' })
  end

  if capabilities.codeActionProvider then
    buf_keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code actions' })
    buf_keymap.set('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code actions' })
  end

  if capabilities.renameProvider then
    buf_keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename symbol' })
  end

  if capabilities.hoverProvider then
    buf_keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Hover symbol details' })
  end

  if capabilities.signatureHelpProvider then
    buf_keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Signature help' })
  end

  if capabilities.codeLensProvider then
    buf_keymap.set('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.refresh()<CR>', { desc = 'Refresh CodeLens' })
    buf_keymap.set('n', '<leader>lL', '<cmd>lua vim.lsp.codelens.run()<CR>', { desc = 'Run CodeLens' })
  end

  if capabilities.implementationProvider then
    buf_keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Go to implementation' })
  end

  if capabilities.referencesProvider then
    buf_keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = 'show references' })
  end

  if capabilities.documentFormattingProvider then
    buf_keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true, bufnr = bufnr })<CR>',
      { desc = 'Format buffer' })

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
      vim.lsp.buf.format { async = true, bufnr = bufnr }
    end, { desc = 'Format file with LSP' })
  end
end

return M
