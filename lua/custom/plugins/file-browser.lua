return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  -- You don't need to set any of these options.
  -- IMPORTANT!: this is only a showcase of how you can set default options!
  lazy = false,
  config = function()
    local fb_actions = require("telescope").extensions.file_browser.actions
    require("telescope").setup({
      extensions = {
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-q>"] = function(bufnmr)
                vim.fn.execute("q!", "silent")
              end,
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
    })
    require("telescope").load_extension("file_browser")
  end,
}
