return {
  -- "folke/tokyonight.nvim",
  -- lazy = false,
  -- priority = 1000,
  -- opts = {},
  -- config = function()
  --   local _, _, tokyoconf = require("tokyonight").load()
  --   tokyoconf.transparent = false
  --
  --   tokyoconf.on_highlights = function(highlights, colors)
  --     highlights.LineNr = {
  --       fg = "#4A599C",
  --     }
  --     highlights.LineNrAbove = {
  --       fg = "#4A599C",
  --     }
  --     highlights.LineNrBelow = {
  --       fg = "#4A599C",
  --     }
  --   end
  --
  --   require("tokyonight").setup(tokyoconf)
  --   vim.cmd.colorscheme("tokyonight-night")
  --
  --   vim.api.nvim_create_user_command("TT", function()
  --     tokyoconf.transparent = not tokyoconf.transparent
  --     require("tokyonight").setup(tokyoconf)
  --     vim.cmd.colorscheme("tokyonight-night")
  --   end, {})
  -- end,
  "comfysage/cuddlefish.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local configuration = {
      theme = {
        accent = "pink",
      },
      editor = {
        transparent_background = false,
      },
      style = {
        tabline = { "reverse" },
        search = { "italic", "reverse" },
        incsearch = { "italic", "reverse" },
        types = { "italic" },
        keyword = { "italic" },
        comment = { "italic" },
      },
      overrides = function(colors)
        return {
          CursorLineNr = { "#EC672E" },
          LineNr = { "#8d72ad" },
          OilDir = { "#cc6a1f" },
          OilDirHidden = { "#6e391a" },
          LeapBackdrop = { "#613869" },
          Cursor = { fg = "#ede874", bg = "#7d5a8c" },
          Visual = { bg = "#5d4f63" },
        }
      end,
    }

    require("cuddlefish").setup(configuration)
    vim.cmd.colorscheme("cuddlefish")

    vim.api.nvim_create_user_command("TT", function()
      configuration.editor.transparent_background = not configuration.editor.transparent_background
      require("cuddlefish").setup(configuration)
      vim.cmd.colorscheme("cuddlefish")
    end, {})
  end,
}
