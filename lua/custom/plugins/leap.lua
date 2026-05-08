vim.pack.add {
  'https://codeberg.org/andyg/leap.nvim',
  'https://github.com/tpope/vim-repeat',
}

vim.keymap.set({ 'n', 'x', 'o' }, '<M-f>', '<Plug>(leap)')
vim.keymap.set({ 'n', 'x', 'o' }, '<M-S-F>', '<Plug>(leap-from-window)')
