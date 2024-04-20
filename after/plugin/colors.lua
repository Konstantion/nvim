require('rose-pine').setup({
    disable_background = true
})

function ColorTheme(color)
    color = color or "kanagawa-dragon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- ColorTheme("rose-pine")
ColorTheme("kanagawa-dragon")
