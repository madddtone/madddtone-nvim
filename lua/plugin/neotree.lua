-- lua/plugin/neotree.lua

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				position = "float", -- Floating window
				popup = {
					size = {
						height = "80%", -- Floating window height (percentage or fixed)
						width = "40%", -- Floating window width (percentage or fixed)
					},
					border = "rounded", -- Border style for floating window
					position = {
						row = 1, -- Align the floating window vertically near the top
						col = 1, -- Align it near the left side (close to line numbers)
					},
					offset = {
						row = 0,
						col = 2, -- Slightly move it away from the very left, next to line numbers
					},
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true, -- Automatically expand and highlight the current file
				},
				hijack_netrw_behavior = "open_default", -- Hijack netrw and use Neo-Tree instead
				use_libuv_file_watcher = true, -- Automatically refresh when files change
				filtered_items = {
					hide_dotfiles = false, -- Show hidden files
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- Highlight the current file buffer in the file tree
				},
			},
		})
	end,
}
