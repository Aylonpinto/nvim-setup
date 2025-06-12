return function()
    require('tabby').setup({
        preset = 'active_wins_at_tail',
        option = {
            nerdfont = true,
            theme = {
                fill = { bg = '#192330' },
                head = { fg = '#719cd6', bg = '#131a24' },
                current_tab = { fg = '#dfdfe0', bg = '#63cdcf' },
                tab = { fg = '#738699', bg = '#1e2a3a' },
                win = { fg = '#738699', bg = '#1e2a3a' },
                tail = { fg = '#719cd6', bg = '#131a24' },
            },
        },
    })
end