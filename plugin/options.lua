vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml' },
  callback = function() vim.treesitter.start() end,
})
