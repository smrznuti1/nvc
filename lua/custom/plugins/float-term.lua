return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_height = 0.5
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_wintype = "float"
    vim.g.floaterm_position = "bottom"
    vim.g.floaterm_autoclose = 0
    vim.keymap.set({ "n", "t", "i" }, "<M-l>", function()
      vim.cmd("FloatermNext")
      vim.api.nvim_command("stopinsert")
      local bufname = vim.fn.bufname()
      if bufname:match("^term://") then
        local bufname_shorten = bufname:gsub("^term://[^:]*:", ""):gsub(". ~/.zshrc; ", "")
        local quote_position = string.find(bufname_shorten, "'")
        if quote_position ~= nil then
          vim.notify(bufname_shorten:sub(quote_position + 1, #bufname_shorten - 1))
        else
          vim.notify(bufname_shorten)
        end
      end
    end, { silent = false, noremap = true })

    vim.keymap.set({ "n", "t", "i" }, "<M-h>", function()
      vim.cmd("FloatermPrev")
      vim.api.nvim_command("stopinsert")
      local bufname = vim.fn.bufname()
      if bufname:match("^term://") then
        local bufname_shorten = bufname:gsub("^term://[^:]*:", ""):gsub(". ~/.zshrc; ", "")
        vim.notify(bufname_shorten)
      end
    end, { silent = false, noremap = true })

    vim.keymap.set({ "n", "t", "i" }, "<M-e>", function()
      vim.cmd("FloatermToggle")
      vim.api.nvim_command("stopinsert")

      local bufname = vim.fn.bufname()
      if bufname:match("^term://") then
        local bufname_shorten = bufname:gsub("^term://[^:]*:", ""):gsub(". ~/.zshrc; ", "")
        local quote_position = string.find(bufname_shorten, "'")
        if quote_position ~= nil then
          vim.notify(bufname_shorten:sub(quote_position + 1, #bufname_shorten - 1))
        else
          vim.notify(bufname_shorten)
        end
      end

      -- vim.notify(vim.fn.bufname())
    end, { silent = true, noremap = true })

    vim.keymap.set(
      { "n", "t", "i" },
      "<M-t>",
      "<cmd>FloatermToggle terminal<cr>",
      { desc = "Terminal Here" }
    )
    -- vim.fn.execute("hi FloatermBorder guifg=#ed89fa", "silent")
    -- vim.fn.execute("hi FloatermBorder guifg=orange", "silent")
    vim.fn.execute("hi FloatermBorder guifg=#f5d16e", "silent")
  end,
}
