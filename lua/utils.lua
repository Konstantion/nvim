local M = {}

M.show_absolute_path = function()
	local filepath = vim.api.nvim_buf_get_name(0)

	if filepath == "" then
		print("Empty buffer (no file)")
	else
		print(filepath)
	end
end

M.copy_absolute_path = function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath == "" then
		print("Empty buffer (no file)")
	else
		vim.fn.setreg("+", filepath)

		vim.notify("Copied to clipboard: " .. filepath, vim.log.levels.INFO)
	end
end

M.open_float_window = function(content_lines, width, height)
	local buf = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)

	local win_width = width or math.floor(vim.o.columns * 0.5)
	local win_height = height or math.floor(vim.o.lines * 0.3)

	local row = math.floor((vim.o.lines - win_height) / 2 - 1)
	local col = math.floor((vim.o.columns - win_width) / 2)

	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	return buf, win
end

M.open_smart_float = function(content_lines)
    local buf = vim.api.nvim_create_buf(false, true)

    local width = 0
    for _, line in ipairs(content_lines) do
        width = math.max(width, #line)
    end
    width = math.max(width, 10)
    local height = #content_lines

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)

    local opts = {
        style = "minimal",
        relative = "cursor", -- Position relative to cursor
        width = width,
        height = height,
        row = 1,             -- 1 line below the cursor
        col = 0,             -- Align with cursor column
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    local close_win = function()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    vim.keymap.set('n', 'q', close_win, { buffer = buf, nowait = true })
    vim.keymap.set('n', '<Esc>', close_win, { buffer = buf, nowait = true })

    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        callback = close_win,
        once = true, -- Delete this autocmd after it runs once
    })

    vim.api.nvim_set_option_value('winhl', 'Normal:NormalFloat,FloatBorder:FloatBorder', { win = win })

    return buf, win
end

_G.utils = M

return M
