vim.pack.add { 'https://github.com/qvalentin/helm-ls.nvim' }

vim.lsp.config('helm_ls', {
  settings = {
    helm_ls = {
      yamlls = {
        path = 'yaml-language-server',
      },
    },
  },
})
vim.lsp.enable 'helm_ls'
