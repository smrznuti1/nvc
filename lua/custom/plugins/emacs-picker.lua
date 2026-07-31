local fn, fs, uv, api = vim.fn, vim.fs, vim.uv, vim.api
local pick = require 'mini.pick'

local SIZE_UNITS = { { 1e12, 'T' }, { 1e9, 'G' }, { 1e6, 'M' }, { 1e3, 'k' } }

---convert fs_stat size to string with units
local size_str = function(size)
  if not size then return '' end
  for _, unit in ipairs(SIZE_UNITS) do
    local factor, suffix = unit[1], unit[2]
    if size >= factor then return ('%.1f%s'):format(size / factor, suffix) end
  end
  return ('%d'):format(size)
end

local RWX = { '---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx' }

---convert fs_stat octal "mode" number to permissions string, e.g. 604 -> -rw----r--
local permissions_str = function(type, mode)
  if not mode then return ('-'):rep(10) end
  local out = ({ directory = 'd', link = 'l' })[type] or '-'
  for _, digit in ipairs { 64, 8, 1 } do -- keep bottom 3 octal-digits
    out = out .. RWX[math.floor(mode / digit) % 8 + 1]
  end
  return out
end

---convert fs_stat mtime to "last modified" string
local modified_str = function(mtime)
  if not mtime then return '' end
  return fn.strftime('%b %d %H:%M', mtime.sec)
end

