Ddgr = {}
Ddgr.__index = Ddgr

function Ddgr:get_opts()
  local editor_width = vim.api.nvim_get_option_value('columns', {})
  local editor_height = vim.api.nvim_get_option_value('lines', {})

  local width = math.floor(editor_width * 0.65)
  local height = math.floor(editor_height * 0.8)
  local row = math.floor(editor_height / 2)
  local col = math.floor((editor_width - width) / 2)

  self.opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single',
  }
end

function Ddgr:new()
  local instance = setmetatable({}, Ddgr)
  instance.buf = nil

  return instance
end

-- Method to get the value
function Ddgr:openWindow()
  Ddgr:get_opts()
  if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
    self.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(self.buf, true, self.opts)
    vim.fn.termopen 'ddgr'
  else
    vim.api.nvim_open_win(self.buf, true, self.opts)
  end
end

DdgrClass = Ddgr:new()

function OpenDdgr()
  DdgrClass:openWindow()
end

vim.api.nvim_create_user_command('OpenDdgr', OpenDdgr, {})

return {}
