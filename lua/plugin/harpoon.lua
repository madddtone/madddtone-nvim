return {
	"ThePrimeagen/harpoon",
	requires = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		require("harpoon").setup({})
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
		vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })
		vim.keymap.set("n", "<leader>1", function()
			ui.nav_file(1)
		end, { desc = "Navigate to file 1" })
		vim.keymap.set("n", "<leader>2", function()
			ui.nav_file(2)
		end, { desc = "Navigate to file 2" })
		vim.keymap.set("n", "<leader>3", function()
			ui.nav_file(3)
		end, { desc = "Navigate to file 3" })
		vim.keymap.set("n", "<leader>4", function()
			ui.nav_file(4)
		end, { desc = "Navigate to file 4" })
	end,
}
