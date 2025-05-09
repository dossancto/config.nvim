dofile(vim.g.base46_cache .. "telescope")

local options = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      -- i = {
        -- ["<C-S-v>"] = { "<C-r>+", type = "command" },
      -- },
      n = { ["q"] = require("telescope.actions").close },
    },
  },

  extensions_list = { "themes" },
  extensions = {},
}

return options
