local lspconfig = require 'lspconfig'
local cmp = require 'cmp_nvim_lsp'
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, cmp.default_capabilities())
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = false },
        autopep8 = { cmd = 'autopep8', enabled = true },
        yapf = { enabled = false },
        -- linter options
        pylint = { enabled = false, executable = 'pylint' },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = true, maxLineLength = 200 },
        -- type checker
        pylsp_mypy = { enabled = true, live_mode = true, strict = false },
        -- auto-completion options
        jedi_completion = {
          enabled = false,
          fuzzy = true,
          include_params = true,
          include_class_objects = true,
          include_function_objects = true,
          resolve_at_most = 10,
          eager = true,
        },
        -- import sorting
        pyls_isort = { enabled = true },
        rope_autoimport = {
          enabled = true,
          completions = { enabled = false },
          code_actions = { enabled = true },
        },
        rope_completion = {
          enabled = true,
          eager = true,
        },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = lsp_capabilities,
  root_dir = lspconfig.util.root_pattern('pyproject.toml', 'requirements.txt', '.git'),
}

return {}
