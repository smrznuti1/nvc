return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    local _, _, tokyoconf = require("tokyonight").load()
    tokyoconf.transparent = true
    require("tokyonight").setup(tokyoconf)
    vim.cmd.colorscheme("tokyonight-night")

    vim.api.nvim_create_user_command("TT", function()
            tokyoconf.transparent = not tokyoconf.transparent
      require("tokyonight").setup(tokyoconf)
      vim.cmd.colorscheme("tokyonight-night")
    end, {})
  end,
}
