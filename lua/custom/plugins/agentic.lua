vim.pack.add { 'https://github.com/carlos-algms/agentic.nvim' }

local agentic = require 'agentic'

agentic.setup {
  provider = 'claude-agent-acp',
  acp_providers = {
    ['opencode-acp'] = {
      env = {
        NODE_EXTRA_CA_CERTS = vim.fs.normalize '~/.local/share/egzakta-ca/mkcert-egwguard-rootCA.pem',
      },
    },
  },
  acp_configs = {
    session_cwd = function() return vim.fs.normalize '~/tmp' end,
  },
}

require('which-key').add { { '<leader>a', group = 'AI/Agentic' } }

local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc }) end

map('n', '<leader>ac', function() agentic.toggle { auto_add_to_context = false } end, 'Toggle chat')
map('n', '<leader>an', agentic.new_session, 'New session')
map('n', '<leader>ar', function()
  vim.cmd 'tcd ~/tmp'
  agentic.restore_session()
end, 'Restore session')
map('n', '<leader>al', agentic.select_session, 'List live sessions')
map('n', '<leader>ab', agentic.add_file, 'Add current file')
map('x', '<leader>as', agentic.add_selection, 'Add selection')
map('n', '<leader>ad', agentic.add_current_line_diagnostics, 'Add line diagnostics')
map('n', '<leader>aD', agentic.add_buffer_diagnostics, 'Add buffer diagnostics')
map('n', '<leader>ax', agentic.stop_generation, 'Stop generation')
