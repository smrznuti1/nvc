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

return {
  "gelguy/wilder.nvim",
  config = function()
    require("wilder").setup({
      modes = { ":", "/", "?" },
      accept_key = "<C-l>",
      reject_key = "<C-h>",
      accept_completion_auto_select = 0,
    })
  end,
}
