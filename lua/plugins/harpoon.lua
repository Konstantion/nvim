return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        -- Add the current file to the list
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

        -- Open the Harpoon window
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- Quick selection (files 1-4)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-g>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
    end,
}
