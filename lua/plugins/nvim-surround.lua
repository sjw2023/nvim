-- Add, Change, Delete Surrounding Chars (["''"])
return {
	-- https://github.com/kylechui/nvim-surround
	"kylechui/nvim-surround",
	event = { "VeryLazy", "BufReadPre", "BufNewFile" },
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	opts = {},
	config = true,
}
