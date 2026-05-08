return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		local treesitter = require("nvim-treesitter")
		if not treesitter.install then
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "bash", "c", "diff", "html", "json", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" },
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
				indent = { enable = true, disable = { "ruby" } },
			})
			return
		end

		local parsers = { "bash", "c", "diff", "html", "json", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
		treesitter.install(parsers)

		local function treesitter_try_attach(buf, language)
			if not vim.treesitter.language.add(language) then
				return
			end

			vim.treesitter.start(buf, language)

			local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
			if has_indent_query then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		local available_parsers = treesitter.get_available()
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local language = vim.treesitter.language.get_lang(args.match)
				if not language then
					return
				end

				local installed_parsers = treesitter.get_installed("parsers")
				if vim.tbl_contains(installed_parsers, language) then
					treesitter_try_attach(args.buf, language)
				elseif vim.tbl_contains(available_parsers, language) then
					treesitter.install(language):await(function()
						treesitter_try_attach(args.buf, language)
					end)
				else
					treesitter_try_attach(args.buf, language)
				end
			end,
		})
	end,
}
