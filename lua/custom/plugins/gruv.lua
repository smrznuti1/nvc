vim.pack.add { 'https://github.com/ellisonleao/gruvbox.nvim' }

require('gruvbox').setup {
  terminal_colors = false,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true,
  contrast = 'hard',
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
}
vim.o.background = 'dark'
-- Not activating gruvbox; cuddlefish is the active colorscheme
