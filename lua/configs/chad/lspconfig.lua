local M = {}
local py = require "lsp.lang.python"
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  map("n", "<leader>ra", function()
    require "nvchad.lsp.renamer"()
  end, opts "NvRenamer")

  map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")

  local lspconfig = require "lspconfig"

  -- lspconfig.volar.setup {
  --   -- add filetypes for typescript, javascript and vue
  --   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  --   init_options = {
  --     vue = {
  --       -- disable hybrid mode
  --       hybridMode = false,
  --     },
  --   },
  -- }

  require("lspconfig").elixirls.setup {
    cmd = { "/home/dossancto/.local/share/lvim/mason/bin/elixir/language_server.sh" },
  }

  require("nvchad.lsp").diagnostic_config()

  require("lspconfig").ruby_lsp.setup {}

  lspconfig.ts_ls.setup {}
  -- require("lspconfig").tsserver.setup {}
  require("lspconfig").jsonls.setup {}
  require("lspconfig").tailwindcss.setup {}
  require("lspconfig").astro.setup {}
  require("lspconfig").lemminx.setup {}
  require("lspconfig").emmet_language_server.setup {}
  require("lspconfig").docker_compose_language_service.setup {
    filetypes = { "yaml.docker-compose", "docker-compose.yaml", "docker-compose.yml", "yaml" },
  }
  require("lspconfig").dockerls.setup {}

  require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    on_init = M.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }

  require("lspconfig").sqlls.setup {}

  require("lspconfig").dartls.setup {}
  require("lspconfig").jdtls.setup {}
  require("lspconfig").gopls.setup {}

  require("lspconfig").pyright.setup {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off", -- ["off", "basic", "strict"]
          useLibraryCodeForTypes = true,
          completeFunctionParens = true,
        },
      },
    },
    on_new_config = function(new_config, new_root_dir)
      py.env(new_root_dir)
      new_config.settings.python.pythonPath = vim.fn.exepath "python"
      -- new_config.cmd_env.PATH = py.env(new_root_dir) .. new_config.cmd_env.PATH
      new_config.settings.python.analysis.extraPaths = { py.pep582(new_root_dir) }
    end,
  }

  require("lspconfig").omnisharp.setup {
    cmd = { "/home/dossancto/.local/share/nvim/mason/packages/omnisharp/omnisharp" },

    settings = {
      FormattingOptions = {
        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        EnableEditorConfigSupport = true,
        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        OrganizeImports = true,
      },
      MsBuild = {
        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = nil,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = true,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = nil,
      },
      Sdk = {
        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        IncludePrereleases = true,
      },
    },
  }
end

return M
