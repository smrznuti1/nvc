-- nvim-treesitter is installed in init.lua Section 8.
-- This file extends the parser list and registers extra filetypes.

local ts = require 'nvim-treesitter'
local parsers = {
  'bash',
  'comment',
  'css',
  'diff',
  'dockerfile',
  'elixir',
  'git_config',
  'gitcommit',
  'gitignore',
  'groovy',
  'go',
  'heex',
  'hcl',
  'html',
  'http',
  'java',
  'javascript',
  'jsdoc',
  'json',
  'json5',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'regex',
  'rst',
  'rust',
  'scss',
  'ssh_config',
  'sql',
  'terraform',
  'typst',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'helm',
}

ts.install(parsers)

vim.treesitter.language.register('groovy', 'Jenkinsfile')
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
