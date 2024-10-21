return {
  'numToStr/FTerm.nvim',
  lazy = false,
  config = function()
    require('FTerm').setup {
      ---Filetype of the terminal buffer
      ---@type string
      ft = 'FTerm',

      ---Command to run inside the terminal
      ---NOTE: if given string[], it will skip the shell and directly executes the command
      ---@type fun():(string|string[])|string|string[]
      cmd = os.getenv 'SHELL',

      ---Neovim's native window border. See `:h nvim_open_win` for more configuration options.
      border = 'single',

      ---Close the terminal as soon as shell/command exits.
      ---Disabling this will mimic the native terminal behaviour.
      ---@type boolean
      auto_close = true,

      ---Highlight group for the terminal. See `:h winhl`
      ---@type string
      hl = 'Normal',

      ---Transparency of the floating window. See `:h winblend`
      ---@type integer
      blend = 0,

      ---Object containing the terminal window dimensions.
      ---The value for each field should be between `0` and `1`
      ---@type table<string,number>
      dimensions = {
        height = 0.5,
        width = 0.9,
        x = 0.5,
        y = 1,
      },

      ---Replace instead of extend the current environment with `env`.
      ---See `:h jobstart-options`
      ---@type boolean
      clear_env = false,

      ---Map of environment variables extending the current environment.
      ---See `:h jobstart-options`
      ---@type table<string,string>|nil
      env = nil,

      ---Callback invoked when the terminal exits.
      ---See `:h jobstart-options`
      ---@type fun()|nil
      on_exit = nil,

      ---Callback invoked when the terminal emits stdout data.
      ---See `:h jobstart-options`
      ---@type fun()|nil
      on_stdout = nil,

      ---Callback invoked when the terminal emits stderr data.
      ---See `:h jobstart-options`
      ---@type fun()|nil
      on_stderr = nil,
    }
    vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
    vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
    vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })
  end,
}
