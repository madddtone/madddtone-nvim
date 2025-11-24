return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			-- Keymap for toggling current line blame
			vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, { buffer = bufnr })
		end,
	},
}
