vim.pack.add { 'https://github.com/voldikss/vim-floaterm' }

local function exit_zen_if_active()
  local ok, zen = pcall(require, 'snacks.zen')
  local closed = false
  if
    ok
    and zen.win
    and zen.win:valid()
    and vim.api.nvim_get_option_value('filetype', { buf = zen.win.buf }) == 'floaterm'
  then
    zen.win:close()
    closed = true
  end
  return closed
end

local function execute_floaterm_with_zen(...)
  local closed = exit_zen_if_active()

  local ok, _ = pcall(vim.fn.execute, ...)

  if not ok then error('Failed to execute' .. select(1, ...), 1) end

  if closed then
    local ok, zen = pcall(require, 'snacks.zen')
    if ok then vim.defer_fn(function() zen.zoom() end, 10) end
  end
end

vim.g.floaterm_height = 0.5
vim.g.floaterm_width = 0.8
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottom'
vim.g.floaterm_autoclose = 0

vim.keymap.set(
  { 'n', 't', 'i' },
  '<M-l>',
  function() execute_floaterm_with_zen 'FloatermNext' end,
  { silent = false, noremap = true }
)

vim.keymap.set(
  { 'n', 't', 'i' },
  '<M-h>',
  function() execute_floaterm_with_zen 'FloatermPrev' end,
  { silent = false, noremap = true }
)

vim.keymap.set({ 'n', 't', 'i' }, '<M-e>', function()
  exit_zen_if_active()
  local buf_ft = vim.bo.filetype
  if buf_ft == 'floaterm' then
    vim.cmd 'FloatermHide'
  else
    local output = vim.fn.execute 'FloatermShow'
    if string.find(output, 'No floaterms with the bufnr or name') then print '\nEmpty' end
  end

  -- vim.api.nvim_command 'stopinsert'
end, { silent = true, noremap = true })

vim.keymap.set({ 'n', 't', 'i' }, '<M-t>', function()
  exit_zen_if_active()
  vim.cmd 'FloatermToggle terminal'
end, { desc = 'Terminal Here' })

vim.fn.execute('hi FloatermBorder guifg=#f5d16e', 'silent')
