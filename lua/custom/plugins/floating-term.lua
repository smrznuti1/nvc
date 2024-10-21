return {
  'numToStr/FTerm.nvim',
  lazy = false,
  config = function()
    require('FTerm').setup {
      border = 'double',
      dimensions = {
        height = 0.5,
        width = 0.9,
        x = 0.5,
        y = 1,
      },
    }
    vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
    vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
  end,
}
