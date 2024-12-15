local M = {}

M.setup = function(lspconfig, default_config)
  local tailwind_default_config = lspconfig.tailwindcss.config_def.default_config
  local tailwind_filetypes = {}
  for k, v in pairs(tailwind_default_config.filetypes) do
    tailwind_filetypes[k] = v
  end
  table.insert(tailwind_filetypes, "ruby")

  local tailwind_config = vim.tbl_deep_extend("force", default_config, {
    root_dir = vim.fs.root(0, { "config/tailwind.config.js", "tailwind.config.js", "tailwind.config.ts" }),
    filetypes = tailwind_filetypes,
    settings = {
      tailwindCSS = {
        includeLanguages = {
          ruby = "html",
        },
        experimental = {
          classRegex = {
            [[class: "([^"]*)]],
            [[class: '([^']*)]],
            [[form_class: "([^"]*)]],
            [[form_class: '([^']*)]],
          },
        },
      },
    },
  })

  lspconfig.tailwindcss.setup(tailwind_config)
end

return M
