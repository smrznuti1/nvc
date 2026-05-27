vim.pack.add { 'https://github.com/voldikss/vim-floaterm' }

local function exit_zen_if_active()
  local ok, zen = pcall(require, 'snacks.zen')
  if ok and zen.win and zen.win:valid() then zen.win:close() end
end

vim.g.floaterm_height = 0.5
vim.g.floaterm_width = 0.8
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottom'
vim.g.floaterm_autoclose = 0

vim.keymap.set({ 'n', 't', 'i' }, '<M-l>', function()
  exit_zen_if_active()
  vim.cmd 'FloatermNext'
  -- vim.api.nvim_command 'stopinsert'
end, { silent = false, noremap = true })

vim.keymap.set({ 'n', 't', 'i' }, '<M-h>', function()
  exit_zen_if_active()
  vim.cmd 'FloatermPrev'
  -- vim.api.nvim_command 'stopinsert'
end, { silent = false, noremap = true })

vim.keymap.set({ 'n', 't', 'i' }, '<M-e>', function()
  exit_zen_if_active()
  vim.cmd 'FloatermToggle'
  -- vim.api.nvim_command 'stopinsert'
end, { silent = true, noremap = true })

vim.keymap.set({ 'n', 't', 'i' }, '<M-t>', function()
  exit_zen_if_active()
  vim.cmd 'FloatermToggle terminal'
end, { desc = 'Terminal Here' })

vim.fn.execute('hi FloatermBorder guifg=#f5d16e', 'silent')
