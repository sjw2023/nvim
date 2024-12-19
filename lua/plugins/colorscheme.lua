return {
	-- "catppuccin/nvim",
	-- lazy = true,
	-- name = "catppuccin",
	-- priority = 1000,
	-- opts = {
	-- 	integrations = {
	-- 		aerial = true,
	-- 		alpha = true,
	-- 		cmp = true,
	-- 		dashboard = true,
	-- 		flash = true,
	-- 		grug_far = true,
	-- 		gitsigns = true,
	-- 		headlines = true,
	-- 		illuminate = true,
	-- 		indent_blankline = { enabled = true },
	-- 		leap = true,
	-- 		lsp_trouble = true,
	-- 		mason = true,
	-- 		markdown = true,
	-- 		mini = true,
	-- 		native_lsp = {
	-- 			enabled = true,
	-- 			underlines = {
	-- 				errors = { "undercurl" },
	-- 				hints = { "undercurl" },
	-- 				warnings = { "undercurl" },
	-- 				information = { "undercurl" },
	-- 			},
	-- 		},
	-- 		navic = { enabled = true, custom_bg = "lualine" },
	-- 		neotest = true,
	-- 		neotree = true,
	-- 		noice = true,
	-- 		notify = true,
	-- 		semantic_tokens = true,
	-- 		telescope = true,
	-- 		treesitter = true,
	-- 		treesitter_context = true,
	-- 		which_key = true,
	-- 	},
	-- },

	-- Cyber dream
	--[[ "scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			transparent = true,
			terminal_colors = true,
		})
		vim.cmd("colorscheme cyberdream")
	end, ]]

	-- Ever Forest
	-- https://github.com/sainnhe/everforest
	"sainnhe/everforest",
	lazy = false, -- We want the colorscheme to be loaded immediately when starting Neovim
	priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
	-- opts = {
	-- 	-- Replace this with your specific scheme settings or remove to use the defaults
	-- 	transparent = true,
	-- 	background = {
	-- 		dark = "wave",
	-- 	},
	-- 	colors = {
	-- 		palette = {},
	-- 	},
	-- },
	config = function(_, opts)
		-- require("everforest").setup(opts)
		vim.g.everforest_enable_italic = true
		vim.cmd("colorscheme everforest")

		-- Custom diff colors
		vim.cmd([[
      autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
      autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
      autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
      autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
    ]])

		-- Custom border colors
		vim.cmd([[
      autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
      autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
    ]])
	end,
}
