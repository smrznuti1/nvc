vim.pack.add { { src = 'https://github.com/smrznuti1/multicursor.nvim', version = 'main' } }

local mc = require 'multicursor-nvim'
mc.setup()

vim.keymap.set({ 'n', 'v' }, '<M-k>', function()
  for _ = 1, vim.v.count1 do
    mc.addCursor 'k'
  end
end)

vim.keymap.set({ 'n', 'v' }, '<M-j>', function()
  for _ = 1, vim.v.count1 do
    mc.addCursor 'j'
  end
end)

vim.keymap.set({ 'n', 'v' }, '<up>', function() mc.addCursor 'k' end)
vim.keymap.set({ 'n', 'v' }, '<down>', function() mc.addCursor 'j' end)

vim.keymap.set({ 'n', 'v' }, '<c-n>', function() mc.addCursor '*' end)
vim.keymap.set({ 'n', 'v' }, '<c-s>', function() mc.skipCursor '*' end)

vim.keymap.set({ 'n', 'v' }, '<left>', mc.nextCursor)
vim.keymap.set({ 'n', 'v' }, '<right>', mc.prevCursor)

vim.keymap.set({ 'n', 'v' }, '<leader>x', mc.deleteCursor)
vim.keymap.set('n', '<c-leftmouse>', mc.handleMouse)

vim.keymap.set({ 'n', 'v' }, '<M-q>', function()
  if mc.cursorsEnabled() then
    mc.disableCursors()
  else
    mc.addCursor()
  end
end)

vim.keymap.set('n', '<M-m>', function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  end
end)

vim.keymap.set('n', '<leader>A', mc.alignCursors)
vim.keymap.set('v', 'S', mc.splitCursors)
vim.keymap.set('v', 'I', mc.insertVisual)
vim.keymap.set('v', 'A', mc.appendVisual)
vim.keymap.set('v', 'M', mc.matchCursors)

vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
