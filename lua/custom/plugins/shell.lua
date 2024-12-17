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
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

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

    local file_path = vim.fn.expand('%:p:h')
    local git_root = find_git_root(file_path)

    if git_root then
      vim.cmd('silent! lcd ' .. git_root)
    else
      vim.cmd('silent! lcd ' .. file_path)
    end
  end,
})

vim.opt.shortmess = vim.opt.shortmess + 'A'

return {}
