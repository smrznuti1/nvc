return function(root_path)
  local win_id = vim.api.nvim_get_current_win()
  local instance = require('fyler.finder').instance_get_or_nil()
  if instance and instance.win_id ~= win_id then instance:close() end

  require('fyler').open { root_path = root_path }
end
