-- Fuzzy finder
return {
	-- https://github.com/nvim-telescope/telescope.nvim
	"nvim-telescope/telescope.nvim",
	lazy = true,
	branch = "0.1.x",
	dependencies = {
		-- https://github.com/nvim-lua/plenary.nvim
		"nvim-lua/plenary.nvim",
		{
			-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod
		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")
		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				layout_config = {
					vertical = {
						width = 0.75,
					},
				},
				path_display = {
					filename_first = {
						reverse_directories = true,
					},
				},
				--path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
					},
				},
			},
		})
		-- telescope.load_extension("fzf")
	end,
}
