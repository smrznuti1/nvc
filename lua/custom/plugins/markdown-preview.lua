return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  init = function()
    local g = vim.g
    g.mkdp_auto_start = 0
    g.mkdp_auto_close = 1
    g.mkdp_refresh_slow = 0
    g.mkdp_command_for_global = 0
    g.mkdp_open_to_the_world = 0
    g.mkdp_open_ip = ""
    g.mkdp_browser = "zen-browser"
    g.mkdp_echo_preview_url = 0
    g.mkdp_browserfunc = ""
    g.mkdp_theme = "dark"
    g.mkdp_filetypes = { "markdown" }
    g.mkdp_page_title = "${name}.md"
    g.mkdp_preview_options = {
      disable_sync_scroll = 0,
      disable_filename = 1,
    }
  end,
}

-- return {
--   "OXY2DEV/markview.nvim",
--   lazy = false,
--   config = function()
--     require("markview").setup({
--       preview = {
--         icon_provider = "devicons", -- "mini" or "devicons"
--       },
--     })
--   end,
--   -- For blink.cmp's completion
--   -- source
--   -- dependencies = {
--   --     "saghen/blink.cmp"
--   -- },
-- }
