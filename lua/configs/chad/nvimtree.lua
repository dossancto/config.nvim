dofile(vim.g.base46_cache .. "nvimtree")
local function my_on_attach(bufnr)
  local map = vim.keymap.set
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  map("n", "l", api.node.open.edit, opts "Open")
  map("n", "h", api.node.navigate.parent_close, opts "Close Directory")
end

local options = {
  on_attach = my_on_attach,

  filters = {
    dotfiles = false,
    custom = { ".git" },
    exclude = { ".gitignore", ".env", ".github", "tmp", "launchSettings.json" },
  },
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = true,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
      },
    },
  },
}

return options
