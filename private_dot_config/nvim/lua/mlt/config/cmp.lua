local has_cmp, cmp = pcall(require, "cmp")
if not has_cmp then
  mlt.notify_error("cmp not found")
  return
end

local snippets_config = nil
local format_config = nil

local has_lspkind, lspkind = pcall(require, "lspkind")
if not has_lspkind then
  mlt.notify_error("lspkind not found")
else
  format_config = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      before = require("tailwind-tools.cmp").lspkind_format,
      menu = {
        copilot = "[copilot]",
        luasnip = "[snip]",
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        calc = "[calc]",
        conjure = "[conj]",
      },
    }),
  }
end

-- TODO: configure LuaSnip
local has_luasnip, luasnip = pcall(require, "luasnip")
if not has_luasnip then
  mlt.notify_error("LuaSnip not found")
else
  require("luasnip/loaders/from_vscode").lazy_load()
  luasnip.filetype_extend("ruby", { "rails" })

  snippets_config = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  }
end

cmp.setup({
  snippet = snippets_config,
  mapping = cmp.mapping.preset.insert({}),
  sources = {
    { name = "copilot" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
    { name = "calc" },
    { name = "conjure" },
    { name = "lazydev", group_index = 0 },
  },
  formatting = format_config,
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline({}),
  completion = {
    keyword_length = 3,
  },
  sources = {
    { name = "path" },
    { name = "cmdline" },
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline({}),
  sources = {
    { name = "buffer" },
  },
})({ -- optional cmp completion source for require statements and module annotations
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    })
