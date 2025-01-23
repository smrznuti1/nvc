local cmp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp.default_capabilities())
lspconfig.terraformls.setup({
  cmd = { "terraform-ls", "serve" },
  filetypes = { "hcl", "tf", "tfvars", "terraform" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(".terraform", ".git")(fname) or vim.fs.dirname(fname)
    -- or lspconfig.util.path.dirname(fname)
  end,
  capabilities = lsp_capabilities,
  -- init_options = {
  --   terraform = {
  --     path = "/usr/bin/terraform",
  --   },
  -- },
})

lspconfig.tflint.setup({
  -- cmd = { "tflint" },
  filetypes = { "hcl", "tf", "tfvars", "terraform" },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(".terraform", ".git")(fname) or vim.fs.dirname(fname)
  end,
  capabilities = lsp_capabilities,
})

return {}
