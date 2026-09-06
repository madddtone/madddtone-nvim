-- Omarchy-synced aether colorscheme.
--
-- Reads the current Omarchy theme's rendered aether spec at startup, so Neovim
-- starts on the same palette as the desktop. aether v3's built-in hotreload
-- watches ~/.local/state/omarchy/current/theme/neovim.lua and live re-applies
-- the colors itself on `omarchy theme set` -- no custom reload code needed.

local function omarchy_theme_opts()
	local paths = {
		vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua"),
		vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua"),
	}
	for _, path in ipairs(paths) do
		if vim.fn.filereadable(path) == 1 then
			local ok, spec = pcall(dofile, path)
			if ok and type(spec) == "table" and type(spec[1]) == "table" then
				local opts = spec[1].opts
				if type(opts) == "table" and opts.colors then
					return opts
				end
			end
		end
	end
	return {}
end

return {
	"bjarneo/aether.nvim",
	branch = "v3",
	name = "aether",
	priority = 1000,
	opts = function()
		return omarchy_theme_opts()
	end,
	config = function(_, opts)
		require("aether").setup(opts)
		vim.cmd.colorscheme("aether")

		-- aether's hotreload clears highlights on every switch, which also
		-- undoes nvim-transparent; re-apply it after each aether reload.
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "aether",
			group = vim.api.nvim_create_augroup("OmarchyAetherAfterTheme", { clear = true }),
			callback = function()
				pcall(vim.cmd, "TransparentEnable")
			end,
			desc = "Re-apply nvim-transparent after aether hotreload",
		})
	end,
}