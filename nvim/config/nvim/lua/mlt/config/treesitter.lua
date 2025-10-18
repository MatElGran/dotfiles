require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  embedded_templates = {
    enable = true,
  },
  -- FIXME: needs treesitter text objects plugin
  -- also cf https://github.com/RRethy/nvim-treesitter-textsubjects
  textobjects = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}

local augroup = vim.api.nvim_create_augroup('folding', {})
local excluded_filetypes = {
  ['neo-tree'] = true,
  ['neotest-summary'] = true,
  ['help'] = true,
}

vim.api.nvim_create_autocmd('Filetype', {
  group = augroup,
  callback = function(args)
    local lang = vim.api.nvim_get_option_value('filetype', { buf = args['buf'] })

    if excluded_filetypes[lang] == nil then
      local supported = pcall(vim.treesitter.get_parser, args['buf'], lang)
      if supported then
        vim.wo.foldlevel = 99
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      else
        -- vim.api.nvim_err_writeln(string.format('TreeSitter: unsupported language: %s', lang))
      end
    end
  end,
})
