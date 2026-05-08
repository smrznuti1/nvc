-- Ensure snacks.nvim loaded before claudecode setup so the 'snacks' terminal
-- provider is available (snacks.lua runs setup later with full opts).
vim.pack.add { 'https://github.com/folke/snacks.nvim' }
require 'snacks'

vim.pack.add { 'https://github.com/coder/claudecode.nvim' }

do
  local orig = vim.notify
  vim.notify = function(msg, level, opts)
    if type(msg) == 'string' and msg:find('ECONNRESET', 1, true) then return end
    return orig(msg, level, opts)
  end
end

require('claudecode').setup {
  port_range = { min = 10000, max = 65535 },
  auto_start = true,
  log_level = 'info',
  terminal_cmd = nil,

  focus_after_send = false,

  track_selection = true,
  visual_demotion_delay_ms = 50,

  terminal = {
    split_side = 'right',
    split_width_percentage = 0.30,
    provider = 'snacks',
    auto_close = true,
    snacks_win_opts = {
      position = 'float',
      width = 0.8,
      height = 0.8,
      border = 'double',
      backdrop = 80,
      keys = {},
    },
    provider_opts = {
      external_terminal_cmd = nil,
    },
  },

  diff_opts = {
    auto_close_on_accept = true,
    vertical_split = true,
    open_in_new_tab = true,
    keep_terminal_focus = true,
  },
}

vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
vim.keymap.set('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
vim.keymap.set('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Select Claude model' })
vim.keymap.set('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })
vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

-- Filetype-specific TreeAdd binding for file-explorer buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
  callback = function(args)
    vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { buffer = args.buf, desc = 'Add file' })
  end,
})
