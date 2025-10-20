local M = {}
local logger = require("mlt.log").new({}, true)

M.setup = function(lspconfig, default_config)
  local tailwind_default_config = lspconfig.tailwindcss.config_def.default_config
  local tailwind_filetypes = {}
  for k, v in pairs(tailwind_default_config.filetypes) do
    tailwind_filetypes[k] = v
  end
  table.insert(tailwind_filetypes, "ruby")

  local function is_root_dir(name, path)
    local patterns = {
      "config/tailwind.config.js",
      "tailwind.config.js",
      "tailwind.config.ts",
    }

    for _, pattern in ipairs(patterns) do
      local test = vim.fs.joinpath(path, pattern)
      if vim.uv.fs_stat(test) ~= nil then
        return true
      end
    end

    logger.debug("Tailwind root dir not found: ", path, name)
  end

  local tailwind_config = vim.tbl_deep_extend("force", default_config, {
    root_dir = function(start_path)
      local root = vim.fs.root(start_path, is_root_dir)
      return root
    end,
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
