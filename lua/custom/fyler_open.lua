return function(root_path)
  root_path = vim.fn.fnamemodify(root_path or '', ':p')
  if vim.fn.isdirectory(root_path) == 0 then root_path = vim.fn.getcwd() end

  local win_id = vim.api.nvim_get_current_win()
  local instance = require('fyler.finder').instance_get_or_nil()
  if instance and instance.win_id ~= win_id then instance:close() end

  require('fyler').open { root_path = root_path }
end
