-- Workdir
vim.keymap.set('n', '<leader>b;', ':let @+ = expand("%:p")<cr>', { desc = 'Copy Name' })
vim.keymap.set('n', '<leader>t;', ':tc %:p:h<cr>', { desc = 'Change Directory to file path' })
vim.keymap.set('n', '<leader>tr', ':tc <C-r>+<cr>', { desc = 'Change Directory to file path' })
vim.keymap.set('n', '<leader>-', ':tc -<cr>:pwd<cr>', { desc = 'Cd -' })

vim.keymap.set('n', '<leader>,', function()
  local output = string.gsub(vim.fn.expand '%', '.md', '.pdf')
  local command = ':!pandoc -t pdf --pdf-engine tectonic -o ' .. output .. ' --section-divs=true % ; okular ' .. output
  vim.fn.execute(command)
end)

vim.keymap.set('n', '<leader>L', ':!ls<cr>', { desc = 'List Items' })

-- LSP
vim.keymap.set('n', 'gv', ':vs | lua vim.lsp.buf.definition()<cr>', { desc = 'Goto Definition split vertical' })
vim.keymap.set('n', 'gs', ':sp | lua vim.lsp.buf.definition()<cr>', { desc = 'Goto Definition split horizontal' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Fonts
vim.keymap.set('n', '<C-->', ':DecreaseFont<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-=>', ':IncreaseFont<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-+>', ':IncreaseFont<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-0>', ':ResetFontSize<CR>', { noremap = true, silent = true })

-- Splits
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>H', '<cmd>nohl<cr>', { desc = 'Horizontal Split' })

-- Buffer
vim.keymap.set('n', '<leader>bb', '<cmd>BufferLinePick<CR>', { desc = 'Pick buffer' })
vim.keymap.set('n', '<C-s>', '<cmd>w!<cr>', { desc = 'Force write' })
vim.keymap.set('n', '<C-q>', '<cmd>q!<cr>', { desc = 'Force quit' })
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Buffer Previous' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<CR>', { desc = 'Buffer Next' })
vim.keymap.set('n', '<leader>Q', ':bd!<cr>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>D', ':!ri -Force %<cr>', { desc = 'Delete Item' })

-- Tabs
vim.keymap.set('n', '<leader>be', ':tabe %<cr>', { desc = 'Open in New Tab' })
vim.keymap.set('n', '<leader>tq', ':tabclose<cr>', { desc = 'Open in New Tab' })
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = 'Tab Previous' })
vim.keymap.set('n', ']t', '<cmd>tabNext<cr>', { desc = 'Tab Next' })
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = 'Tab Previous' })

-- Terminal
vim.keymap.set('n', '<leader>T', ':term<cr>', { desc = 'Terminal Here' })
vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Terminal left window navigation' })
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Terminal down window navigation' })
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Terminal up window navigation' })
vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Terminal right window navigation' })

return {}
