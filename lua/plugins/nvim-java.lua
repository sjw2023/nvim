return {
	"nvim-java/nvim-java",

	config = function()
		local java = require("nvim-java")
		java.setup()
		local lspconfig = require("nvim-lspconfig")
		lspconfig.jdtls.setup({})
	end,
}
