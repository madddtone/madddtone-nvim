-- window navigation keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- neotree keymaps
vim.keymap.set(
	"n",
	"<C-g>",
	":Neotree float filesystem reveal=true<CR>",
	{ desc = "Toggle Neo-Tree in float and reveal buffer" }
)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Open aerial float
vim.keymap.set("n", "<leader>,", function()
	require("aerial").toggle() -- Open Aerial

	-- Wait for the window to open, then switch focus to Aerial
	vim.defer_fn(function()
		-- Search for the Aerial window and switch focus
		for i = 1, vim.fn.winnr("$") do
			local win_buf = vim.fn.winbufnr(i)
			if vim.bo[win_buf].filetype == "aerial" then
				vim.api.nvim_set_current_win(vim.fn.win_getid(i))
				break
			end
		end
	end, 50) -- Delay to ensure the window is ready
end)
