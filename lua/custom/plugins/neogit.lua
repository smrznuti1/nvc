vim.pack.add { 'https://github.com/NeogitOrg/neogit' }

require('neogit').setup {
  integrations = { codediff = true },
  diff_viewer = 'codediff',
  mappings = {
    status = {
      ['<c-x>'] = false,
      ['<c-p>'] = function() vim.notify(vim.fn.getcwd()) end,
    },
  },
}
