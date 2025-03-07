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
      --
      vim.api.nvim_create_user_command("CC", function()
        vim.cmd("CopilotChat")
        vim.cmd("wincmd =")
      end, {}),
      vim.keymap.set(
        { "v" },
        "<leader>cc",
        "<cmd>CC<cr>",
        { desc = "Opet Copilot Chat for current selection", silent = true }
      ),
    })
  end,
}
