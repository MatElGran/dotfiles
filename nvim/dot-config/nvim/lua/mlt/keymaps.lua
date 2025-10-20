local map = vim.keymap.set

map('i', 'jk', '<ESC>')
map('n', '<C-$>', '<C-]>')
map('t', '<C-w>', '<C-\\><C-N><C-w>', { desc = 'Escaping terminal for humans' })

-- keep selections after indentation change in visual mode
map('v', '>', '>gv', { desc = 'Indent line' })
map('v', '<', '<gv', { desc = 'Unindent line' })

-- Move selection up/down
map('v', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'move selected line(s) one line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'move selected line(s) one line up' })

-- Oil ------------------------------------------
map('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })

-- neotest ------------------------------------------
local run_current = function()
  require('neotest').run.run(vim.fn.expand '%')
end

local run_nearest = function()
  require('neotest').run.run()
end

local run_suite = function()
  require('neotest').run.run(vim.fn.getcwd())
end

local run_last = function()
  require('neotest').run.run_last()
end

map('n', '<leader>tf', run_current, { desc = 'Test: current file' })
map('n', '<leader>tn', run_nearest, { desc = 'Test: nearest test' })
map('n', '<leader>ts', run_suite, { desc = 'Test: full suite' })
map('n', '<leader>tl', run_last, { desc = 'Test: last run' })
map('n', '<leader>tt', function()
  require('neotest').summary.toggle()
end, { desc = 'Test: toggle summary' })

-- easy-align ----------------------------------------
map('x', 'ga', '<Plug>(EasyAlign)', { desc = 'Start interactive EasyAlign in visual mode (e.g. vipga)' })
map('n', 'ga', '<Plug>(EasyAlign)', { desc = 'Start interactive EasyAlign for a motion/text object (e.g. gaip)' })

-- vim-unimpaired ------------------------------------
map('n', '<A-(>', '[', { remap = true, desc = 'Azerty mapping for vim unimpaired' })
map('n', '<A-)>', ']', { remap = true, desc = 'Azerty mapping for vim unimpaired' })
map('o', '<A-(>', '[', { remap = true, desc = 'Azerty mapping for vim unimpaired' })
map('o', '<A-)>', ']', { remap = true, desc = 'Azerty mapping for vim unimpaired' })
map('x', '<A-(>', '[', { remap = true, desc = 'Azerty mapping for vim unimpaired' })
map('x', '<A-)>', ']', { remap = true, desc = 'Azerty mapping for vim unimpaired' })

-- Telescope -----------------------------------------
local has_telescope, telescope_builtin = pcall(require, 'telescope.builtin')
if not has_telescope then
  mlt.notify_error 'Telescope not found'
else
  map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
  map('n', '<leader>fr', function()
    telescope_builtin.lsp_references { include_declaration = false, show_line = false }
  end, { desc = 'Find references' })
  map('n', '<leader>fw', function()
    telescope_builtin.live_grep()
  end, { desc = 'Find word' })
  map('n', '<leader>fb', function()
    telescope_builtin.buffers()
  end, { desc = 'Find opened buffer' })
end

-- LuaSnip -------------------------------------------
local has_luasnip, luasnip = pcall(require, 'luasnip')
if not has_luasnip then
  mlt.notify_error 'LuaSnip not found'
else
  map({ 'i', 's' }, '<C-j>', function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { desc = 'Expand snippet or jump to next well' })

  map({ 'i', 's' }, '<C-k>', function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { desc = 'Jump to previous snippet well' })

  map('i', '<C-l>', function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, { desc = 'Toggle choice' })
end

-- Treesitter playground -----------------------------
local has_ts_playground, _ = pcall(require, 'nvim-treesitter-playground')
if not has_ts_playground then
  mlt.notify_error 'Treesitter playground not found'
else
  map('n', '<leader>mh', '<cmd>TSHighlightCapturesUnderCursor<CR>', { desc = 'Highlight group info' })
end
