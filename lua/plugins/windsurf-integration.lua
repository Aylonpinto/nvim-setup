return function()
    -- Configure Windsurf for inline suggestions
    require("codeium").setup({
        enable_cmp_source = false,
        virtual_text = {
            enabled = true,
            key_bindings = {
                -- Tab is owned by cmp (see lsp-autocompletion.lua), which
                -- accepts the ghost text when visible
                accept = false,
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                clear = "<C-]>",
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                [""] = false,
            },
        },
    })

end
