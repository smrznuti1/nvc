-- local lspconfig = require 'lspconfig'
local bundle_path = "~/Lsp/PowerShellEditorServices"
local capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities =
  vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
vim.lsp.config("powershell_es", {
  capabilities = capabilities,
  bundle_path = bundle_path,
  filetypes = { "ps1" },
  init_options = { enableProfileLoading = false },
})

vim.lsp.enable("powershell_es")

