return {
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local dashboard = require("alpha.themes.theta")
    dashboard.header.val = {
      "  ███████ ███    ███ ██████  ████████",
      "  ██      ████  ████ ██   ██     ████",
      "  ███████ ██ ████ ██ ██████    ████  ",
      "       ██ ██  ██  ██ ██   ██ ████    ",
      "  ███████ ██      ██ ██   ██ ████████",
      " ",
      "    ███    ██ ██    ██ ██ ███    ███",
      "    ████   ██ ██    ██ ██ ████  ████",
      "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
      "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
      "    ██   ████   ████   ██ ██      ██",
    }
    -- dashboard.section.header.val = {
    --   "  ███████ ███    ███ ██████  ████████",
    --   "  ██      ████  ████ ██   ██     ████",
    --   "  ███████ ██ ████ ██ ██████    ████  ",
    --   "       ██ ██  ██  ██ ██   ██ ████    ",
    --   "  ███████ ██      ██ ██   ██ ████████",
    --   " ",
    --   "    ███    ██ ██    ██ ██ ███    ███",
    --   "    ████   ██ ██    ██ ██ ████  ████",
    --   "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    --   "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    --   "    ██   ████   ████   ██ ██      ██",
    -- }
    -- dashboard.section.header.opts.hl = "DashboardHeader"
    -- dashboard.section.footer.opts.hl = "DashboardFooter"
    require("alpha").setup(dashboard.config)
  end,
}
