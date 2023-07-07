return {
    "folke/noice.nvim",
    config = function()
        --
        require("noice").setup({
            messages = {
                -- NOTE: If you enable messages, then the cmdline is enabled automatically.
                -- This is a current Neovim limitation.
                enabled = true, -- enables the Noice messages UI
                view = "mini", -- default view for messages
                view_error = "split", -- view for errors
                view_warn = "notify", -- view for warnings
                view_history = "messages", -- view for :messages
                view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
            },
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
            },

            commands = {},

            notify = {
                enabled = false,
                view = "popup",
            },
            --
            views = {
                split = {
                    -- 打开时自动进入窗口
                    enter = true,
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "NoiceSplitBorder" },
                        wrap = true,
                    },
                },
                cmdline_popup = {
                    position = {
                        row = "50%",
                        col = "50%",
                    },
                    size = {
                        min_width = 30,
                        width = "auto",
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = "75%",
                        col = "50%",
                    },
                    size = {
                        width = 30,
                        height = "auto",
                        max_height = 15,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
                    },
                },
                hover = {
                    border = {
                        style = "rounded",
                        padding = { 0, 0 },
                    },
                    position = { row = 2, col = 2 },
                    size = {
                        width = "auto",
                        height = "auto",
                        -- max_height = 20,
                        max_width = 60,
                    },
                },
            },
            --
            -- 	commands = {
            -- 		history = {
            -- 			view = "popup",
            -- 		},
            -- 	},
            --
            routes = {
                --[[ {
			filter = { event = "msg_showmode" },
			view = "notify",
		}, ]]
                {

                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    -- always route any messages with more than 20 lines to the split view
                    filter = { event = "msg_show", min_height = 10 },
                    view = "popup",
                },
                {
                    -- always route any messages with more than 20 lines to the split view
                    filter = { event = "notify", min_height = 10 },
                    view = "popup",
                },
                {
                    view = "notify",
                    filter = { cmdline = "^:" },
                },
            },
        })
    end,
}
