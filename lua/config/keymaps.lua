-- Standardize the leader key
vim.g.mapleader = " "

-- Directory navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines up/down in Visual Mode (The "Primeagen" move)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling half-page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor centered when searching terms
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

-- Paste without losing the buffer text (The "void" register paste)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Yank into system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- Combined n and v modes
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register (doesn't overwrite clipboard)
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Map Ctrl-C to Esc (Standard practice for standardized exit)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Q
vim.keymap.set("n", "Q", "<nop>")

-- Quickfix navigation
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- Search and Replace the word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Window Resizing
vim.keymap.set("n", "<C-Up>", ":resize +4<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -4<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -4<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +4<cr>", { desc = "Increase window width" })

-- Map Ctrl-Q to act as Ctrl-A (Increment number)
-- Note: 'remap = true' might be needed here if <C-a> is mapped by a plugin,
-- but usually default behavior is fine for built-ins.
vim.keymap.set("n", "<C-q>", "<C-a>")
