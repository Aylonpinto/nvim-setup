local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
    -- Kleuren
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = require("plugins.colours"),
    },

    -- Tree-sitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "typescript", "json", "html", "css" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- Nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = require("plugins.nvim-tree"),
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = require("plugins.telescope"),
    },

    -- Git-integratie
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = require("plugins.neogit"),
    },
    {
        "lewis6991/gitsigns.nvim",
        config = require("plugins.gitsigns"),
    },

    -- Copilot setup
    {
        "zbirenbaum/copilot.lua",
        config = require("plugins.copilot-integration"),
        dependencies = {
            "zbirenbaum/copilot-cmp",
        },
    },

    -- LSP Icons and formatting
    "onsails/lspkind.nvim",

    -- LSP Zero framework
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = require("plugins.lsp-starting-point"),
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },

    -- Mason for LSP server management
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },

    -- Autocompletion engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
            { "rafamadriz/friendly-snippets" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lua" },
        },
        config = require("plugins.lsp-autocompletion"),
    },

    -- LSP Configuration
    "b0o/schemastore.nvim",
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = true },
        },
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = require("plugins.lsp"),
    },

    -- LSP status display
    { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", opts = {} },

    -- Function signature help
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function()
            require("lsp_signature").setup({
                bind = true,
                handler_opts = {
                    border = "rounded"
                }
            })
        end,
    },

    -- Surround plugin for wrapping text with brackets, quotes, etc.
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "nightfox"
                }
            })
        end
    },

    -- Tabline
    {
        "nanozuki/tabby.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = require("plugins.tabby"),
    },
})
