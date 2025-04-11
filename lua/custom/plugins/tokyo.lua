return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    local _, _, tokyoconf = require("tokyonight").load()
    tokyoconf.transparent = true

    tokyoconf.on_highlights = function(highlights, colors)
      highlights.LineNr = {
        fg = "#4A599C",
      }
      highlights.LineNrAbove = {
        fg = "#4A599C",
      }
      highlights.LineNrBelow = {
        fg = "#4A599C",
      }
    end

    require("tokyonight").setup(tokyoconf)
    vim.cmd.colorscheme("tokyonight-night")

    vim.api.nvim_create_user_command("TT", function()
            tokyoconf.transparent = not tokyoconf.transparent
      require("tokyonight").setup(tokyoconf)
      vim.cmd.colorscheme("tokyonight-night")
    end, {})
  end,
}
