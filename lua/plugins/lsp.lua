return function()
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

  local on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  end

  local function get_python_path(workspace)
    if vim.env.VIRTUAL_ENV then
      return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    for _, pattern in ipairs({ "*", ".*" }) do
      local match = vim.fn.glob(vim.fs.joinpath(workspace or ".", pattern, "pyvenv.cfg")) or ""
      if match ~= "" and match ~= nil then
        return vim.fs.joinpath(vim.fs.dirname(match), "bin", "python")
      end
    end

    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
  end

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("basedpyright", {
    capabilities = capabilities,
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = false,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          diagnosticSeverityOverrides = {
            reportUnusedCallResult = false,
          },
        },
      },
      python = {
        analysis = {},
      },
    },
    before_init = function(_, config)
      local python_path = get_python_path(config.root_dir)
      config.settings.python = config.settings.python or {}
      config.settings.python.pythonPath = python_path
    end,
    on_attach = on_attach,
  })

  vim.lsp.config("ruff", {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = function(client)
      client.offset_encoding = "utf-16"
    end,
    init_options = {
      settings = {
        args = {},
      },
    },
  })

  vim.lsp.config("svelte", {
    capabilities = capabilities,
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

  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      on_attach(client, bufnr)
    end,
    settings = {
      typescript = {
        format = {
          enable = false,
        },
      },
      javascript = {
        format = {
          enable = false,
        },
      },
    },
  })

  vim.lsp.config("eslint", {
    capabilities = capabilities,
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
        useFlatConfig = true,
      },
      workingDirectories = { { mode = "auto" } },
      validate = "on",
      packageManager = "npm",
      codeActionOnSave = {
        enable = true,
        mode = "all",
      },
      format = true,
    },
  })

  vim.lsp.config("jsonls", {
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
    on_attach = function(client, bufnr)
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
  })

  vim.lsp.enable({ "basedpyright", "ruff", "svelte", "ts_ls", "eslint", "jsonls" })
end
