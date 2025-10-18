local neotest_extension = { sections = { lualine_a = { 'filename' } }, filetypes = { 'neotest-summary' } }

require('lualine').setup {
  options = {
    theme = 'palenight',
    section_separators = '',
    -- component_separators = '',
  },
  extensions = { 'neo-tree', neotest_extension },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      'diff',
      'diagnostics',
    },
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    },
  },
}
