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
	},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	-- Lazy load Aerial with the 'VeryLazy' event
	event = "VeryLazy",
	-- Set up keymaps to load Aerial when necessary and focus the window
	keys = {
		{
			"<leader>,",
			function()
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
			end,
			desc = "Toggle Aerial and focus window",
		},
	},
}
