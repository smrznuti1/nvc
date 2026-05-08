vim.pack.add {
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/nvimtools/none-ls-extras.nvim',
}

local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    require 'none-ls.formatting.latexindent',
    null_ls.builtins.diagnostics.actionlint,
  },
}
