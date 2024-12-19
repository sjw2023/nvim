-- LSP Support
return {
	-- LSP configuration
	-- https://github.com/neovim/nvim-lspconfig
	"neovim/nvim-lspconfig",
	event = { "VeryLazy", "BufReadPre", "BufNewFile" },
	dependencies = {
		-- LSP Management
		-- https://github.com/williamboman/mason.nvim
		{ "williamboman/mason.nvim" },
		-- https://github.com/williamboman/mason-lspconfig.nvim
		{ "williamboman/mason-lspconfig.nvim" },

		-- Auto-Install LSPs, linters, formatters, debuggers
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

		-- Useful status updates for LSP
		-- https://github.com/j-hui/fidget.nvim
		{ "j-hui/fidget.nvim", opts = {} },

		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		-- Additional lua configuration, makes nvim stuff amazing
		-- https://github.com/folke/neodev.nvim
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")
		local keymap = vim.keymap -- for conciseness
		local util = lspconfig.util

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup({
			ensure_installed = {
				"bashls",
				"jdtls",
				"gradle_ls",
				"groovyls",
				"jsonls",
				"lemminx",
				"marksman",
				"yamlls",
				"quick_lint_js",
				"gopls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
			},
			automatic_installation = false,
		})
		-- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occured prior to this plug in loading so we need to call install explicitly
		-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
		vim.api.nvim_command("MasonToolsInstall")

		local lsp_attach = function(client, bufnr)
			--Create your keybindings here ......
		end

		mason_lspconfig.setup_handlers({

			-- list of servers for mason to install

			-- default handler for installed servers
			function(server_name)
				-- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
				if server_name ~= "jdtls" then
					lspconfig[server_name].setup({
						on_attach = lsp_attach,
						capabilities = capabilities,
					})
				end
			end,
			["svelte"] = function()
				-- configure svelte server
				lspconfig["svelte"].setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.js", "*.ts" },
							callback = function(ctx)
								-- Here use ctx.match instead of ctx.file
								client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
							end,
						})
					end,
				})
			end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			-- Configure gopls server
			["gopls"] = function()
				lspconfig["gopls"].setup({
					capabilities = capabilities,
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								nusedparams = true,
							},
						},
					},
				})
			end,
		})
		require("mason-tool-installer").setup({
			-- Install these linters, formatters, debuggers automatically
			ensure_installed = {
				"java-debug-adapter",
				"jave-test",
			},
		})
		-- Globally configure all LSP floating preview popups (like hover, signature help, etc)
		local open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded" -- Set border to rounded
			return open_floating_preview(contents, syntax, opts, ...)
		end
	end,
}
