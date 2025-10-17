return {
  "gelguy/wilder.nvim",
  config = function()
    local wilder = require("wilder")
    wilder.setup({
      modes = { ":", "/", "?" },
      accept_key = "<C-l>",
      reject_key = "<C-h>",
      accept_completion_auto_select = 0,
    })

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        highlighter = wilder.basic_highlighter(),
        min_width = "100%", -- minimum height of the popupmenu, can also be a number
        -- min_height = "50%", -- to set a fixed height, set max_height to the same value
        reverse = 0,
        highlights = {
          border = "Normal", -- highlight to use for the border
        },
        -- 'single', 'double', 'rounded' or 'solid'
        -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
        border = "rounded",
        pumblend = 30,
      }))
    )
    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          -- sets the language to use, 'vim' and 'python' are supported
          language = "python",
          -- 0 turns off fuzzy matching
          -- 1 turns on fuzzy matching
          -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
          fuzzy = 1,
          -- fuzzy = 2,
        }),
        wilder.python_search_pipeline({
          -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
          pattern = wilder.python_fuzzy_pattern(),
          -- omit to get results in the order they appear in the buffer
          sorter = wilder.python_difflib_sorter(),
          -- can be set to 're2' for performance, requires pyre2 to be installed
          -- see :h wilder#python_search() for more details
          engine = "re",
        }),
        wilder.python_file_finder_pipeline({
          -- to use ripgrep : {'rg', '--files'}
          -- to use fd      : {'fd', '-tf'}
          -- file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
          file_command = { "fd", "-tf" },
          -- to use fd      : {'fd', '-td'}
          -- dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
          dir_command = { "fd", "-td" },
          -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
          -- found at https://github.com/nixprime/cpsm
          filters = { "fuzzy_filter", "difflib_sorter" },
        })
      ),
    })
  end,
}

-- return {
--   "vzze/cmdline.nvim",
--   lazy = false,
--
--   config = function()
--     require("cmdline").setup({
--       cmdtype = ":", -- you can also add / and ? by using ":/?"
--       -- as a string
--
--       window = {
--         matchFuzzy = true,
--         offset = 1, -- depending on 'cmdheight' you might need to offset
--         debounceMs = 10, -- the lower the number the more responsive however
--         -- more resource intensive
--       },
--
--       hl = {
--         default = "Pmenu",
--         selection = "PmenuSel",
--         directory = "Directory",
--         substr = "LineNr",
--       },
--
--       column = {
--         maxNumber = 6,
--         minWidth = 20,
--       },
--
--       binds = {
--         next = "<Tab>",
--         back = "<S-Tab>",
--       },
--     })
--   end,
-- }
-- return {
--   "smolck/command-completion.nvim",
--   lazy = false,
--   config = function()
--     require("command-completion").setup({
--       border = nil, -- What kind of border to use, passed through directly to `nvim_open_win()`,
--       -- see `:help nvim_open_win()` for available options (e.g. 'single', 'double', etc.)
--       max_col_num = 5, -- Maximum number of columns to display in the completion window
--       min_col_width = 20, -- Minimum width of completion window columns
--       use_matchfuzzy = true, -- Whether or not to use `matchfuzzy()` (see `:help matchfuzzy()`)
--       -- to order completion results
--       highlight_selection = true, -- Whether or not to highlight the currently
--       -- selected item, not sure why this is an option tbh
--       highlight_directories = true, -- Whether or not to higlight directories with
--       -- the Directory highlight group (`:help hl-Directory`)
--       tab_completion = true, -- Whether or not tab completion on displayed items is enabled
--     })
--   end,
-- }
