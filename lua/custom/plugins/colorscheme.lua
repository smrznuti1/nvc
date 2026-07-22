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
      TabLine = { fg = 'Orange' },
    }
  end,
}

local kitty_palette = {
  '#000000',
  '#cc0403',
  '#19cb00',
  '#cecb00',
  '#0d73cc',
  '#cb1ed1',
  '#0dcdcd',
  '#dddddd',
  '#767676',
  '#f2201f',
  '#23fd00',
  '#fffd00',
  '#1a8fff',
  '#fd28ff',
  '#14ffff',
  '#ffffff',
}

local function apply()
  require('cuddlefish').setup(configuration)
  vim.cmd.colorscheme 'cuddlefish'
  vim.cmd 'highlight CursorLine cterm=underline gui=underline'
  for i, color in ipairs(kitty_palette) do
    vim.g['terminal_color_' .. (i - 1)] = color
  end
end

apply()

vim.api.nvim_create_user_command('TT', function()
  configuration.editor.transparent_background = not configuration.editor.transparent_background
  apply()
end, {})
