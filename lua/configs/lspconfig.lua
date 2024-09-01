-- load defaults i.e lua_lsp
require("configs.chad.lspconfig").defaults()

local lspconfig = require("lspconfig")
local py = require "lsp.lang.python"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "configs.chad.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.pyright.setup{
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off", -- ["off", "basic", "strict"] 
        useLibraryCodeForTypes = true,
        completeFunctionParens = true,
      }
    }
  },
  on_new_config = function(new_config, new_root_dir)
    py.env(new_root_dir)
    new_config.settings.python.pythonPath = vim.fn.exepath 'python'
    -- new_config.cmd_env.PATH = py.env(new_root_dir) .. new_config.cmd_env.PATH
    new_config.settings.python.analysis.extraPaths = { py.pep582(new_root_dir) }
  end,
}

lspconfig.tsserver.setup{}
lspconfig.jsonls.setup{}
lspconfig.tailwindcss.setup{}
lspconfig.tailwindcss.setup{}
lspconfig.astro.setup{}
lspconfig.emmet_language_server.setup{}
