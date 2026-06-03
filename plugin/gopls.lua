---@brief
---
--- https://github.com/golang/tools/tree/master/gopls
---
--- Google's lsp server for golang.

--- @class go_dir_custom_args
---
--- @field envvar_id string
---
--- @field custom_subdir string?

local mod_cache = nil
local std_lib = nil

---@param custom_args go_dir_custom_args
---@param on_complete fun(dir: string | nil)
local function identify_go_dir(custom_args, on_complete)
  local cmd = { 'go', 'env', custom_args.envvar_id }
  vim.system(cmd, { text = true }, function(output)
    local res = vim.trim(output.stdout or '')
    if output.code == 0 and res ~= '' then
      if custom_args.custom_subdir and custom_args.custom_subdir ~= '' then
        res = res .. custom_args.custom_subdir
      end
      on_complete(res)
    else
      vim.schedule(
        function()
          vim.notify(
            ('[gopls] identify ' .. custom_args.envvar_id .. ' dir cmd failed with code %d: %s\n%s'):format(
              output.code,
              vim.inspect(cmd),
              output.stderr
            ),
            vim.log.levels.ERROR
          )
        end
      )
      on_complete(nil)
    end
  end)
end

---@param on_complete fun()
local function ensure_std_lib_dir(on_complete)
  if std_lib and std_lib ~= '' then return on_complete() end
  identify_go_dir({ envvar_id = 'GOROOT', custom_subdir = '/src' }, function(dir)
    if dir then std_lib = dir end
    on_complete()
  end)
end

---@param on_complete fun()
local function ensure_mod_cache_dir(on_complete)
  if mod_cache and mod_cache ~= '' then return on_complete() end
  identify_go_dir({ envvar_id = 'GOMODCACHE' }, function(dir)
    if dir then mod_cache = dir end
    on_complete()
  end)
end

---@param fname string
---@return string?
local function get_root_dir(fname)
  local in_cache = mod_cache and fname:sub(1, #mod_cache) == mod_cache
  local in_std = std_lib and fname:sub(1, #std_lib) == std_lib
  if in_cache or in_std then
    local clients = vim.lsp.get_clients { name = 'gopls' }
    if #clients > 0 then return clients[#clients].config.root_dir end
  end
  return vim.fs.root(fname, { 'go.work', 'go.mod', '.git' })
end

---@type vim.lsp.Config
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- resolve GOMODCACHE + GOROOT first, then compute the root. both lookups
    -- are async, so chain them and only call on_dir once both are ready.
    ensure_mod_cache_dir(function()
      ensure_std_lib_dir(function()
        vim.schedule(function() on_dir(get_root_dir(fname)) end)
      end)
    end)
  end,
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      completeUnimported = true,
      usePlaceholders = true,
      semanticTokens = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

vim.lsp.enable 'gopls'
