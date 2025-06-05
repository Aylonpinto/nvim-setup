--[[ opts.lua ]]

-- [[ UI Options ]]
vim.opt.number = true
vim.opt.relativenumber = false

-- [[ Indentation ]]
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- [[ Swap file settings ]]
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- [[ Buffer settings ]]
vim.opt.confirm = true
vim.opt.hidden = true

-- [[ Clipboard ]]
vim.opt.clipboard = "unnamedplus"

-- [[ Terminal ]]
vim.opt.termguicolors = true

-- [[ Keymaps ]]
-- General
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })

-- Neogit
local function toggle_neogit()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].filetype == "NeogitStatus" then
            vim.api.nvim_buf_delete(buf, { force = true })
            return
        end
    end
    vim.cmd("topleft vsplit")
    require("neogit").open({ kind = "replace" })
end
vim.keymap.set("n", "<leader>g", toggle_neogit, { noremap = true, silent = true, desc = "Toggle Neogit" })

-- Gitsigns  
vim.keymap.set("n", "]g", function() require("gitsigns").next_hunk() end, { desc = "Next git hunk" })
vim.keymap.set("n", "[g", function() require("gitsigns").prev_hunk() end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Toggle blame" })


-- [[ LSP Keymaps ]]
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true })

-- Move lines up/down
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })
