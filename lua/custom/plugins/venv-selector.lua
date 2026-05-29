vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/linux-cultist/venv-selector.nvim',
}

require('venv-selector').setup {
  options = {}, -- plugin-wide options
  search = {}, -- custom search definitions
}

vim.keymap.set('n', ',v', '<cmd>VenvSelect<cr>', { desc = 'Select VirtualEnv' })

