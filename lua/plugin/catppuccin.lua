return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- Set up Catppuccin with Mocha flavor
		require("catppuccin").setup({
			flavour = "mocha", -- Change to 'mocha' flavor
			transparent_background = true,
			-- You can add additional options here
		})
		-- Apply the colorscheme
		vim.cmd("colorscheme catppuccin")
	end,
}
