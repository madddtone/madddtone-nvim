-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more infolaz
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
	-- lsp
	require("plugin.lspconfig"),
	-- conform
	require("plugin.conform"),
	-- nvim-cmp
	require("plugin.cmp"),
	-- alpha nvim
	-- require("plugin.alpha"),
	-- auto pairs
	require("plugin.autopairs"),
	-- harpoon
	require("plugin.harpoon"),
	-- transparent
	require("plugin.transparent"),
	-- markdown preview
	require("plugin.markdown"),
	-- color scheme catppuccin
	require("plugin.catppuccin"),
	-- treesj
	require("plugin.treesj"),
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
	-- dadbod
	require("plugin.dadbod"),
	-- neorg
	require("plugin.neorg"),
	-- neotree
	require("plugin.neotree"),
	-- colorizer
	-- require("plugin.colorizer"),
})
