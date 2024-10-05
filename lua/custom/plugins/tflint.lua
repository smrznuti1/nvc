local lspconfig = require 'lspconfig'
local cmp = require 'cmp_nvim_lsp'
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, cmp.default_capabilities())
lspconfig.tflint.setup = {
  default_config = {
    cmd = { 'tflint', '--langserver' },
    filetypes = { 'hcl', 'tf', 'tfvars' },
    root_dir = function(fname)
      return lspconfig.util.root_pattern('.terraform', '.git')(fname) or lspconfig.util.path.dirname(fname)
    end,
    capabilities = lsp_capabilities,
  },
}


return {}
