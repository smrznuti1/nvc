vim.pack.add { 'https://github.com/kdheepak/lazygit.nvim' }
-- plenary.nvim is provided by telescope/gitsigns/etc.
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })
