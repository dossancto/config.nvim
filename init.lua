vim.g.neovide_cursor_vfx_mode = "sonicboom"
vim.g.neovide_theme = 'auto'

vim.g.neovide_scale_factor = 0.8

vim.g.neovide_transparency = 0.8
vim.g.transparency = 0.8

vim.g.neovide_window_blurred = true

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

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "yellow", linehl = "", numhl = "" })

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

require("dapui").setup()

require("bufferline").setup()

require("Comment").setup()

-- require("nvim-tree").setup {
--   filters = {
--     dotfiles = false,
--     git_ignored = false,
--   },
-- }
