local colorschemes = { "gruvbox", "dracula", "monokai-pro", "zephyr", "onedark", "kanagawa", "catppuccin" }
local function randomColor()
    math.randomseed(os.time())
    return colorschemes[math.random(#colorschemes)]
end

return {
    -- gruvbox
    { "ellisonleao/gruvbox.nvim", lazy = true },

    -- catppuccin
    { "catppuccin/nvim", lazy = true, name = "catppuccin" },

    -- dracula
    {
        "Mofiqul/dracula.nvim",
        lazy = true,
        config = function()
            require("dracula").setup({
                transparent_bg = true, -- default false
                italic_comment = true, -- default false
            })
        end,
    },

    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        config = function()
            require("kanagawa").setup({
                transparent = true,
            })
        end,
    },

    -- zephyr
    {
        "glepnir/zephyr-nvim",
        lazy = true,
    },

    -- onedarkpro
    {
        "olimorris/onedarkpro.nvim",
        lazy = true,
        config = function()
            require("onedarkpro").setup({
                options = {
                    transparency = true, -- Use a transparent background?
                    cursorline = true,
                },
            })
        end,
    },

    -- monokai
    {
        "tanvirtin/monokai.nvim",
        lazy = true,
        -- config = function()
        -- require('monokai').setup {}
        -- require("monokai").setup({ palette = require("monokai").pro })
        -- require("monokai").setup({ palette = require("monokai").soda })
        -- require("monokai").setup({ palette = require("monokai").ristretto })
        -- end,
    },

    -- monokai_pro
    {
        "loctvl842/monokai-pro.nvim",
        lazy = true,
        config = function()
            require("monokai-pro").setup({
                transparent_background = true,
                filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
                background_clear = {
                    -- "float_win",
                    "toggleterm",
                    "telescope",
                    "which-key",
                    "renamer",
                    "neo-tree",
                },
                plugins = {
                    bufferline = {
                        underline_selected = false,
                        underline_visible = false,
                    },
                    indent_blankline = {
                        context_highlight = "pro", -- default | pro
                        context_start_underline = true,
                    },
                },
            })
        end,
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            -- gruvbox catppuccin dracula kanagawa zephyr onedarkpro monokai
            colorscheme = "dracula",
            -- colorscheme = randomColor(),
        },
    },
}
