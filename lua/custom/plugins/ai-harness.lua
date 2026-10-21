vim.pack.add { 'https://github.com/juantot9/ai-harness.nvim' }
require('ai-harness').setup {
  default_cmd = 'pi',
  window = {
    type = 'split',
    position = 'right',
    size = 0.35,
    full_height = true,
  },
}
