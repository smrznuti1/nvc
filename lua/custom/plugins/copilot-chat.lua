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
      model = "gpt-4.1",
      temperature = 0.0,
      window = {
        layout = "float",
        width = 0.8, -- Fixed width in columns
        height = 0.6, -- Fixed height in rows
        border = "rounded", -- 'single', 'double', 'rounded', 'solid'
        title = "AI Assistant",
        zindex = 50, -- Ensure window stays on top
      },

      headers = {
        user = "Filip",
        assistant = "Copilot",
        tool = "Tool",
      },

      separator = "━━",
      -- auto_fold = true,

      -- See Configuration section for rest
      --
      vim.api.nvim_create_user_command("CC", function()
        vim.cmd("CopilotChatToggle")
        vim.cmd("wincmd =")
      end, {}),
      vim.keymap.set(
        { "v" },
        "<leader>cc",
        "<cmd>CC<cr>",
        { desc = "Opet Copilot Chat for current selection", silent = true }
      ),
      vim.keymap.set(
        { "n", "i", "v", "t" },
        "<M-c>",
        "<cmd>CC<cr>",
        { desc = "Opet Copilot Chat", silent = true }
      ),
    })
  end,
}
