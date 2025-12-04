return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "Git Status" },
        -- 3-way merge conflict resolution
        { "<leader>dfh", "<cmd>diffget //2<CR>", desc = "Diff Get Left (Target)" },
        { "<leader>dfl", "<cmd>diffget //3<CR>", desc = "Diff Get Right (Merge)" },
    }
}
