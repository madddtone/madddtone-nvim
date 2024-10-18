return {
	"stevearc/aerial.nvim",
	opts = {
		-- Configuration setup
		on_attach = function(bufnr)
			-- Key mappings for navigation within the Aerial window
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,

		-- Enable the floating window
		layout = {
			default_direction = "float", -- Opens Aerial in a floating window
			placement = "edge", -- Ensure the window opens near the edge
		},

		attach_mode = "window", -- Attach to the current window

		-- Additional settings can go here
	},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
