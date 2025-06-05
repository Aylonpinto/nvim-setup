return function()
  local lsp = require("lspconfig")
  local util = require("lspconfig/util")
  local path = util.path

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "eslint",
      "ts_ls",
      "svelte",
      "basedpyright",
      "jsonls",
      "ruff",
    },
    automatic_installation = true,
    automatic_enable = false,
  })

  local lsp_flags = {
    debounce_text_changes = 150,
  }

  local on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      if vim.lsp.inlay_hint and type(vim.lsp.inlay_hint) == "function" then
        vim.lsp.inlay_hint(bufnr, true)
      elseif vim.lsp.inlay_hint and type(vim.lsp.inlay_hint) == "table" and vim.lsp.inlay_hint.enable then
        vim.lsp.inlay_hint.enable(true)
      end
    end
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  end

  local function get_python_path(workspace)
    if vim.env.VIRTUAL_ENV then
      return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    for _, pattern in ipairs({ "*", ".*" }) do
      local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg")) or ""
      if match ~= "" and match ~= nil then
        return path.join(path.dirname(match), "bin", "python")
      end
    end

    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
  end

  lsp.basedpyright.setup({
    root_dir = util.root_pattern("src", ".git", "pyproject.toml", "setup.py", "setup.cfg"),
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          diagnosticSeverityOverrides = {
            reportUnusedCallResult = false
          },
        },
      },
      python = {
        analysis = {
        },
      }
    },
    before_init = function(_, config)
      local python_path = get_python_path()
      config.settings.python.pythonPath = python_path
    end,
    on_attach = on_attach,
  })

  lsp.ruff.setup({
    on_attach = on_attach,
    init_options = {
      settings = {
        args = {},
      },
    },
  })


  lsp.svelte.setup({
    filetypes = { "svelte", "html", "css" },
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end,
    settings = {
      svelte = {
        format = {
          enable = true,
        },
      },
    },
  })

  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  
  lsp.ts_ls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    settings = {
      typescript = {
        format = {
          enable = false
        }
      },
      javascript = {
        format = {
          enable = false
        }
      }
    }
  })

  lsp.eslint.setup({
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.cmd("EslintFixAll")
        end,
      })

      on_attach(client, bufnr)
    end,
    settings = {
      useESLintClass = false,
      experimental = {
        useFlatConfig = true
      },
      workingDirectories = { { mode = "auto" } },
      validate = "on",
      packageManager = "npm",
      codeActionOnSave = {
        enable = true,
        mode = "all"
      },
      format = true
    }
  })


  lsp.jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    on_attach = function(client, bufnr)
      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end
      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    end,
  })
end
