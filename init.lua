vim.g.neovide_cursor_vfx_mode = "sonicboom"
vim.g.neovide_theme = "auto"

-- set nowrap
vim.wo.wrap = false

vim.g.neovide_opacity = 0.8
vim.g.neovide_normal_opacity = 0.8

local alpha = function()
  return string.format("%x", math.floor(255 * 1))
end

vim.g.neovide_scale_factor = 0.7

-- vim.g.neovide_transparency = 1
-- vim.g.neovide_transparency = 0.8
-- vim.g.neovide_background_color = "#ffffff" 
vim.g.transparency = 1
-- vim.g.transparency = 0.8

vim.g.neovide_window_blurred = true
vim.g.neovide_hide_mouse_when_typing = false

-- set colorscheme to "blue"

vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.wo.relativenumber = true

if vim.g.neovide then
  -- Normal mode
  vim.keymap.set("n", "<C-S-v>", ":r !xsel -b<CR>")
  vim.keymap.set("n", "<C-c>", ":w !xsel -i -b<CR>", { silent = true })

  -- Visual mode
  vim.keymap.set("v", "<C-S-v>", ":r !xsel -b<CR>")
  vim.keymap.set("v", "<C-c>", ":w !xsel -i -b<CR>", { silent = true })

  -- Command mode
  vim.keymap.set("c", "<C-S-v>", "<C-r>+")
  vim.keymap.set("c", "<C-c>", "<C-r>+", { silent = true })

  -- Insert mode
  vim.keymap.set("i", "<C-S-v>", "<C-r>+")
  vim.keymap.set("i", "<C-c>", "<C-r>+", { silent = true })
end
-- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "", texthl = "yellow", linehl = "", numhl = "" })

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapBreakpointRejected",
  { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
)
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

require("dap-cs").setup()
require("mason").setup()

require("dapui").setup()

require("bufferline").setup()

require("Comment").setup()

-- require("nvim-tree").setup {
--   filters = {
--     dotfiles = false,
--     git_ignored = false,
--   },
-- }
