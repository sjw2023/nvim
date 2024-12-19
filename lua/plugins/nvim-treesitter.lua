-- Code Tree Support / Syntax highlighting
return {
	-- https://github.com/nvim-treesitter/nvim-treesitter
	"nvim-treesitter/nvim-treesitter",
	event = { "VeryLazy", "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		--https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	opts = {
		highlight = {
			enable = true,
		},
		indent = { enable = true },
		-- enable autotagging (w/ nvim-ts-autotag plugin)
		autotag = {
			enable = true,
		},
		auto_install = {
			enable = true,
		},
		ensure_installed = {
			"comment",
			"go",
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"prisma",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"java",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
	config = function(_, opts)
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")
		-- configure treesitter
		treesitter.setup(opts)
	end,
}
