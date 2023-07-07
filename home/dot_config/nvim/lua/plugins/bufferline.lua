return {
    "akinsho/bufferline.nvim",
    -- set("n", "<leader>h", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
    -- set("n", "<leader>l", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Next Buffer" })
    keys = {
        { ";h", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
        { ";l", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
        { ";1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
        { ";2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
        { ";3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
        { ";4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer 4" },
        { ";5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer 5" },
        { ";6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Buffer 6" },
        { ";7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Buffer 7" },
        { ";8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Buffer 8" },
        {
            ";x",
            function()
                require("mini.bufremove").delete(0, false)
            end,
            desc = "Delete Buffer",
        },
        -- nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
    },
}
