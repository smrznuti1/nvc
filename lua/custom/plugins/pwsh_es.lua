local lspconfig = require 'lspconfig'
local bundle_path = '~/Lsp/PowerShellEditorServices'
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
lspconfig.powershell_es.setup {
  capabilities = capabilities,
  bundle_path = bundle_path,
  filetypes = { 'ps1' },
  init_options = { enableProfileLoading = false },
}

return {}
