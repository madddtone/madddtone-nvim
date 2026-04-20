local header_art = [[
                           #######                    
                         ##-------##          +       
                       ##-----------#      +---+      
      +%###           ##-------------#     ----+      
    ##------*###%######%+--=*######--*#      =+       
   #--------####-------------------*###%              
  ##-----###--------------------------+##             
  #----##------------------------#####--=#%#*+++*##+  
 =#--##-------------------------#######---##+-+++--#  
 ##-##---------------------%----#######----##+-++--## 
 ###----------------------##-----######-----#+------# 
 ##=--####----#-----########----------------##------# 
 ##--######----#####++++++=#----------------##------#=
 #--#######-----%#+++++++++#----------------%#------#=
+#---#####=------##++++++++#-------=####----#*------# 
+#----+#+---------##++++++##------##----#-----------# 
 #------------------%#####-------%#--.--#----------## 
 ##------------------------------#-----##----------#= 
  #*-----------------------------------#----------#%  
   ##--------------------------------------------*#   
    %#-------------------------------------------##   
      ###-------------..........----------####*--#    
         ##---##+..       .  .:*######--##    ###%    
         ##--=#   ##########  ####   ####             
         -####         *#*                           
]]

local footer_art = [[
                     _     _     _ _                   
 _ __ ___   __ _  __| | __| | __| | |_ ___  _ __   ___ 
| '_ ` _ \ / _` |/ _` |/ _` |/ _` | __/ _ \| '_ \ / _ \
| | | | | | (_| | (_| | (_| | (_| | || (_) | | | |  __/
|_| |_| |_|\__,_|\__,_|\__,_|\__,_|\__\___/|_| |_|\___|

]]
return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- require("mini.files").setup({
		-- 	windows = {
		-- 		preview = true,
		-- 	},
		-- })

		-- vim.keymap.set(
		-- 	"n",
		-- 	"<C-g>",
		-- 	":lua MiniFiles.open()<CR>",
		-- 	{ noremap = true, silent = true, desc = "MiniFile [E]xplorer" }
		-- )

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- mini.starter dashboard
		local starter = require("mini.starter")
		starter.setup({
			items = {
				starter.sections.recent_files(3, true),
			},
			content_hooks = {
				starter.gen_hook.adding_bullet(),
				starter.gen_hook.aligning("center", "center"),
			},
			header = header_art,
			footer = footer_art,
		})

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- mini.statusline's ensure_content sets vim.wo.statusline on ALL windows,
		-- overriding style="minimal" on floats and causing [Scratch] labels.
		-- Replace its autocmd with one that skips floating windows.
		vim.api.nvim_create_augroup("MiniStatusline", { clear = true })
		local function ensure_content()
			local cur_win_id = vim.api.nvim_get_current_win()
			local is_global_stl = vim.o.laststatus == 3
			for _, win_id in ipairs(vim.api.nvim_list_wins()) do
				if vim.api.nvim_win_get_config(win_id).relative == "" then
					vim.wo[win_id].statusline = (win_id == cur_win_id or is_global_stl)
						and "%{%v:lua.MiniStatusline.active()%}"
						or "%{%v:lua.MiniStatusline.inactive()%}"
				end
			end
		end
		vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
			group = "MiniStatusline",
			pattern = "*",
			callback = vim.schedule_wrap(ensure_content),
			desc = "Ensure statusline content",
		})
	end,
}
