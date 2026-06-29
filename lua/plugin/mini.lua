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

	end,
}
