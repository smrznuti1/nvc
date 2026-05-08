vim.pack.add { 'https://github.com/arminveres/md-pdf.nvim' }
require('md-pdf').setup { toc = false }
vim.keymap.set('n', '<leader>,', function() require('md-pdf').convert_md_to_pdf() end, { desc = 'Markdown preview' })
