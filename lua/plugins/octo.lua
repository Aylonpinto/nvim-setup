return function()
    require("octo").setup({
        picker = "telescope",
        enable_builtin = true,
        use_local_fs = true,
    })

    vim.keymap.set("n", "<leader>v", function()
        local layout = require("octo.reviews").get_current_layout()
        if not layout then return end
        local file = layout:get_current_file()
        if file then file:toggle_viewed() end
    end, { desc = "Octo: toggle viewed (current diff file)" })
end
