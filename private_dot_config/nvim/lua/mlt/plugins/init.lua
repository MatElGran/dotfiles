local specs = {
  -- Colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme catppuccin-mocha]]
    end,
  }, -- colorscheme

  {
    'folke/neodev.nvim',
    desc = 'Neovim setup for init.lua and plugin development',
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require 'mlt.config.indent-blankline'
    end,
  },

  -- LSP
  { 'neovim/nvim-lspconfig', desc = 'Quickstart configs for Nvim LSP' },
  { 'onsails/lspkind.nvim',  desc = 'vscode-like pictograms for neovim lsp completion items' },
  -- FIXME: No longer maintained, switch to none-ls
  {
    'nvimtools/none-ls.nvim', --
    desc = 'Bridge between non-LSP tooling and neovim LSP client',
    config = function()
      require 'mlt.config.none_ls'
    end,
  },

  {
    'ThePrimeagen/refactoring.nvim',
    desc = 'Provide Refactoring-book-inspired code actions for LSP',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
  },

  -- Test
  {
    'nvim-neotest/neotest', -- Test runner
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'olimorris/neotest-rspec',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require 'mlt.config.neotest'
    end,
  },

  -- Git integration
  'tpope/vim-fugitive',         -- Vim plugin for git
  { 'idanarye/vim-merginal' },  -- Fugitive extension to manage and merge Git branches
  { 'junegunn/gv.vim' },
  { 'sindrets/diffview.nvim' }, -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.

  -- Languages Support

  -- Ruby/Rails
  { 'vim-ruby/vim-ruby' }, -- TODO: Document textobjects and motions
  { 'tpope/vim-bundler' },
  { 'tpope/vim-rails' },
  { 'slim-template/vim-slim' },

  -- Javascript
  { 'yuezk/vim-js' },
  { 'HerringtonDarkholme/yats' },
  { 'maxmellon/vim-jsx-pretty' },

  -- Clojure and other lisps
  {
    'guns/vim-sexp',
    config = function()
      require 'mlt.config.sexp'
    end,
  },
  { 'tpope/vim-sexp-mappings-for-regular-people' },
  {
    'Olical/conjure',
    config = function()
      vim.g['conjure#mapping#prefix'] = ',c'
    end,
  },

  -- tailwind-tools.lua
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig',         -- optional
    },
    opts = {
      server = {
        override = false,
      },
      extension = {
        patterns = {
          ruby = {
            [[class=\s*"([^"]*)]],
            [[class=\s*'([^']*)]],
            [[class: "([^"]*)]],
            [[class: '([^']*)]],
            [[form_class: "([^"]*)]],
            [[form_class: '([^']*)]],
          },
          eruby = {
            [[class=\s*"([^"]*)]],
            [[class=\s*'([^']*)]],
            [[class: "([^"]*)]],
            [[class: '([^']*)]],
            [[form_class: "([^"]*)]],
            [[form_class: '([^']*)]],
          },
        },
      },
    }, -- your configuration
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'mlt.config.treesitter'
    end,
  },
  { 'nvim-treesitter/playground' },
  {
    'RRethy/nvim-treesitter-endwise',
    -- FIXME: this should go in the treesitter configuration
    config = function()
      require('nvim-treesitter.configs').setup { endwise = { enable = true } }
    end,
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require 'mlt.config.cmp'
    end,
  },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-calc' },
  { 'hrsh7th/cmp-cmdline' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'PaterJason/cmp-conjure' },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = { markdown = true },
      }
    end,
  },

  -- Text Objects (:h personal-textobjects)
  -- { 'kana/vim-textobj-user' },   -- User defined text object
  -- { 'kana/vim-textobj-line' },   -- Line text objects
  -- { 'kana/vim-textobj-entire' }, -- Text objects for entire buffer
  -- { 'kana/vim-textobj-indent' }, -- text objects to select a block of lines similarly indented to the current line

  { 'tpope/vim-surround' }, -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  { 'tpope/vim-abolish' },  -- Easily search for, substitute, and abbreviate multiple variants of a word

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    desc = 'highly extendable fuzzy finder over lists',
    config = function()
      require 'mlt.config.telescope'
    end,
  },                                                              --
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }, -- FZF sorter for telescope

  -- FIXME: replace with Heirline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require 'mlt.config.lualine'
    end,
  },

  { 'mattn/emmet-vim' }, -- Emmet support
  {
    'stefandtw/quickfix-reflector.vim',
    desc = 'Edit in the quickfix window, save modifications in actual files',
    config = function()
      require 'mlt.config.quickfix-reflector'
    end,
  },

  {
    'preservim/tagbar',
    desc = 'provides an easy way to browse the tags of the current file and get an overview of its structure',
  },
  -- {
  --   'junegunn/vim-peekaboo',
  --   desc = 'extends " and @ in normal mode and <CTRL-R> in insert mode to show the contents of the registers.',
  --   config = function()
  --     require 'mlt.config.peekaboo'
  --   end,
  -- },

  {
    'folke/todo-comments.nvim', -- Highlight, list and search todo comments in your projects
    config = function()
      require 'mlt.config.todo-comments'
    end,
  },
  { 'tpope/vim-dispatch' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-repeat' },

  { 'simeji/winresizer' },
  { 'mbbill/undotree' },

  { 'jlanzarotta/bufexplorer' },
  { 'junegunn/vim-slash',        desc = 'Enhancing in-buffer search experience' },
  { 'easymotion/vim-easymotion', desc = 'Vim motions on speed!' },
  { 'wellle/targets.vim',        desc = 'Provides additional text objects' },
  { 'kshenoy/vim-signature',     desc = 'Place, toggle and display marks.' },

  { 'AndrewRadev/splitjoin.vim' },
  { 'junegunn/vim-easy-align' },
  { 'tomtom/tcomment_vim' },
  { 'airblade/vim-gitgutter' },

  {
    'jiangmiao/auto-pairs',
    desc = 'Vim plugin, insert or delete brackets, parens, quotes in pair',
    config = function()
      require 'mlt.config.auto-pairs'
    end,
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  },
  -- TODO: Associate keymaps
  {
    'danymat/neogen',
    desc = 'Code annotation generator',
    config = function()
      require('neogen').setup { enable = true, snippet_engine = 'luasnip' }
    end,
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },
}

return specs
