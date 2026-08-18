-- Diagnostic keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({
		format = function(d)
			return (d.source or "?"):gsub("^%l", string.upper) .. ": " .. d.message
		end,
	})
end, { desc = "Open diagnostic [Q]uickfix list" })

-- Toggle SonarLint "raw view" (show the file as-is on disk, e.g. catch S113)
local function file_ends_with_newline(bufnr)
	local path = vim.api.nvim_buf_get_name(bufnr)
	if path == "" or vim.fn.filereadable(path) == 0 then
		return true
	end
	local fd = io.open(path, "rb")
	if not fd then
		return true
	end
	local last
	local ok = pcall(function()
		local s = fd:seek("end", -1)
		if s >= 0 then
			fd:seek("set", s)
			last = fd:read(1)
		end
	end)
	fd:close()
	if not ok or last == nil then
		return true
	end
	return last == "\n"
end

local function sonarlint_set_raw(bufnr, raw)
	if raw then
		vim.bo[bufnr].eol = file_ends_with_newline(bufnr)
	else
		vim.bo[bufnr].eol = true
	end
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "sonarlint_language_server" })[1]
	if client then
		local version = (vim.lsp.util.buf_versions[bufnr] or 0) + 1
		vim.lsp.util.buf_versions[bufnr] = version
		client:notify("textDocument/didChange", {
			textDocument = { uri = vim.uri_from_bufnr(bufnr), version = version },
			contentChanges = { { text = vim.lsp._buf_get_full_text(bufnr) } },
		})
	end
end

vim.keymap.set("n", "<leader>sr", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local b = vim.b[bufnr].sonarlint_raw
	if b == nil then
		b = not (vim.g.sonarlint_raw == true)
	else
		b = not b
	end
	vim.b[bufnr].sonarlint_raw = b
	sonarlint_set_raw(bufnr, b)
	vim.notify("SonarLint raw view " .. (b and "ON" or "OFF") .. " (this buffer)")
end, { desc = "Toggle SonarLint raw view (current buffer)" })

vim.keymap.set("n", "<leader>sR", function()
	local g = vim.g.sonarlint_raw
	if g == nil then
		g = false
	end
	g = not g
	vim.g.sonarlint_raw = g
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.b[buf].sonarlint_raw == nil then
			sonarlint_set_raw(buf, g)
		end
	end
	vim.notify("SonarLint raw view " .. (g and "ON" or "OFF") .. " (all buffers)")
end, { desc = "Toggle SonarLint raw view (all buffers)" })

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Apply global SonarLint raw view to new buffers",
	callback = function()
		if vim.g.sonarlint_raw ~= true then
			return
		end
		local buf = vim.api.nvim_get_current_buf()
		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(buf) and vim.b[buf].sonarlint_raw == nil then
				sonarlint_set_raw(buf, true)
			end
		end, 0)
	end,
})

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- window navigation keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- neotree keymaps
vim.keymap.set("n", "<C-g>", function()
	local cwd = vim.fn.getcwd()
	local path = vim.api.nvim_buf_get_name(0)

	if path ~= "" and vim.fn.filereadable(path) == 1 and vim.fs.relpath(cwd, path) then
		vim.cmd("Neotree float filesystem reveal_file=" .. vim.fn.fnameescape(path))
	else
		vim.cmd("Neotree float filesystem dir=" .. vim.fn.fnameescape(cwd))
	end
end, { desc = "Toggle Neo-Tree in float and reveal buffer" })

-- undo tree keymaps
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })
vim.api.nvim_set_keymap("n", "<leader>n", ":noh<CR>", { noremap = true, silent = true })

-- neorg: open in vertical split view
vim.keymap.set("n", "<leader>[", ":vsplit | Neorg workspace notes<CR>", {
	desc = "Open Neorg notes workspace in a vsplit",
	silent = true,
	noremap = true,
})

vim.keymap.set("n", "<leader>cp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
end, { desc = "Yank file path" })

vim.keymap.set("n", "<leader>cn", function()
	vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Yank file name" })
