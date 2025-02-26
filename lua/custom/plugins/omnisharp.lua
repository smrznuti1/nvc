local lspconfig = require 'lspconfig'
local bundle_path = '~/Lsp/omnisharp/'
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

lspconfig.omnisharp.setup {
  capabilities = capabilities,
  bundle_path = bundle_path,
  filetypes = { 'cs' },
}
return {}
