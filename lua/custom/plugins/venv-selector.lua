vim.pack.add { 'https://github.com/linux-cultist/venv-selector.nvim' }

require('venv-selector').setup {
  ft = 'python',
  keys = { { ',v', '<cmd>VenvSelect<cr>' } },
  options = {},
  search = {},
}
