return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- Use default options
    keys = {
        -- The modern replacement for ":TroubleToggle quickfix"
        {
            "<leader>xq",
            "<cmd>Trouble quickfix toggle<cr>",
            desc = "Trouble Quickfix",
        },
        -- Optional: Common keymaps that are usually expected
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Trouble Diagnostics (Project)",
        },
        {
            "<leader>xd",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Trouble Diagnostics (Current Buffer)",
        },
    },
}
