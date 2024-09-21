return {
  'echasnovski/mini.bufremove',
  keys = {
    {
      '<leader>C',
      function()
        require('mini.bufremove').delete(0, true)
      end,
      desc = 'Close Buffer',
    },
  },
}
