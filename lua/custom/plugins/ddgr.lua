Ddgr = {}
Ddgr.__index = Ddgr

function Ddgr:new()
  local instance = setmetatable({}, Ddgr)
  instance.buf = nil

  local term_width = vim.o.columns
  local term_height = vim.o.lines

  local width = math.floor(term_width * 0.5) -- 50% of the terminal width
  local height = math.floor(term_height * 0.8) -- 20% of the terminal height
  local row = math.floor((term_height - 2) / 2) -- Centered vertically
  local col = math.floor((term_width - width) / 2) -- Centered horizontally

  instance.opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'single',
  }
  return instance
end

-- Method to get the value
function Ddgr:openWindow()
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

return {}
