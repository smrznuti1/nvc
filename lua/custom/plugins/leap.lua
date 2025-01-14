return {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = {
    "tpope/vim-repeat",
  },
  config = function()
    -- require("leap").create_default_mappings()
    vim.keymap.set({ "n", "x", "o" }, "<M-m>", "<Plug>(leap)")
    -- vim.keymap.set({ "n", "x", "o" }, "zs", "<Plug>(leap-forward)")
    -- vim.keymap.set({ "n", "x", "o" }, "zS", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "x", "o" }, "<M-S-M>", "<Plug>(leap-from-window)")
  end,
}
