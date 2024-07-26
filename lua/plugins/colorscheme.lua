return {
	-- "catppuccin/nvim",
	-- -- lazy = true,
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
	{
		"sainnhe/sonokai",
		priority = 1000,
		config = function()
			vim.g.sonokai_transparent_background = "1"
			vim.g.sonokai_enable_italic = "1"
			vim.g.sonokai_style = "andromeda"
			vim.cmd.colorscheme("sonokai")
		end,
	},
}
