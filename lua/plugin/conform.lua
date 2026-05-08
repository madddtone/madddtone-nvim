return { -- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			local enabled_filetypes = {
				lua = true,
				javascript = true,
			}
			if enabled_filetypes[vim.bo[bufnr].filetype] then
				return { timeout_ms = 500 }
			end
			return nil
		end,
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			javascript = { "prettierd" },
		},
	},
}
