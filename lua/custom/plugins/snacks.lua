vim.pack.add { 'https://github.com/folke/snacks.nvim' }

---@type snacks.Config
local opts = {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = table.concat({
        '███████ ███    ███ ██████  ████████',
        '██      ████  ████ ██   ██       ██',
        '███████ ██ ████ ██ ██████    █████ ',
        '     ██ ██  ██  ██ ██  ██  ███     ',
        '███████ ██      ██ ██   ██ ████████',
      }, '\n'),
    },
    -- Default sections include `startup`, which requires lazy.stats from
    -- lazy.nvim. We use vim.pack, so override sections to skip it.
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      -- { section = 'recent_files', icon = ' ', title = 'Recent Files', indent = 2, padding = 1 },
      -- { section = 'projects', icon = ' ', title = 'Projects', indent = 2, padding = 1 },
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
    main = { file = false },
    jump = {
      jumplist = true,
      tagstack = false,
      reuse_win = true,
      close = true,
      match = true,
    },
    formatters = {
      file = { truncate = 100 },
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
      fields = { 'score:desc', 'idx' },
    },
    win = {
      input = {
        keys = {
          ['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
          ['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
          ['gx'] = { 'explorer_open', mode = { 'n' } },
          ['gy'] = { 'explorer_yank', mode = { 'n' } },
        },
      },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  scratch = {
    ft = 'markdown',
    root = vim.fn.stdpath 'data' .. '/scratch',
    autowrite = true,
    filekey = {
      cwd = true,
      branch = true,
      count = false,
    },
  },
  words = { enabled = true },
  styles = {
    notification = {},
    input = {
      backdrop = false,
      position = 'float',
      border = 'rounded',
      title_pos = 'left',
      height = 1,
      relative = 'cursor',
      noautocmd = true,
      row = -5,
      col = 1,
      wo = {
        winhighlight = 'NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle',
        cursorline = false,
      },
      bo = {
        filetype = 'snacks_input',
        buftype = 'nowrite',
      },
      b = {
        completion = false,
      },
      keys = {
        n_esc = { '<esc>', { 'cmp_close', 'cancel' }, mode = 'n', expr = true },
        c_c = {
          '<C-c>',
          function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.b[bufnr]['snacks_input_hist_idx'] = nil
            vim.api.nvim_buf_set_lines(0, 0, -1, false, { '' })
            vim.api.nvim_win_set_cursor(0, { 1, 0 })
          end,
          mode = { 'i', 'n' },
        },
        i_esc = { '<esc>', { 'cmp_close', 'stopinsert' }, mode = 'i', expr = true },
        c_y = { '<C-y>', { 'cmp_accept' }, mode = 'i', expr = true },
        c_l = {
          '<C-l>',
          function()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes('<C-y><tab>', true, false, true),
              'i',
              false
            )
          end,
          mode = 'i',
          expr = true,
        },
        i_cr = { '<cr>', { 'confirm' }, mode = { 'i', 'n' }, expr = true },
        i_tab = { '<tab>', { 'cmp_select_next', 'cmp' }, mode = 'i', expr = true },
        i_quit = { '<C-q>', { 'destroy' }, mode = { 'i', 'n' }, expr = true },
        i_stab = { '<S-tab>', { 'cmp_select_prev', 'cmp' }, mode = 'i', expr = true },
        i_ctrl_w = { '<c-w>', '<c-s-w>', mode = 'i', expr = true },
        i_up = {
          '<up>',
          function()
            local mod = function(x)
              local y = vim.fn.histnr 'debug' + 1
              while x < 0 do
                x = x + y
              end
              return math.fmod(x, y)
            end

            local bufnr = vim.api.nvim_get_current_buf()
            local key = 'snacks_input_hist_idx'
            local idx = vim.b[bufnr][key] or 0

            if vim.b[bufnr]['input_line'] == nil or idx == 0 then
              vim.b[bufnr]['input_line'] = vim.api.nvim_buf_get_text(bufnr, 0, 0, -1, -1, {})[1]
                or ''
            end
            idx = mod(idx - 1)
            while
              (
                vim.fn.histget('debug', idx) == ''
                or string.sub(vim.fn.histget('debug', idx), 1, #vim.b[bufnr]['input_line'])
                  ~= vim.b[bufnr]['input_line']
              ) and idx > 0
            do
              idx = mod(idx - 1)
            end
            vim.b[bufnr][key] = idx

            local text = vim.fn.histget('debug', idx)
            if idx == 0 then text = vim.b[bufnr]['input_line'] end
            text = text or ''
            local lines = vim.split(text, '\n', { plain = true })
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
            vim.api.nvim_win_set_cursor(0, { #lines, #lines[#lines] })
          end,
          mode = { 'i', 'n' },
        },
        i_down = {
          '<down>',
          function()
            local mod = function(x)
              local y = vim.fn.histnr 'debug' + 1
              if x <= 1 then return 0 end
              return math.fmod(x, y)
            end

            local bufnr = vim.api.nvim_get_current_buf()
            local key = 'snacks_input_hist_idx'
            local idx = vim.b[bufnr][key] or 0
            idx = mod(idx + 1)
            while
              (
                vim.fn.histget('debug', idx) == ''
                or string.sub(vim.fn.histget('debug', idx), 1, #vim.b[bufnr]['input_line'])
                  ~= vim.b[bufnr]['input_line']
              ) and idx > 0
            do
              idx = mod(idx + 1)
            end
            vim.b[bufnr][key] = idx
            local text = vim.fn.histget('debug', idx)
            if idx == 0 then text = vim.b[bufnr]['input_line'] end
            text = text or ''
            local lines = vim.split(text, '\n', { plain = true })
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
            vim.api.nvim_win_set_cursor(0, { #lines, #lines[#lines] })
          end,
          mode = { 'i', 'n' },
        },
        q = 'cancel',
      },
    },
  },
  zen = {
    toggles = { dim = false },
    zoom = {
      toggles = {
        git_signs = true,
        mini_diff_signs = true,
        diagnostics = true,
        inlay_hints = true,
      },
      show = { statusline = true, tabline = true },
    },
  },
}

require('snacks').setup(opts)

-- Back vim.ui.select with snacks.picker (replaces telescope-ui-select).
vim.ui.select = function(...) return Snacks.picker.select(...) end

-- Keymaps
vim.keymap.set(
  'n',
  '<leader>sF',
  function() Snacks.picker.smart() end,
  { desc = 'Smart Find Files' }
)
vim.keymap.set(
  'n',
  '<leader><leader>',
  function() Snacks.picker.buffers() end,
  { desc = 'Buffers' }
)
vim.keymap.set('n', '<leader>sg', function() Snacks.picker.grep() end, { desc = 'Grep' })
vim.keymap.set(
  'n',
  '<leader>N',
  function() Snacks.picker.notifications() end,
  { desc = 'Notification History' }
)
vim.keymap.set(
  'n',
  '<leader>sn',
  function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
  { desc = 'Find Config File' }
)
vim.keymap.set(
  'n',
  '<leader>sf',
  function() Snacks.picker.files { hidden = false, ignored = true } end,
  { desc = 'Find Files' }
)
vim.keymap.set('n', '<leader>sp', function() Snacks.picker.projects() end, { desc = 'Projects' })
vim.keymap.set('n', '<leader>/', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
vim.keymap.set(
  'n',
  '<leader>sB',
  function() Snacks.picker.grep_buffers() end,
  { desc = 'Grep Open Buffers' }
)
vim.keymap.set('n', '<leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
vim.keymap.set(
  'n',
  '<leader>sH',
  function() Snacks.picker.highlights() end,
  { desc = 'Highlights' }
)
vim.keymap.set('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
-- Ported from the removed telescope setup:
vim.keymap.set('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
vim.keymap.set('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = 'Resume Picker' })
vim.keymap.set(
  'n',
  '<leader>sd',
  function() Snacks.picker.diagnostics() end,
  { desc = 'Diagnostics' }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>sw',
  function() Snacks.picker.grep_word() end,
  { desc = 'Grep Word/Selection' }
)
vim.keymap.set('n', '<leader>s.', function() Snacks.picker.recent() end, { desc = 'Recent Files' })
vim.keymap.set(
  'n',
  'gd',
  function() Snacks.picker.lsp_definitions() end,
  { desc = 'Goto Definition' }
)
vim.keymap.set(
  'n',
  'gD',
  function() Snacks.picker.lsp_declarations() end,
  { desc = 'Goto Declaration' }
)
vim.keymap.set(
  'n',
  'gr',
  function() Snacks.picker.lsp_references() end,
  { nowait = true, desc = 'References' }
)
vim.keymap.set(
  'n',
  'gI',
  function() Snacks.picker.lsp_implementations() end,
  { desc = 'Goto Implementation' }
)
vim.keymap.set(
  'n',
  'gy',
  function() Snacks.picker.lsp_type_definitions() end,
  { desc = 'Goto Type Definition' }
)
vim.keymap.set(
  'n',
  '<leader>ss',
  function() Snacks.picker.lsp_symbols() end,
  { desc = 'LSP Symbols' }
)
vim.keymap.set(
  'n',
  '<leader>sS',
  function() Snacks.picker.lsp_workspace_symbols() end,
  { desc = 'LSP Workspace Symbols' }
)
vim.keymap.set('n', '<leader>Z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
vim.keymap.set(
  { 'n', 'i', 't', 'v' },
  '<M-z>',
  function() Snacks.zen.zoom() end,
  { desc = 'Toggle Zen Mode' }
)
vim.keymap.set('n', '<leader>z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })
vim.keymap.set(
  'n',
  '<leader>.',
  function() Snacks.scratch() end,
  { desc = 'Toggle Scratch Buffer' }
)
vim.keymap.set(
  'n',
  '<leader>S',
  function() Snacks.scratch.select() end,
  { desc = 'Select Scratch Buffer' }
)
vim.keymap.set('n', '<leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete Buffer' })
vim.keymap.set(
  'n',
  '<leader>cR',
  function() Snacks.rename.rename_file() end,
  { desc = 'Rename File' }
)

-- Init: hook input and add VimEnter setup
vim.schedule(function()
  local ctx = {}
  local snacks_input = Snacks.input
  local custom_input = function(opts2, on_confirm)
    local win = snacks_input(opts2, on_confirm)
    ctx.opts = opts2
    ctx.win = win
    return win
  end
  Snacks.input.enable = function() vim.ui.input = custom_input end
  Snacks.input.enable()
  Snacks.input.complete = function(findstart, base)
    local completion = ctx.opts and ctx.opts.completion
    if findstart == 1 then
      if completion == 'customlist,v:lua.custom_completion' then return 0 end
      return #ctx.win:text():gsub('%S+$', '')
    end
    if not completion then return {} end
    local ok, results = pcall(vim.fn.getcompletion, base, completion)
    return ok and results or {}
  end
end)

-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     vim.keymap.set({ 'n', 't', 'i' }, '<M-a>', function()
--       local cwd = vim.fn.getcwd()
--       vim.api.nvim_feedkeys(
--         vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true),
--         'i',
--         false
--       )
--       Snacks.picker.files { cwd = cwd, focus = 'input', hidden = true, ignored = true }
--       pcall(vim.cmd, 'FloatermHide')
--     end, { desc = 'Find Files' })
--     _G.dd = function(...) Snacks.debug.inspect(...) end
--     _G.bt = function() Snacks.debug.backtrace() end
--     vim.print = _G.dd
--   end,
-- })
