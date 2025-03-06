return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  config = function()
    require("CopilotChat").setup({
      debug = false, -- Enable debugging
      -- See Configuration section for rest
      vim.keymap.set(
        { "v" },
        "<leader>cc",
        "<cmd>CopilotChat<cr>",
        { desc = "Opet Copilot Chat for current selection", silent = true }
      ),
    })
  end,
}
