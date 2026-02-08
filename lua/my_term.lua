vim.api.nvim_create_user_command('Term', 'vsplit | term', {})
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Escape terminal mode" })
