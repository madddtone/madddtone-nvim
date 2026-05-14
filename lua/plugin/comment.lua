return {
	"numToStr/Comment.nvim",
	event = "BufReadPre",
	lazy = false,
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		require("Comment.ft").set("env", "#%s")
		local ts_prehook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
		local prehook = function(ctx)
			local result = ts_prehook(ctx)
			if result then
				return result
			end
			return require("Comment.ft").get(vim.bo.filetype, ctx.ctype)
		end
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = "^$",
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},
			mappings = {
				basic = true,
				extra = true,
				extended = false,
			},
			pre_hook = prehook,
		})
	end,
}
