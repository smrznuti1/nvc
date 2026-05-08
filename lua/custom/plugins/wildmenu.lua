vim.pack.add { 'https://github.com/gelguy/wilder.nvim' }
local wilder = require 'wilder'
wilder.setup {
  modes = { ':', '/', '?' },
  accept_key = '<C-l>',
  reject_key = '<C-h>',
  accept_completion_auto_select = 0,
}

wilder.set_option(
  'renderer',
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    highlighter = wilder.basic_highlighter(),
    min_width = '100%',
    reverse = 0,
    highlights = { border = 'Normal' },
    border = 'rounded',
    pumblend = 30,
  })
)

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline {
      language = 'python',
      fuzzy = 1,
    },
    wilder.python_search_pipeline {
      pattern = wilder.python_fuzzy_pattern(),
      sorter = wilder.python_difflib_sorter(),
      engine = 're',
    },
    wilder.python_file_finder_pipeline {
      file_command = { 'fd', '-tf' },
      dir_command = { 'fd', '-td' },
      filters = { 'fuzzy_filter', 'difflib_sorter' },
    }
  ),
})
