-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	-- telescope fuzzy finder
	require("plugin.telescope"),
	-- neotree
	require("plugin.neotree"),
	-- lsp
	require("plugin.lspconfig"),
	-- conform
	require("plugin.conform"),
	-- nvim-cmp
	require("plugin.cmp"),
	-- alpha nvim
	require("plugin.alpha"),
	-- auto pairs
	require("plugin.autopairs"),
	-- harpoon
	require("plugin.harpoon"),
	-- flash
	require("plugin.flash"),
	-- transparent
	require("plugin.transparent"),
	-- markdown preview
	require("plugin.markdown"),
	-- color scheme catppuccin
	require("plugin.catppuccin"),
	-- treesj
	require("plugin.treesj"),
	-- colorizer
	require("plugin.colorizer"),
	-- aerial
	require("plugin.aerial"),
	-- lazygit
	require("plugin.lazygit"),
	-- comment nvim
	require("plugin.comment"),
	-- supermaven
	require("plugin.supermaven"),
	-- gitsign
	require("plugin.gitsign"),
	-- whichkey
	require("plugin.whichkey"),
	-- todo-comment
	require("plugin.todo-comment"),
	-- mini
	require("plugin.mini"),
	-- treesitter
	require("plugin.treesitter"),
	-- undotree
	require("plugin.undotree"),
})
