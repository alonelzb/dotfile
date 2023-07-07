return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    keys = {
        { "<C-p>", "<cmd>Telescope find_files find_command=fd,-t,f,-H,-I<CR>" },
        {
            "<leader>ff",
            -- "<cmd>require('telescope.builtin').find_files({search_dirs={'~'}, find_command={'fd', '-H'}})<CR>",
            "<cmd>Telescope find_files find_command=fd,-H search_dirs=~<CR>",
            desc = "Find Files (Home)",
        },
    },
    opts = {
        defaults = {

            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--trim", -- add this value
                "--hidden",
            },

            file_ignore_patterns = { ".git/", "node_modules", ".pnpm-store/" },
            dynamic_preview_title = true,
            mappings = {
                i = {
                    ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
                },
            },
            layout_config = {
                horizontal = {
                    height = 0.9,
                    preview_cutoff = 120,
                    prompt_position = "bottom",
                    width = 0.8,
                    preview_width = 0.6,
                },
            },
        },
    },
}
