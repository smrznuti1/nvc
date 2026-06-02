vim.pack.add {
  'https://github.com/jay-babu/mason-null-ls.nvim',
  'https://github.com/nvimtools/none-ls.nvim',
}

require('mason-null-ls').setup {
  automatic_installation = true,
  ensure_installed = {
    'stylua',
    'jq',
    'fixjson',
    -- 'lua-language-server',
    'texlab',
    'latexindent',
    'actionlint',
    'bibtex-tidy',
    'commitlint',
    'debugpy',
    'docker-compose-language-service',
    'dockerfile-language-server',
    'gitleaks',
    'cmakelang',
    'cmake-language-server',
    'bash-language-server',
    'shellcheck',
    'beautysh',
    'markdownlint',
  },
  handlers = {
    markdownlint = function()
      local nls = require 'null-ls'
      nls.register(nls.builtins.diagnostics.markdownlint.with {
        extra_args = { '--config', vim.fn.expand '~/.config/nvim/.markdownlint.yaml' },
      })
    end,
  },
}

require('mason-lspconfig').setup {
  automatic_enable = true,
}
