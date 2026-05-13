vim.pack.add {
  'https://github.com/jay-babu/mason-null-ls.nvim',
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
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
  handlers = {},
}

require('mason-lspconfig').setup {
  automatic_enable = true,
}
