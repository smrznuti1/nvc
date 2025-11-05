local cmp = require("blink.cmp")
-- local lspconfig = require("lspconfig")
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp.get_lsp_capabilities())
vim.lsp.config("tflint", {
  default_config = {
    cmd = { "tflint", "--langserver" },
    filetypes = { "hcl", "tf", "tfvars" },
    root_markers = {
      ".terraform",
      ".git",
    },
    -- root_dir = function(fname)
    --   return lspconfig.util.root_pattern(".terraform", ".git")(fname)
    --     or lspconfig.util.path.dirname(fname)
    -- end,
    capabilities = lsp_capabilities,
  },
})

return {}
