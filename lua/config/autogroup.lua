local augroup = vim.api.nvim_create_augroup
local buf_group = augroup("PrePostBuf", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
        require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
        group = yank_group,
        pattern = "*",
        callback = function()
                vim.highlight.on_yank({
                        higroup = "IncSearch",
                        timeout = 40,
                })
        end,
})

autocmd({ "BufWritePre" }, {
        group = buf_group,
        pattern = "*",
        command = [[%s/\s\+$//e]],
})

-- autocmd({ "BufWritePost" }, {
--         group = buf_group,
--         pattern = "*",
--         callback = function()
--                 if next(vim.lsp.buf_get_clients(0)) then
--                         pcall(vim.lsp.codelens.refresh)
--                 end
--         end,
-- })

