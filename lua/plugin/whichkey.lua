return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- Define your key mappings here. See `:help which-key.mappings`
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
