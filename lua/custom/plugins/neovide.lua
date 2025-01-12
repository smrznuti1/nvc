if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.8
  vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h12" -- text below applies for VimScript
  vim.opt.linespace = 0
  vim.g.neovide_padding_top = 10
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10
  local alpha = function()
    return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
  end
  -- Transparency
  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 1.0
  -- Blur
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 5.0
  vim.g.neovide_floating_blur_amount_y = 5.0
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_fullscreen = true
end

return {}
