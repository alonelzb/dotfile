local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end
-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
    vim.keymap.set(
        "n",
        "<Leader>fm",
        '<cmd>lua vim.lsp.buf.format({ filter = function(client) return client.name == "null-ls" end, bufnr = bufnr}) <CR>',
        { silent = true }
    )
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

return {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting

        return {
            debug = false,
            sources = {
                formatting.prettierd.with({
                    extra_filetypes = { "toml" },
                    env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/.prettierrc") },
                }),
                formatting.stylua.with({
                    extra_args = { "--indent-type", "Spaces" },
                }),
                formatting.black,
            },
            on_attach = on_attach,
        }
    end,
}
