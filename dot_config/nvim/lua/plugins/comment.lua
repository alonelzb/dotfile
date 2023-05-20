return {
	{ "echasnovski/mini.comment", enabled = false },
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		config = function()
			require("Comment").setup({
				--				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

				---LHS of toggle mappings in NORMAL mode
				ignore = "^$",
				toggler = {
					line = "<leader>cc",
					block = "<leader>bc",
				},
				opleader = {
					line = "<leader>c",
					block = "<leader>b",
				},
				---Add comment on the line above
				-- above = "gcO",
				---Add comment on the line below
				-- below = "gco",
				---Add comment at the end of line
				-- eol = "gcA",
			})

			vim.keymap.set("n", "<C-_>", require("Comment.api").toggle.linewise.current)
			vim.keymap.set("n", "<A-/>", require("Comment.api").toggle.linewise.current)
			vim.keymap.set("n", "<A-_>", require("Comment.api").toggle.linewise.current)
		end,
	},
}
