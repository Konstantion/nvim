local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader><leader>', builtin.buffers, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

require('telescope').setup {
  defaults = {
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s — %s", tail, path), { { { 1, #tail }, "Constant" } }
    end,
  }
}
