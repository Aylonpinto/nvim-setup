return function()
    require('tabby').setup({
        tabline = require('tabby.presets').active_wins_at_tail,
    })
end