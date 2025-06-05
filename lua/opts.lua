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

-- [[ Shell ]]
vim.opt.shell = "/bin/zsh"
vim.opt.shellcmdflag = "-ic"  -- -i makes it interactive, loading .zshrc

-- [[ Keymaps ]]
-- General
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })

-- [[ Splits ]]
vim.opt.splitright = true -- bool: Place new window to right of current one
vim.opt.splitbelow = true -- bool: Place new window below the current one

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
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Show references" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover documentation" })
vim.keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "Signature help" })
vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { noremap = true, silent = true, desc = "Add workspace folder" })
vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { noremap = true, silent = true, desc = "Remove workspace folder" })
vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { noremap = true, silent = true, desc = "List workspace folders" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { noremap = true, silent = true, desc = "Type definition" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })
vim.keymap.set("n", "<leader>C", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format buffer" })
vim.keymap.set("v", "<leader>F", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format selection" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show diagnostic" })

-- Move lines up/down
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- Copy relative path to clipboard
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand('%')
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, { desc = "Copy relative path to clipboard" })
