return function()
    -- Configure Copilot for nvim-cmp integration
    require("copilot").setup({
        suggestion = { enabled = false }, -- Disable inline suggestions (use cmp instead)
        panel = { enabled = false },      -- Disable copilot panel (use cmp instead)
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
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
    })

    -- Configure copilot-cmp
    require("copilot_cmp").setup()
end