-- return {
--   'jose-elias-alvarez/null-ls.nvim',
--   opts = function(_, config)
--     -- config variable is the default configuration table for the setup function call
--     local null_ls = require 'null-ls'
--
--     -- Check supported formatters and linters
--     -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
--     -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--     config.sources = {
--       -- Set a formatter
--       null_ls.builtins.formatting.stylua,
--       null_ls.builtins.formatting.prettier,
--     }
--     return config -- return final config table
--   end,
-- }
local capabilities = vim.lsp.protocol.make_client_capabilities()
return {
  'jose-elias-alvarez/null-ls.nvim',
  capabilities = capabilities,

  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.fixjson,
        null_ls.builtins.formatting.latexindent,
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.completion.spell,
      },
    }
  end,
}
