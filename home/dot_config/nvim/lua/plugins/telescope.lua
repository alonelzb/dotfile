return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{ "<C-p>", "<cmd>Telescope find_files find_command=fd,-t,f,-H,-I<CR>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>" },
	},
}
