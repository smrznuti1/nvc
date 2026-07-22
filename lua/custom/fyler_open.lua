local function usable(buf_id)
  return buf_id > 0
    and vim.api.nvim_buf_is_valid(buf_id)
    and vim.bo[buf_id].buflisted
    and vim.fn.isdirectory(vim.api.nvim_buf_get_name(buf_id)) == 0
end

local function set_alt(win_id)
  local candidates = { vim.api.nvim_win_call(win_id, function() return vim.fn.bufnr '#' end), vim.fn.bufnr '#' }
  vim.list_extend(candidates, vim.api.nvim_list_bufs())

  for _, buf_id in ipairs(candidates) do
    if usable(buf_id) then
      return vim.api.nvim_win_call(win_id, function() vim.cmd('let @# = ' .. buf_id) end)
    end
  end
end

return function(root_path)
  root_path = vim.fn.fnamemodify(root_path or '', ':p')
  if vim.fn.isdirectory(root_path) == 0 then root_path = vim.fn.getcwd() end

  local instance = require('fyler.finder').instance_get_or_nil()
  if instance and instance.win_id ~= vim.api.nvim_get_current_win() then
    set_alt(instance.win_id)
    instance:close()
  end

  require('fyler').open { root_path = root_path }
end
