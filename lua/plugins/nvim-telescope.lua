-- Fuzzy finder
return {
	-- https://github.com/nvim-telescope/telescope.nvim
	"nvim-telescope/telescope.nvim",
	-- lazy = true,
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
	opts = {
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
			-- path_display = { "smart" },
			-- mappings = {
			-- 	i = {
			-- 		["<C-k>"] = actions.move_selection_previous, -- move to prev result
			-- 		["<C-j>"] = actions.move_selection_next, -- move to next result
			-- 		["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
			-- 		["<C-t>"] = trouble_telescope.open,
			-- 	},
			-- },
		},
	},
	config = function(_, opts)
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

		require("telescope").setup(opts)

		local keymap = vim.keymap
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
	end,
	-- telescope.load_extension("fzf")
}
