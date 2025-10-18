require("luasnip.session.snippet_collection").clear_snippets("ruby")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("ruby", {
  s("let", fmt("let(:<>) { <> }", { i(1), i(0) }, { delimiters = "<>" })),
})

ls.add_snippets("ruby", {
  s("struct", fmt("<> = Struct.new(<>) <>", { i(1), i(2), i(0) }, { delimiters = "<>" })),
})

vim.b.AutoPairs = vim.fn.AutoPairsDefine({ ["|"] = "|" })
