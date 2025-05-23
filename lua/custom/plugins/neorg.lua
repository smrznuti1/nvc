return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {}, -- We added this line!
        --
        -- ["core.completion"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = {},
        -- ["core.latex.renderer"] = {},
        ["core.summary"] = {},
        --
        ["core.text-objects"] = {},
        ["core.autocommands"] = {},
        ["core.clipboard"] = {},
        ["core.dirman.utils"] = {},
        ["core.fs"] = {},
        ["core.highlights"] = {},
        --
        -- ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.neorgcmd"] = {},
        ["core.neorgcmd.commands.return"] = {},
        ["core.queries.native"] = {},
        ["core.scanner"] = {},
        ["core.storage"] = {},
        ["core.syntax"] = {},
        ["core.tempus"] = {},
        ["core.ui"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    })
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "norg",
      callback = function()
        vim.keymap.set({ "n" }, "<leader>f", function()
          vim.fn.feedkeys("gg=G``")
        end, { desc = "Format buffer", buffer = true })
      end,
    })
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   pattern = "*norg*",
    --   callback = function()
    --     vim.fn.feedkeys("gg=G``")
    --     -- local key = vim.api.nvim_replace_termcodes("<C-o>", true, false, true)
    --     -- vim.api.nvim_feedkeys("gg=G", "n", true)
    --     -- vim.api.nvim_feedkeys(key, "n", true)
    --   end,
    -- })
  end,
}
