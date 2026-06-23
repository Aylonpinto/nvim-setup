-- Displays coverage information in the sign column.
-- https://github.com/andythigpen/nvim-coverage

return function()
    require("coverage").setup({
        commands = true, -- create commands
        highlights = {
            -- customize highlight groups created by the plugin
            -- supports style, fg, bg, sp (see :h highlight-gui)
            covered = { fg = "#587b7b" },
            uncovered = { fg = "#587b7b" },
        },
        signs = {
            -- use your own highlight groups or text markers
            covered = { hl = "CoverageCovered", text = "." },
            uncovered = { hl = "CoverageUncovered", text = "x" },
        },
        summary = {
            -- customize the summary pop-up
            -- minimum coverage threshold (used for highlighting)
            min_coverage = 80.0,
        },
        lang = {
            python = {
                coverage_command = ".venv/bin/coverage json --fail-under=0 -q -o -",
            },
        },
        auto_reload = true,
        load_coverage_cb = function(ftype)
            vim.notify("Loaded " .. ftype .. " coverage")
        end,
    })
end
