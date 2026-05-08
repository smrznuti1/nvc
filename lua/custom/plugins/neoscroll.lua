vim.pack.add { 'https://github.com/karb94/neoscroll.nvim' }
require('neoscroll').setup {
  mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
  hide_cursor = false,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  easing_function = 'quadratic',
  pre_hook = nil,
  post_hook = nil,
  performance_mode = false,
}
