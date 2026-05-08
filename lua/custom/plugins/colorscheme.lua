vim.pack.add { 'https://github.com/comfysage/cuddlefish.nvim' }

local configuration = {
  theme = {
    accent = 'pink',
  },
  editor = {
    transparent_background = true,
  },
  style = {
    tabline = { 'reverse' },
    search = { 'italic', 'reverse' },
    incsearch = { 'italic', 'reverse' },
    types = { 'italic' },
    keyword = { 'italic' },
    comment = { 'italic' },
  },
  overrides = function(colors)
    return {
      CursorLineNr = { '#EC672E' },
      LineNr = { '#8d72ad' },
      OilDir = { '#cc6a1f' },
      OilDirHidden = { '#6e391a' },
      LeapBackdrop = { '#613869' },
      FloatermBorder = { fg = colors.text, bg = 'none' },
      Cursor = { fg = '#ede874', bg = '#7d5a8c' },
      Visual = { bg = '#5d4f63' },
      NonText = { fg = '#738599' },
      DiffText = { fg = '#fc19e1' },
    }
  end,
}

require('cuddlefish').setup(configuration)
vim.cmd.colorscheme 'cuddlefish'
vim.cmd 'highlight CursorLine cterm=underline gui=underline'
vim.g.terminal_color_8 = '#81439c'

vim.api.nvim_create_user_command('TT', function()
  configuration.editor.transparent_background = not configuration.editor.transparent_background
  require('cuddlefish').setup(configuration)
  vim.cmd.colorscheme 'cuddlefish'
  vim.cmd 'highlight CursorLine cterm=underline gui=underline'
  vim.g.terminal_color_8 = '#81439c'
end, {})
