-- local cmp = require("blink.cmp")
-- local lspconfig = require("lspconfig")
-- local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
-- lsp_capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp.get_lsp_capabilities())
-- lspconfig.azure_pipelines_ls.setup({
--   cmd = { "azure-pipelines-language-server", "--stdio" },
--   filetypes = { "yaml", "yml" },
--   root_dir = function(fname)
--     return lspconfig.util.root_pattern(".git")(fname) or vim.fs.dirname(fname)
--   end,
--   single_file_support = true,
--   capabilities = lsp_capabilities,
--   settings = {
--     yaml = {
--       schemas = {
--         ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
--           "pipelines/*.y*l",
--           "/azure-pipeline*.y*l",
--           "/*.azure*",
--           "Azure-Pipelines/**/*.y*l",
--           "Pipelines/*.y*l",
--         },
--       },
--     },
--   },
-- })

return {}
