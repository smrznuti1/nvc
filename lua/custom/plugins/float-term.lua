return {
  'voldikss/vim-floaterm',
    config = function ()
       vim.g.floaterm_height=0.5
       vim.g.floaterm_width=0.8
       vim.g.floaterm_wintype='float'
       vim.g.floaterm_name='cmd'
       vim.g.floaterm_position='bottom'
       vim.g.floaterm_autoclose=0
    end
}
