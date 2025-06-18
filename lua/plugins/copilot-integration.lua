return function()
    -- Configure Copilot for inline suggestions
    require("copilot").setup({
        suggestion = { 
            enabled = true,
            auto_trigger = true,
            keymap = {
                accept = "<Tab>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
        },
        panel = { enabled = false },     -- Disable copilot panel
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = '/Users/aylonpinto/.nvm/versions/node/v20.10.0/bin/node',
        server_opts_overrides = {},
    })

end