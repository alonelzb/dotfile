return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        local utils = require("utils")
        utils.ui()

        -- Add additional capabilities supported by nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        -- capabilities.textDocument.completion.completionItem.snippetSupport = true

        local servers = {
            "html",
            "cssls",
            "bashls",
            "yamlls",
            "jsonls",
            "pyright",
            -- "gopls",
            -- "denols"
            -- "tsserver"
        }
        -- vim.g.markdown_fenced_languages = {
        --     "ts=typescript"
        -- }
        -- 通用服务器配置
        -- html
        -- npm i -g vscode-langservers-extracted
        -- include
        -- vscode-html-language-server
        -- vscode-css-language-server
        -- vscode-json-language-server
        -- vscode-eslint-language-server
        for _, server in pairs(servers) do
            lspconfig[server].setup({
                capabilities = capabilities,
                on_attach = utils.on_attach,
            })
        end
        -- lua
        lspconfig.lua_ls.setup({
            settings = require("servers.lua_ls"),
            capabilities = capabilities,
            on_attach = utils.on_attach,
        })

        -- volar
        -- To enable Take Over Mode, override the default filetypes in setup{} as follows
        lspconfig.volar.setup({
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
            capabilities = capabilities,
            on_attach = utils.on_attach,
        })

        -- emmet-ls
        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            on_attach = utils.on_attach,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "vue" },
        })
    end,
    dependencies = {
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate", -- :MasonUpdate updates registry contents
            config = function()
                require("mason").setup({
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                })
            end,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup({
                    ensure_installed = require("utils").servers,
                    automatic_installation = true,
                })
            end,
        },
    },
}
