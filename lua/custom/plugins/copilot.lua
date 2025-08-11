return {
  "zbirenbaum/copilot.lua",
  lazy = false,
  opts = {
    filetypes = {
      ["*"] = true,
    },
    panel = {
      auto_refresh = false,
      keymap = {
        accept = "<CR>",
        jump_prev = "[[",
        jump_next = "]]",
        refresh = "gr",
        open = "<M-CR>",
      },
    },
    suggestion = {
      auto_trigger = false,
      keymap = {
        accept = "<M-l>",
        prev = "<M-[>",
        next = "<M-]>",
        -- dismiss = "<C-]>",
      },
    },
  },
  config = function()
    require("copilot").setup()
    -- vim.cmd 'Copilot disable'
    -- vim.fn.execute("Copilot disable", "silent")
  end,
}
