-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd([[
  hi Pmenu guibg=None
  hi PmenuSel guibg=#483D8B
  hi PmenuThumb guibg=#483D8B

  hi TelescopePreviewNormal guibg=None 
  hi TelescopePromptCounter guifg=#483D8B
  hi TelescopeNormal guifg=#483d8b
  hi TelescopeResultsNormal guifg=#944dff
  hi LineNr guifg=#73797e
  hi CursorLineNr guifg=#944dff


  hi BgCustom guibg=#483d8b

  hi SignColumn guibg=None
  hi Normal guibg=None
  hi NeoTreeCursorLine guibg=#483d8b
  hi BufferLineBufferSelected guibg=#483d8b

]])
--a