---create an array of items for picker, will be called
---for each new directory visited during a picker session
---NOTE: actual items are returned as .items field of the returned table,
---alongside the max text width used to align columns in custom show()
local get_dir_items = function(dirname)
  if not dirname then return { items = {}, text_width = 0 } end

  local items, text_width = {}, 0
  for name, type in fs.dir(dirname) do
    local path = fs.joinpath(dirname, name)
    local stat = uv.fs_stat(path) or {}
    local text = type == 'directory' and name .. '/' or name
    text_width = math.max(text_width, #text)
    items[#items + 1] = {
      text = text,
      path = path,
      type = type,
      size = size_str(stat.size),
      permissions = permissions_str(type, stat.mode),
      modified = modified_str(stat.mtime),
    }
  end

  return { items = items, text_width = text_width }
end

-- path helpers --------------------------------------------------------------
local normalized = function(path) return path and fs.normalize(fs.abspath(path)) end

local query_to_path = function(query)
  local path = table.concat(query)
  if vim.trim(path) == '' then return false end
  return fs.abspath(path)
end

local query_to_dirname = function(query)
  local path = table.concat(query)
  if vim.trim(path) == '' then return false end
  -- fs.dirname '~' is '.', so expand it first to land in the home's parent
  return normalized(path == '~' and fs.dirname(fn.expand(path)) or fs.dirname(path))
end

local query_tail = function(query)
  local path = query_to_path(query)
  return vim.split(path and fs.basename(path) or '', '')
end

local set_query_to_path = function(path)
  pick.set_picker_query(vim.split(fn.fnamemodify(path, ':p:~'), ''))
end

-- emacs-like window ---------------------------------------------------------
local SOURCE_NAME = 'Find File'
local MAX_ITEMS = 10
local SHOW_ICONS = true

local emacs_win_config = function(n_items)
  local has_statusline = vim.o.laststatus > 0
  return {
    relative = 'editor',
    anchor = 'SW',
    row = vim.o.lines - vim.o.cmdheight - (has_statusline and 1 or 0),
    col = 0,
    width = vim.o.columns,
    height = math.max(1, math.min(n_items or MAX_ITEMS, MAX_ITEMS)),
    border = { '', ' ', '', '', '', '', '', '' },
    style = 'minimal',
  }
end

local fit_window_to_matches = function()
  local opts = pick.get_picker_opts() or {}
  if (opts.source or {}).name ~= SOURCE_NAME then return end
  local state = pick.get_picker_state()
  if not state or not api.nvim_win_is_valid(state.windows.main) then return end
  local matches = pick.get_picker_matches() or {}
  api.nvim_win_set_config(state.windows.main, emacs_win_config(#(matches.all_inds or {})))
end

local COLUMNS_NS = api.nvim_create_namespace 'find-file-picker'

-- picker implementation -----------------------------------------------------
local CACHE_STUB = { items = {}, text_width = 0 }

local find_file = function(local_opts, opts)
  local_opts = vim.tbl_extend('force', { dir = fn.getcwd() }, local_opts or {})
  local initial_dir = normalized(local_opts.dir)
  vim.schedule(function() set_query_to_path(initial_dir) end)

  -- `items_cache` is a table keyed by normalized directory paths
  -- NOTE: using `[false]` as a special key to stub empty lookups,
  -- which happens when query is empty
  local items_cache = { [false] = CACHE_STUB }
  items_cache[initial_dir] = get_dir_items(initial_dir)
  local items = items_cache[initial_dir].items

  -- Query "history" stack for the "pressing ~ or / resets query to list home or
  -- root directory" feature: a "~" or "/" trigger with the right conditions
  -- pushes the current query and resets it, and reaching an empty query (by
  -- backspacing or however) restores the query on top of the stack.
  local query_stack = {}
  local push_query_and_reset = function(query)
    local trigger_char = table.remove(query) -- trigger char is not part of the saved query
    local top = query_stack[#query_stack]
    if not (top and table.concat(top) == table.concat(query)) then
      query_stack[#query_stack + 1] = query
    end
    pick.set_picker_query { trigger_char }
  end

  local last_dir = initial_dir
  local match = function(stritems, inds, query)
    -- restore query on top of stack if we hit empty query
    if #query == 0 then
      local last_query = table.remove(query_stack)
      if last_query then
        pick.set_picker_query(last_query)
        return
      end
    end

    -- pressing "~" anywhere during a query should immediatlely bring you home
    -- NOTE: excluding cases with repetition like `query == { "~", "~", "~" }`
    if #query > 1 and query[#query] == '~' and query[#query - 1] ~= '~' then
      push_query_and_reset(query)
      return
    end

    -- pressing "/" only when last query char is "/" should bring you to root
    -- meaning the last to chars of the query should be "//"
    if #query > 1 and query[#query] == '/' and query[#query - 1] == '/' then
      if table.concat(query) ~= '//' then
        push_query_and_reset(query)
      else
        -- NOTE: I'm excluding the case where you type "/" when `query == { "/" }`
        -- i.e. repeating consecutive "/" chars does not add an empty "/" to the query
        -- stack. This differs from Emacs behavior, but I think it's a lot better.
        pick.set_picker_query { '/' }
      end
      return
    end

    local current_dir = query_to_dirname(query)
    if current_dir ~= last_dir then
      last_dir = current_dir
      -- if `current_dir == false`, we hit our items_cache[false] stub,
      -- which is {} (truthy), so items will become {}, otherwise compute and cache new items
      if not items_cache[current_dir] then items_cache[current_dir] = get_dir_items(current_dir) end
      pick.set_picker_items(items_cache[current_dir].items, { do_match = true })
      return
    end

    return pick.default_match(stritems, inds, query_tail(query))
  end

  local show = function(buf_id, items_to_show, query)
    pick.default_show(buf_id, items_to_show, query_tail(query), { show_icons = SHOW_ICONS })

    api.nvim_buf_clear_namespace(buf_id, COLUMNS_NS, 0, -1)
    local extmark = function(i, text, hl, extmark_opts)
      api.nvim_buf_set_extmark(buf_id, COLUMNS_NS, i - 1, 0, {
        virt_text = { { text, hl } },
        virt_text_pos = extmark_opts.virt_text_pos,
        virt_text_win_col = extmark_opts.virt_text_win_col,
        hl_mode = 'combine',
      })
    end
    -- the numbers are kinda magic here...
    -- 9 because that's the width of "%6s   " format string
    -- 4 beacuse the text is prefixed with icons so 2 for icon and 2 for extra space after text
    -- 40 because it looks alright as default offset
    -- NOTE: an alternative would be to truncate filenames if width too long instead of moving columns
    local text_width = items_cache[query_to_dirname(query)].text_width
    local text_pad = SHOW_ICONS and 4 or 2
    local permissions_offset = math.max(9 + text_width + text_pad, 40)
    for i, item in ipairs(items_to_show) do
      extmark(i, ('%6s   '):format(item.size), 'String', { virt_text_pos = 'inline' })
      extmark(i, item.permissions, 'Number', { virt_text_win_col = permissions_offset })
      extmark(i, item.modified, 'Comment', { virt_text_win_col = permissions_offset + 20 })
    end
  end

  local custom_choose = function()
    local current = pick.get_picker_matches().current
    if current then
      pick.default_choose(current)
      return true
    end
    local path = query_to_path(pick.get_picker_query())
    -- NOTE: needs to be scheduled so picker returns to target window and THEN calls :edit
    vim.schedule(function() vim.cmd('edit ' .. path) end)
    return true
  end

  local custom_apply_match = function()
    local current = pick.get_picker_matches().current
    if current then set_query_to_path(current.path) end
  end

  local common_prefix = function(strings)
    local prefix = strings[1]
    for i = 2, #strings do
      local other = strings[i]
      local n = 0
      while n < #prefix and n < #other and prefix:byte(n + 1) == other:byte(n + 1) do
        n = n + 1
      end
      prefix = prefix:sub(1, n)
      if prefix == '' then return prefix end
    end
    return prefix
  end

  local custom_complete = function()
    local matches = pick.get_picker_matches().all or {}
    if #matches == 0 then return end

    local prefix = common_prefix(vim.tbl_map(function(item) return item.text end, matches))
    local dirname = query_to_dirname(pick.get_picker_query())
    if prefix == '' or not dirname then return end

    set_query_to_path(fs.joinpath(dirname, prefix))
  end

  api.nvim_create_autocmd('User', {
    group = api.nvim_create_augroup('EmacsPickerResize', { clear = true }),
    pattern = 'MiniPickMatch',
    callback = fit_window_to_matches,
  })

  -- default opts
  opts = vim.tbl_deep_extend('keep', opts or {}, {
    window = {
      prompt_prefix = 'Find file: ',
      prompt_caret = '▏',
      config = function() return emacs_win_config() end,
    },
    source = { name = SOURCE_NAME },
    mappings = {
      choose = '', -- to suppress overwrite <CR> warning
      toggle_preview = '', -- to suppress overwrite <Tab> warning
      toggle_info = '', -- to suppress overwrite <S-Tab> warning
      scroll_right = '', -- to suppress overwrite <C-l> warning
      refine = '', -- to suppress overwrite <C-Space> warning
      move_down = '<Tab>',
      move_up = '<S-Tab>',
      custom_choose = { char = '<CR>', func = custom_choose },
      custom_complete = { char = '<C-Space>', func = custom_complete },
      custom_apply_match = { char = '<C-l>', func = custom_apply_match },
    },
  })
  -- mandatory opts
  opts = vim.tbl_deep_extend('force', opts, {
    options = { use_cache = false },
    source = { items = items, match = match, show = show },
  })
  return pick.start(opts)
end

pick.registry['find_file'] = find_file
vim.keymap.set({ 'n', 'v', 'i', 't' }, '<M-o>', function() pick.registry.find_file() end)
-- vim.keymap.set(
--   'n',
--   '<Leader>f.',
--   function() pick.registry.find_file { dir = fn.expand '%:p:h' } end
-- )
