-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt
-- vim.opt.guifont = "Hack Nerd Font:h12"
opt.cursorcolumn = true
opt.foldmethod = "marker"
opt.tabstop = 4
opt.shiftwidth = 4
-- vim.opt.list = true
opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
