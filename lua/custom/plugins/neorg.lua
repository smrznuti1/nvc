return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {}, -- We added this line!
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*norg*",
      callback = function()
        vim.fn.feedkeys("gg=G``")
        -- local key = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
        -- vim.api.nvim_feedkeys("gg=G", "n", true)
        -- vim.api.nvim_feedkeys(key, "n", true)
      end,
    })
  end,
}
