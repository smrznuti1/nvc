vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

local oil_module = require 'oil'
oil_module.setup {
  default_file_explorer = true,
  columns = { 'icon', 'permissions', 'size', 'mtime' },
  buf_options = {
    buflisted = false,
    bufhidden = 'hide',
  },
  win_options = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = 'nvic',
  },
  delete_to_trash = false,
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = false,
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    timeout_ms = 1000,
    autosave_changes = false,
  },
  constrain_cursor = 'name',
  experimental_watch_for_changes = false,
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['gy'] = 'actions.yank_entry',
    ['gh'] = 'actions.select_split',
    ['gv'] = 'actions.select_vsplit',
    ['<C-t>'] = 'actions.select_tab',
    ['gp'] = 'actions.preview',
    ['gd'] = 'actions.preview_scroll_down',
    ['gu'] = 'actions.preview_scroll_up',
    ['<C-c>'] = 'actions.close',
    ['gl'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    -- ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
    ['/'] = function() require('snacks.picker').lines() end,
    ['g\\'] = 'actions.toggle_trash',
    ['gP'] = function(bufnr)
      local path = oil_module.get_current_dir(bufnr)
      vim.fn.setreg('+', path)
    end,
  },
  keymaps_help = { border = 'rounded' },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, _) return vim.startswith(name, '.') end,
    is_always_hidden = function(_, _) return false end,
    sort = {
      { 'type', 'asc' },
      { 'name', 'asc' },
    },
  },
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = 'rounded',
    win_options = { winblend = 0 },
    override = function(conf) return conf end,
  },
  preview = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = 0.9,
    min_height = { 5, 0.1 },
    height = nil,
    border = 'rounded',
    win_options = { winblend = 0 },
    update_on_cursor_moved = true,
  },
  preview_win = {
    update_on_cursor_moved = true,
    preview_method = 'fast_scratch',
    disable_preview = function(filename)
      local file = io.open(filename, 'r')
      if not file then return false end
      local size = file:seek 'end'
      file:close()
      return size > 1024 * 1024
    end,
    win_options = {},
  },
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = 'rounded',
    minimized_border = 'none',
    win_options = { winblend = 0 },
  },
  ssh = { border = 'rounded' },
}

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('OilAutoCwd', {}),
  pattern = 'oil://*',
  callback = function()
    local ok, oil = pcall(require, 'oil')
    if ok then vim.cmd.lchdir(oil.get_current_dir()) end
  end,
})
