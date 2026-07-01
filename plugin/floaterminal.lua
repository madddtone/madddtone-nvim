vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

local state = {
	floating = {
		buf = -1,
		win = -1,
	},
	width = nil,
	height = nil,
}

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or state.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or state.height or math.floor(vim.o.lines * 0.8)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)
	vim.wo[win].cursorline = true

	return { buf = buf, win = win }
end

local function resize_terminal(delta)
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		return
	end

	local win = state.floating.win
	local config = vim.api.nvim_win_get_config(win)
	local new_width = math.max(20, config.width + delta)
	local new_height = math.max(5, config.height + delta)

	config.width = new_width
	config.height = new_height
	config.col = math.floor((vim.o.columns - new_width) / 2)
	config.row = math.floor((vim.o.lines - new_height) / 2)

	state.width = new_width
	state.height = new_height
	vim.api.nvim_win_set_config(win, config)
end

local function clear_primary()
	vim.fn.setreg("*", "")
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
			clear_primary()
		else
			vim.api.nvim_set_current_win(state.floating.win)
			clear_primary()
		end
		vim.cmd.startinsert()
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- Toggle
vim.keymap.set({ "n", "t" }, "<space>tt", toggle_terminal)

-- Resize: use > and < in terminal-normal mode (after <Esc><Esc>)
vim.keymap.set("t", ">", function() resize_terminal(10) end)
vim.keymap.set("t", "<", function() resize_terminal(-10) end)

-- Reduce input latency in terminal buffers
local ttimeout_group = vim.api.nvim_create_augroup("FloaterminalTtimeout", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = ttimeout_group,
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.o.ttimeoutlen = 5
		end
	end,
})
vim.api.nvim_create_autocmd("BufLeave", {
	group = ttimeout_group,
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.o.ttimeoutlen = 50
		end
	end,
})


