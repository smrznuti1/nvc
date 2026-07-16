vim.pack.add { 'https://github.com/NeogitOrg/neogit' }

require('neogit').setup {
  auto_show_console = true,
  auto_show_console_on = 'error',
  integrations = { codediff = true, snacks = true },
  sort_branches = 'refname',
  diff_viewer = 'codediff',
  mappings = {
    status = {
      ['<c-x>'] = false,
      ['<c-p>'] = function() vim.notify(vim.fn.getcwd()) end,
    },
  },
}
