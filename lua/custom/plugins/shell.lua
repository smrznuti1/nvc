vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag =
  "-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

vim.api.nvim_create_user_command('Pterm', 'term pwsh', {})
vim.api.nvim_create_user_command('PT', 'term pwsh', {})
vim.api.nvim_create_user_command('Uterm', 'term wsl.exe', {})
vim.api.nvim_create_user_command('UT', 'term wsl.exe', {})
vim.api.nvim_create_user_command('BDAll', '%bd! | e#', {})
vim.api.nvim_create_user_command('NT', 'bd! % | term', {})
vim.api.nvim_create_user_command('NUT', 'bd! % | Uterm', {})
vim.api.nvim_create_user_command('CC', 'CopilotChat', {})

vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99

-- vim.opt.autochdir = true

-- vim.api.nvim_create_autocmd('BufEnter', {
--   pattern = '*',
--   callback = function()
--     vim.cmd 'silent! lcd %:p:h'
--   end,
-- })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype ~= '' then
      return
    end
    local function find_git_root(path)
      local git_path = path .. '/.git'
      if vim.loop.fs_stat(git_path) then
        return path
      end
      local parent = vim.fn.fnamemodify(path, ':h')
      if parent == path then
        return nil
      end
      return find_git_root(parent)
    end

    local function find_lsp_root_dir()
      local clients = vim.lsp.get_clients()
      if not clients then
        return nil
      end
      local buffer_path = vim.fn.expand '%:p'
      local longest_root_dir = nil

      for _, client in pairs(clients) do
        if client.name == 'null-ls' then
          goto continue
        end

        local client_filetypes = client.config.filetypes
        if client_filetypes and vim.tbl_contains(client_filetypes, vim.bo.filetype) then
          local root_dir = client.config.root_dir
          if root_dir and buffer_path:sub(1, #root_dir) == root_dir then
            if not longest_root_dir or #root_dir > #longest_root_dir then
              longest_root_dir = root_dir
            end
          end
        end
        ::continue::
      end
      return longest_root_dir
    end

    local function set_path()
      local file_path = vim.fn.expand '%:p:h'
      local git_root = find_git_root(file_path)
      local lsp_root = find_lsp_root_dir()

      if lsp_root then
        vim.cmd('silent! lcd ' .. lsp_root)
      elseif git_root then
        vim.cmd('silent! lcd ' .. git_root)
      else
        vim.cmd('silent! lcd ' .. file_path)
      end
    end

    vim.defer_fn(set_path, 500)
  end,
})

vim.opt.shortmess = vim.opt.shortmess + 'A'

vim.cmd 'set expandtab'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

return {}
