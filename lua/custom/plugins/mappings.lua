-- Funcs
local function change_cwd_to_terminal_path()
  local function find_git_root(path)
    local git_path = path .. '/.git'
    if vim.loop.fs_stat(git_path) then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
      return nil
    end
    return find_git_root(parent)
  end
  vim.defer_fn(function()
    local git_root = find_git_root(vim.fn.getreg '+')
    if git_root then
      vim.cmd('silent! tc ' .. git_root)
    else
      vim.cmd('silent! tc ' .. vim.fn.getreg '+')
    end
  end, 100)
end

function close_buffer_force()
  local buftype = vim.bo.buftype
  if buftype == 'terminal' then
    vim.api.nvim_command 'q'
  else
    vim.api.nvim_command 'q!'
  end
end

_G.change_cwd_to_terminal_path = change_cwd_to_terminal_path

local builtin = require 'telescope.builtin'
--
-- Workdir
vim.keymap.set('n', '<leader>b;', ':let @+ = expand("%:p")<cr>', { desc = 'Copy Name' })
vim.keymap.set('n', '<leader>t;', ':tc %:p:h<cr>', { desc = 'Change Directory to file path' })
vim.keymap.set('n', '<leader>tr', ':tc <C-r>+<cr>', { desc = 'Change Directory to file path' })
vim.keymap.set('n', '<leader>-', ':tc -<cr>:pwd<cr>', { desc = 'Cd -' })
vim.keymap.set('n', '<C-p>', ':pwd<cr>', { noremap = false, desc = 'Print Working Directory' })

vim.api.nvim_set_keymap(
  't',
  '<M-a>',
  'pwc<CR><C-\\><C-n>:lua change_cwd_to_terminal_path()<CR>',
  { noremap = true, silent = true, desc = 'Change to terminal path' }
)

vim.keymap.set('n', '<leader>,', function()
  local output = string.gsub(vim.fn.expand '%', '.md', '.pdf')
  local command = ':!pandoc -t pdf --pdf-engine tectonic -o ' .. output .. ' --section-divs=true % ; okular ' .. output
  vim.fn.execute(command)
end)

-- Files
vim.keymap.set('n', '<leader>L', ':!ls<cr>', { desc = 'List Items' })
vim.keymap.set('n', '<leader>sF', function()
  builtin.find_files { hidden = true }
end, { desc = '[S]earch [F]iles (Hidden included)' })

-- LSP
vim.keymap.set('n', 'gv', ':vs | lua vim.lsp.buf.definition()<cr>', { desc = 'Goto Definition split vertical' })
vim.keymap.set('n', 'gs', ':sp | lua vim.lsp.buf.definition()<cr>', { desc = 'Goto Definition split horizontal' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code action' })

-- Fonts
vim.keymap.set('n', '<C-->', ':DecreaseFont<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-=>', ':IncreaseFont<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-+>', ':IncreaseFont<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-0>', ':ResetFontSize<CR>', { noremap = true, silent = true })

-- Splits
vim.keymap.set('n', '|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
vim.keymap.set('n', '\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>H', '<cmd>nohl<cr>', { desc = 'Horizontal Split' })

-- Buffer
vim.keymap.set('n', '<leader>bb', '<cmd>BufferLinePick<CR>', { desc = 'Pick buffer' })
-- vim.keymap.set('n', '<C-s>', '<cmd>w!<cr>', { desc = 'Force write' })
vim.api.nvim_set_keymap('n', '<leader>q', ':lua close_buffer_force()<CR>', { noremap = true, silent = true, desc = 'Close buffer' })
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Buffer Previous' })
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<CR>', { desc = 'Buffer Next' })
vim.keymap.set('n', '<leader>Q', ':bd!<cr>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>D', ':!ri -Force%<cr>', { noremap = true, desc = 'Delete Item' })

-- Tabs
vim.keymap.set('n', '<leader>te', ':tabe %<cr>', { desc = 'Open in New Tab' })
vim.keymap.set('n', '<leader>tq', ':tabclose<cr>', { desc = 'Open in New Tab' })
vim.keymap.set('n', ']t', '<cmd>tabnext<cr>', { desc = 'Tab Next' })
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = 'Tab Previous' })

-- Terminal
vim.keymap.set('n', '<leader>T', ':term<cr>', { desc = 'Terminal Here' })
vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Terminal left window navigation' })
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Terminal down window navigation' })
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Terminal up window navigation' })
vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Terminal right window navigation' })

-- Highlight
vim.cmd 'autocmd CursorMoved * set nohlsearch'
vim.api.nvim_set_keymap('n', 'n', 'n:set hlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-n>', '<S-n>:set hlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '#', '#:set hlsearch<CR>', { noremap = true, silent = true })

-- Git
vim.keymap.set('n', '<leader>gb', ':G branch<cr>', { desc = 'Git branch' })
vim.keymap.set('n', '<leader>gB', ':G branch -a <cr>', { desc = 'Git branch all' })
vim.keymap.set('n', '<leader>gp', ':G pull<cr>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>gP', ':G push<cr>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gF', ':G push --force<cr>', { desc = 'Git push force' })
vim.keymap.set('n', '<leader>gf', ':G fetch<cr>', { desc = 'Git fetch' })
vim.keymap.set('n', '<leader>gA', ':G add -A<cr>', { desc = 'Git stage all' })
vim.keymap.set('n', '<leader>ga', ':G add %<cr>', { desc = 'Git stage current' })
-- vim.keymap.set('n', '<leader>gc', ':G commit -m ', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>gs', ':G<cr>', { desc = 'Git status' })
-- vim.keymap.set('n', '<leader>gk', ':G checkout ', { desc = 'Git checkout' })

vim.keymap.set('n', '<leader>gk', function()
  local checkout_destination = vim.fn.input 'Checkout Destination: '
  vim.cmd('G checkout ' .. checkout_destination)
end, { desc = 'Git checkout' })

vim.keymap.set('n', '<leader>gc', function()
  local commit_message = vim.fn.input 'Commit message: '
  vim.cmd('G commit -m "' .. commit_message .. '"')
end, { desc = 'Git commit' })

vim.keymap.set('n', '<leader>gl', function()
  local number_of_commits = vim.fn.input 'Number of commits: '
  vim.cmd('G log --oneline -n "' .. number_of_commits .. '"')
end, { desc = 'Git log' })

return {}
