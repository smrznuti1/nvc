local cmp = require("blink.cmp")
-- local lspconfig = require("lspconfig")
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp.get_lsp_capabilities())

vim.lsp.config("terraformls", {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "hcl", "tf", "tfvars", "terraform" },
  root_markers = {
    ".terraform",
    ".git",
  },
  -- root_dir = function(fname)
  --   return lspconfig.util.root_pattern(".terraform", ".git")(fname) or vim.fs.dirname(fname)
  --   -- or lspconfig.util.path.dirname(fname)
  -- end,
  capabilities = lsp_capabilities,
  -- init_options = {
  --   terraform = {
  --     path = "/usr/bin/terraform",
  --   },
  -- },
  vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    pattern = "*.tf",
    callback = function()
      vim.bo.filetype = "terraform"
    end,
  }),
})

vim.lsp.enable("terraformls")

-- vim.lsp.config("tflint", {
-- cmd = { "tflint" },
-- filetypes = { "hcl", "tf", "tfvars", "terraform" },
-- root_markers = {
--   ".terraform",
--   ".git",
-- },
-- root_dir = function(fname)
--   return lspconfig.util.root_pattern(".terraform", ".git")(fname) or vim.fs.dirname(fname)
-- end,
--   capabilities = lsp_capabilities,
-- })

return {}
