-- Diagnostic keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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
