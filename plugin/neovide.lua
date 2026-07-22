if vim.g.neovide then
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  -- local alpha = function() return string.format('%x', math.floor((255 * vim.g.transparency) or 0.8)) end
  -- Transparency
  -- vim.g.neovide_transparency = 0.8
  vim.g.neovide_opacity = 1
  vim.g.neovide_normal_opacity = 0.95
  -- Blur
  -- vim.g.neovide_window_blurred = true
  -- vim.g.neovide_floating_blur_amount_x = 1.0
  -- vim.g.neovide_floating_blur_amount_y = 1.0
  -- vim.g.neovide_background_color = '#0f1117' .. alpha()
  vim.g.neovide_fullscreen = false

  local guifont = 'FiraCode Nerd Font:h18'
  local guifont_synced = false
  local function font_cmd(cmd)
    return function()
      if not guifont_synced then
        guifont_synced = true
        vim.o.guifont = guifont
      end
      vim.cmd(cmd)
    end
  end
  for _, map in ipairs {
    { '<C-->', 'DecreaseFont' },
    { '<C-=>', 'IncreaseFont' },
    { '<C-+>', 'IncreaseFont' },
    { '<C-0>', 'ResetFontSize' },
  } do
    vim.keymap.set('n', map[1], font_cmd(map[2]), { noremap = true, silent = true })
  end

  for _, key in ipairs { '<C-v>', '<C-S-v>' } do
    vim.keymap.set({ 'i', 'c' }, key, '<C-r>+', { desc = 'Paste from clipboard' })
    vim.keymap.set('t', key, '<C-\\><C-n>"+pi', { desc = 'Paste from clipboard' })
  end
  vim.keymap.set({ 'n', 'x' }, '<C-S-v>', '"+p', { desc = 'Paste from clipboard' })
end
