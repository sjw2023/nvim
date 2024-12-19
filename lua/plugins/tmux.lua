-- Navigate nvim and tmux windows/panels with vim bindings
return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	-- https://github.com/christoomey/vim-tmux-navigator
	-- Only load this plug in if tmux is being used
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	event = function()
		if vim.fn.exists("$TMUX") == 1 then
			return "VeryLazy"
		end
	end,
}
