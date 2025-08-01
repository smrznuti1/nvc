return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
███████ ███    ███ ██████  ████████
██      ████  ████ ██   ██     ████
███████ ██ ████ ██ ██████    ████  
     ██ ██  ██  ██ ██   ██ ████    
███████ ██      ██ ██   ██ ████████]],
      },
    },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      enabled = true,
      main = {
        file = false,
      },
      jump = {
        jumplist = true,
        tagstack = false,
        reuse_win = true,
        close = true,
        match = true,
      },
      formatters = {
        file = {
          truncate = 100,
        },
      },
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        sort_empty = true,
        filename_bonus = true,
        file_pos = true,
        cwd_bonus = true,
        frecency = false,
        history_bonus = false,
      },
      sort = {
        fields = { "score:desc", "#text", "idx" },
      },
      win = {
        input = {
          keys = {
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["gx"] = {
              "explorer_open",
              mode = { "n" },
            },
            ["gy"] = { "explorer_yank", mode = { "n" } },
          },
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    scratch = {
      ft = "norg",
      root = vim.fn.stdpath("data") .. "/scratch",
      autowrite = true,
      filekey = {
        cwd = true, -- use current working directory
        branch = false, -- use current branch name
        count = false, -- use vim.v.count1
      },
    },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader>sF",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader><leader>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    -- {
    --   "<leader>:",
    --   function()
    --     Snacks.picker.command_history()
    --   end,
    --   desc = "Command History",
    -- },
    {
      "<leader>N",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    -- {
    --   "<leader>e",
    --   function()
    --     Snacks.explorer()
    --   end,
    --   desc = "File Explorer",
    -- },
    -- find
    -- {
    --   "<leader>fb",
    --   function()
    --     Snacks.picker.buffers()
    --   end,
    --   desc = "Buffers",
    -- },
    {
      "<leader>sn",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>sf",
      function()
        Snacks.picker.files({ hidden = true, ignored = true })
      end,
      desc = "Find Files",
    },
    -- {
    --   "<leader>fg",
    --   function()
    --     Snacks.picker.git_files()
    --   end,
    --   desc = "Find Git Files",
    -- },
    {
      "<leader>sp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Projects",
    },
    -- {
    --   "<leader><leader>",
    --   function()
    --     Snacks.picker.recent()
    --   end,
    --   desc = "Recent",
    -- },
    -- git
    -- {
    --   "<leader>gb",
    --   function()
    --     Snacks.picker.git_branches()
    --   end,
    --   desc = "Git Branches",
    -- },
    -- {
    --   "<leader>gl",
    --   function()
    --     Snacks.picker.git_log()
    --   end,
    --   desc = "Git Log",
    -- },
    -- {
    --   "<leader>gL",
    --   function()
    --     Snacks.picker.git_log_line()
    --   end,
    --   desc = "Git Log Line",
    -- },
    -- {
    --   "<leader>gs",
    --   function()
    --     Snacks.picker.git_status()
    --   end,
    --   desc = "Git Status",
    -- },
    -- {
    --   "<leader>gS",
    --   function()
    --     Snacks.picker.git_stash()
    --   end,
    --   desc = "Git Stash",
    -- },
    -- {
    --   "<leader>gd",
    --   function()
    --     Snacks.picker.git_diff()
    --   end,
    --   desc = "Git Diff (Hunks)",
    -- },
    -- {
    --   "<leader>gf",
    --   function()
    --     Snacks.picker.git_log_file()
    --   end,
    --   desc = "Git Log File",
    -- },
    -- Grep
    {
      "<leader>/",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    -- {
    --   "<leader>sg",
    --   function()
    --     Snacks.picker.grep()
    --   end,
    --   desc = "Grep",
    -- },
    -- {
    --   "<leader>sw",
    --   function()
    --     Snacks.picker.grep_word()
    --   end,
    --   desc = "Visual selection or word",
    --   mode = { "n", "x" },
    -- },
    -- search
    -- {
    --   '<leader>s"',
    --   function()
    --     Snacks.picker.registers()
    --   end,
    --   desc = "Registers",
    -- },
    -- {
    --   "<leader>s/",
    --   function()
    --     Snacks.picker.search_history()
    --   end,
    --   desc = "Search History",
    -- },
    -- {
    --   "<leader>sa",
    --   function()
    --     Snacks.picker.autocmds()
    --   end,
    --   desc = "Autocmds",
    -- },
    -- {
    --   "<leader>sb",
    --   function()
    --     Snacks.picker.lines()
    --   end,
    --   desc = "Buffer Lines",
    -- },
    -- {
    --   "<leader>sc",
    --   function()
    --     Snacks.picker.command_history()
    --   end,
    --   desc = "Command History",
    -- },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Commands",
    },
    -- {
    --   "<leader>sd",
    --   function()
    --     Snacks.picker.diagnostics()
    --   end,
    --   desc = "Diagnostics",
    -- },
    -- {
    --   "<leader>sD",
    --   function()
    --     Snacks.picker.diagnostics_buffer()
    --   end,
    --   desc = "Buffer Diagnostics",
    -- },
    -- {
    --   "<leader>sh",
    --   function()
    --     Snacks.picker.help()
    --   end,
    --   desc = "Help Pages",
    -- },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Highlights",
    },
    -- {
    --   "<leader>si",
    --   function()
    --     Snacks.picker.icons()
    --   end,
    --   desc = "Icons",
    -- },
    -- {
    --   "<leader>sj",
    --   function()
    --     Snacks.picker.jumps()
    --   end,
    --   desc = "Jumps",
    -- },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    -- {
    --   "<leader>sl",
    --   function()
    --     Snacks.picker.loclist()
    --   end,
    --   desc = "Location List",
    -- },
    -- {
    --   "<leader>sm",
    --   function()
    --     Snacks.picker.marks()
    --   end,
    --   desc = "Marks",
    -- },
    -- {
    --   "<leader>sM",
    --   function()
    --     Snacks.picker.man()
    --   end,
    --   desc = "Man Pages",
    -- },
    -- {
    --   "<leader>sp",
    --   function()
    --     Snacks.picker.lazy()
    --   end,
    --   desc = "Search for Plugin Spec",
    -- },
    -- {
    --   "<leader>sq",
    --   function()
    --     Snacks.picker.qflist()
    --   end,
    --   desc = "Quickfix List",
    -- },
    -- {
    --   "<leader>sR",
    --   function()
    --     Snacks.picker.resume()
    --   end,
    --   desc = "Resume",
    -- },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo History",
    },
    -- {
    --   "<leader>uC",
    --   function()
    --     Snacks.picker.colorschemes()
    --   end,
    --   desc = "Colorschemes",
    -- },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
    -- Other
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    -- {
    --   "<leader>n",
    --   function()
    --     Snacks.notifier.show_history()
    --   end,
    --   desc = "Notification History",
    -- },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    -- {
    --   "<leader>gB",
    --   function()
    --     Snacks.gitbrowse()
    --   end,
    --   desc = "Git Browse",
    --   mode = { "n", "v" },
    -- },
    -- {
    --   "<leader>gg",
    --   function()
    --     Snacks.lazygit()
    --   end,
    --   desc = "Lazygit",
    -- },
    -- {
    --   "<leader>un",
    --   function()
    --     Snacks.notifier.hide()
    --   end,
    --   desc = "Dismiss All Notifications",
    -- },
    -- {
    --   "<c-/>",
    --   function()
    --     Snacks.terminal()
    --   end,
    --   desc = "Toggle Terminal",
    -- },
    -- {
    --   "<c-_>",
    --   function()
    --     Snacks.terminal()
    --   end,
    --   desc = "which_key_ignore",
    -- },
    -- {
    --   "]]",
    --   function()
    --     Snacks.words.jump(vim.v.count1)
    --   end,
    --   desc = "Next Reference",
    --   mode = { "n", "t" },
    -- },
    -- {
    --   "[[",
    --   function()
    --     Snacks.words.jump(-vim.v.count1)
    --   end,
    --   desc = "Prev Reference",
    --   mode = { "n", "t" },
    -- },
    -- {
    --   "<leader>N",
    --   desc = "Neovim News",
    --   function()
    --     Snacks.win({
    --       file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    --       width = 0.6,
    --       height = 0.6,
    --       wo = {
    --         spell = false,
    --         wrap = false,
    --         signcolumn = "yes",
    --         statuscolumn = " ",
    --         conceallevel = 3,
    --       },
    --     })
    --   end,
    -- },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        vim.keymap.set({ "n", "t", "i" }, "<M-a>", function()
          local cwd = vim.fn.getcwd()
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true),
            "i",
            false
          )
          Snacks.picker.files({ cwd = cwd, focus = "input", hidden = true, ignored = true })
          vim.cmd("FloatermHide")
        end, { desc = "Find Files" })
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}
