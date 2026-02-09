local my_options = { "curr", "root" }

--- @param option string
--- @return string?
local function nil_if_not_valid(option)
	return vim.tbl_contains(my_options, option) and option or nil
end

local function term_wrapper(command_args)
	local target = nil_if_not_valid(command_args.fargs[1]) or "root"
	local path = ""

	if target == "root" then
		path = vim.fs.root(0, ".git") or vim.fn.getcwd()
	else
		path = vim.api.nvim_buf_get_name(0)

		path = path:gsub("^oil://", "")

		if vim.fn.isdirectory(path) == 0 then
			path = vim.fn.fnamemodify(path, ":h")
		end
	end

	print(path)

	vim.cmd("vnew")
	local buf = vim.api.nvim_get_current_buf()
	vim.fn.jobstart(vim.o.shell, {
		term = true,
		cwd = path,
		on_exit = function()
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end,
	})
	vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("Term", function(command_args)
	term_wrapper(command_args)
end, {
	nargs = "*",
	range = true,
	bang = true,
	complete = function(arg_lead, cmd_line, _)
		return vim.tbl_filter(function(item)
			return item:find("^" .. arg_lead)
		end, my_options)
	end,
})
