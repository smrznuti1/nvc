local snacks = require("custom.plugins.snacks")
-- Funcs
function completionForRun(arg_lead, cmd_line, cursor_pos)
  local shellcmd_completions = vim.fn.getcompletion(arg_lead, "shellcmd")
  local file_completions = vim.fn.getcompletion("edit " .. arg_lead, "cmdline")

  file_completions = vim.tbl_map(function(item)
    return item:gsub("([ ()%%#$])", "\\%1")
  end, file_completions)

  shellcmd_completions = vim.tbl_map(function(item)
    return item:gsub("([ ()%%#$])", "\\%1")
  end, shellcmd_completions)
  return vim.tbl_extend("keep", file_completions, shellcmd_completions)
end

function custom_completion(arg_lead, cmd_line, cursor_pos)
  local words = vim.split(cmd_line, "%s+")
  local last_word = words[#words]
  local file_completions = vim.fn.getcompletion(":e " .. last_word, "cmdline")
  local shellcmd_completions = vim.fn.getcompletion(last_word, "shellcmd")
  local completions = vim.tbl_extend("keep", file_completions, shellcmd_completions)

  completions = vim.tbl_map(function(entry)
    return entry:gsub("[ ()%%#$]", "\\%0")
  end, completions)

  table.remove(words, #words)
  local current_cmd = table.concat(words, " ")

  if #completions > 1 then
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, false, true), "i")
  end

  return vim.tbl_map(function(entry)
    if current_cmd ~= "" then
      return current_cmd .. " " .. entry
    end
    return entry
  end, completions)
end

local function executeShellCommand()
  local opts = {
    prompt = "Command::",
    completion = "customlist,v:lua.custom_completion",
    icon_pos = false,
    prompt_pos = "title",
  }
  vim.ui.input(opts, function(input)
    local inpt = require("snacks.input")
    local win = inpt.input(opts, function() end) or nil
    if win ~= nil then
      win.destroy(win)
      -- vim.api.nvim_win_close(win, true)
    end
    if input == nil then
      return
    end
    if input ~= "" then
      local input_args = input:gsub("([^\\])(&)", "%1\\%2"):gsub("\\\n", " "):gsub("\n", " ")
      local escaped_cmd = vim.fn.shellescape(input_args, true)
      local title = "\\ \\ \\ \\ \\ cmd:\\ "
        .. input:sub(1, 100):gsub("[^%w_-]", "_")
        .. "\\ \\ \\ \\ "
      vim.cmd(
        string.format(
          "FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0 --title=%s zsh -ic %s",
          title,
          escaped_cmd
        )
      )
      -- vim.fn.execute(
      --   ":FloatermNew! --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0 --title="
      --     .. "\\ \\ \\ \\ \\ cmd:\\ "
      --     .. input:gsub("(?<!\\)([()#%%$])", "\\%1"):gsub(" ", "\\ ")
      --     .. "\\ \\ \\ \\ "
      --     .. " "
      --     .. input:gsub("(?<!\\)([()#%%$])", "\\%1")
      --     .. " ; exit"
      -- )
      -- execute_command is a simple script containing only zsh -i -c $@
      vim.fn.histadd("input", input)
    else
      vim.fn.execute(
        ":FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0"
      )
    end
  end)
  --
  -- vim.ui.input(
  --   { prompt = "Command: ", completion = "customlist,v:lua.custom_completion" },
  --   function(input)
  --     if input == nil then
  --       return
  --     end
  --     if input ~= "" then
  --       vim.fn.execute(
  --         ":FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0 ZDOTDIR=$HOME zsh -i -c '"
  --           .. input:gsub("\\([ ()%%#$])", "\\%1"):gsub("'", '"')
  --           .. "'"
  --       )
  --     else
  --       vim.fn.execute(
  --         ":FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0"
  --       )
  --     end
  --   end
  -- )
end

local function change_cwd_to_terminal_path()
  local function find_git_root(path)
    local git_path = path .. "/.git"
    if vim.loop.fs_stat(git_path) then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return nil
    end
    return find_git_root(parent)
  end
  vim.defer_fn(function()
    local path = vim.fn.getreg("+")
    local git_root = find_git_root(path)
    if git_root then
      vim.cmd("silent! tc " .. git_root)
      print(git_root)
    else
      vim.cmd("silent! tc " .. path)
      print(path)
    end
  end, 100)
end

function Close_buffer_force()
  local buftype = vim.bo.buftype
  if buftype == "terminal" then
    vim.api.nvim_command("q")
  else
    vim.api.nvim_command("q!")
  end
end

_G.change_cwd_to_terminal_path = change_cwd_to_terminal_path

-- local builtin = require("telescope.builtin")
-- CMD
vim.api.nvim_create_user_command("Command", function(input)
  -- vim.fn.execute(
  --   ":FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0 "
  --     .. input.args:gsub("\\([ ()%%#$])", "`%1")
  -- )

  if input.args ~= "" then
    local input_args = input.args:gsub("([^\\])(&)", "%1\\%2")
    local escaped_cmd = vim.fn.shellescape(input_args, true)
    -- local title = "\\ \\ \\ \\ \\ cmd:\\ " .. input_args:gsub(" ", "\\ ") .. "\\ \\ \\ \\ "
    local title = input.args:sub(1, 30):gsub("[^%w_-]", "_")
    vim.cmd(
      string.format(
        "FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0 --title=%s zsh -ic %s",
        title,
        escaped_cmd
      )
    )
  else
    vim.fn.execute(
      ":FloatermNew --height=0.5 --width=0.8 --wintype=float --name=cmd --position=bottom --autoclose=0"
    )
  end
end, { nargs = "*", complete = "customlist,v:lua.completionForRun" })
-- vim.keymap.set("c", "<Esc>", "<C-f>", {})
vim.keymap.set("c", "<Esc>", function()
  local current_cmd = vim.fn.getcmdline()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-c><C-\\><C-n>", true, false, true),
    "n",
    false
  )
  if current_cmd:sub(0, 7) ~= "Command" then
    return
  end
  vim.ui.input({
    prompt = "cmdline",
    completion = "customlist,v:lua.custom_completion",
    icon_pos = false,
    prompt_pos = "title",
    default = current_cmd,
  }, function(input)
    vim.fn.histadd("cmd", input)
    vim.fn.execute(input)
  end)
end, {})

vim.api.nvim_create_user_command("Notes", "Neorg workspace notes", {})
vim.api.nvim_create_user_command("Pwd", function()
  vim.notify(vim.fn.getcwd())
end, {})

-- Workdir
vim.keymap.set("n", "<leader>b;", ':let @+ = expand("%:p")<cr>', { desc = "Copy Name" })
vim.keymap.set("n", "<leader>t;", ":tc %:p:h<cr>", { desc = "Change Directory to file path" })
vim.keymap.set("n", "<leader>tr", ":tc <C-r>+<cr>", { desc = "Change Directory to file path" })
vim.keymap.set("n", "<leader>-", ":tc -<cr>:Pwd<cr>", { desc = "Cd -" })
vim.keymap.set("n", "<C-p>", ":Pwd<cr>", { noremap = false, desc = "Print Working Directory" })

-- vim.keymap.set("t", "<M-a>", function()
--   vim.fn.feedkeys("pwc\n")
--   vim.defer_fn(function()
--     -- vim.cmd("tcd " .. vim.fn.getreg("+"))
--     vim.api.nvim_set_current_dir(vim.trim(vim.fn.getreg("+")))
--     vim.api.nvim_set_current_dir(vim.trim(vim.fn.getreg("+")))
--     vim.cmd("stopinsert")
--   end, 100)
-- end, { noremap = true, silent = true, desc = "Change to terminal path" })

vim.api.nvim_create_autocmd({ "TermRequest" }, {
  desc = "Handles OSC 7 dir change requests",
  callback = function(ev)
    if string.sub(ev.data.sequence, 1, 4) == "\x1b]7;" then
      local dir = string.gsub(ev.data.sequence, "\x1b]7;file://[^/]*", "")
      if vim.fn.isdirectory(dir) == 0 then
        local now = vim.loop.now() / 1000 -- seconds
        local last = vim.b.osc7_last_notify or 0
        if now - last > 5 then -- 5 second cooldown
          vim.notify("invalid dir: " .. dir)
          vim.b.osc7_last_notify = now
        end
        return
      end
      vim.api.nvim_buf_set_var(ev.buf, "osc7_dir", dir)
      if vim.api.nvim_get_current_buf() == ev.buf then
        vim.cmd.cd(dir)
      end
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "DirChanged" }, {
  callback = function(ev)
    if vim.b.osc7_dir and vim.fn.isdirectory(vim.b.osc7_dir) == 1 then
      vim.cmd.cd(vim.b.osc7_dir)
    end
  end,
})

-- vim.api.nvim_set_keymap(
--   "t",
--   "<M-a>",
--   -- 'pwc<CR><C-\\><C-n><cmd>lua vim.cmd("cd " .. vim.fn.getreg("+"))<CR>',
--   { noremap = true, silent = true, desc = "Change to terminal path" }
-- )

vim.keymap.set("n", "<leader>,", function()
  local output = string.gsub(vim.fn.expand("%"), ".md", ".pdf")
  local command = ":!pandoc -t pdf --pdf-engine tectonic -o "
    .. output
    .. " --section-divs=true % ; okular "
    .. output
  vim.fn.execute(command)
end)

-- Files
vim.keymap.set("n", "<leader>L", ":!ls<cr>", { desc = "List Items" })
-- vim.keymap.set("n", "<leader>sF", function()
--   builtin.find_files({ hidden = true })
-- end, { desc = "[S]earch [F]iles (Hidden included)" })

-- LSP
vim.keymap.set(
  "n",
  "gv",
  ":vs | lua vim.lsp.buf.definition()<cr>",
  { desc = "Goto Definition split vertical" }
)
vim.keymap.set(
  "n",
  "gs",
  ":sp | lua vim.lsp.buf.definition()<cr>",
  { desc = "Goto Definition split horizontal" }
)
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set({ "n" }, "<leader>lR", "<cmd>LspRestart<cr>", { silent = true, noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>lr", function()
  -- local new_name = vim.fn.input({ prompt = "New name: " })
  -- vim.lsp.buf.rename(new_name)
  vim.lsp.buf.rename()
end, { silent = true, desc = "Rename across project" })

-- Fonts
vim.keymap.set("n", "<C-->", ":DecreaseFont<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-=>", ":IncreaseFont<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-+>", ":IncreaseFont<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-0>", ":ResetFontSize<CR>", { noremap = true, silent = true })

-- Splits
vim.keymap.set("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "\\", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>H", "<cmd>nohl<cr>", { desc = "Horizontal Split" })

-- Buffer
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
-- vim.keymap.set('n', '<C-s>', '<cmd>w!<cr>', { desc = 'Force write' })
-- vim.api.nvim_set_keymap('n', '<leader>q', ':lua Close_buffer_force()<CR>', { noremap = true, silent = true, desc = 'Close buffer' })
vim.keymap.set(
  { "n", "t", "v", "i" },
  "<C-q>",
  Close_buffer_force,
  { noremap = true, silent = true, desc = "Close buffer" }
)
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer Previous" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Buffer Next" })
vim.keymap.set("n", "<leader>Q", ":bd!<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>D", ":!ri -Force%<cr>", { noremap = true, desc = "Delete Item" })
vim.keymap.set("n", "<leader>bp", "<cmd>e #<cr>", { noremap = true, desc = "Open previous buffer" })

-- Tabs
vim.keymap.set("n", "<leader>te", ":tab sb<cr>", { desc = "Open in New Tab" })
vim.keymap.set("n", "<leader>tq", ":tabclose<cr>", { desc = "Open in New Tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Tab Next" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Tab Previous" })
vim.keymap.set({ "n", "t", "i" }, "<M-=>", "<cmd>tabnext<cr>", { noremap = true, silent = true })
vim.keymap.set(
  { "n", "t", "i" },
  "<M-->",
  "<cmd>tabprevious<cr>",
  { noremap = true, silent = true }
)
vim.keymap.set({ "n", "t", "i" }, "<M-b>", "<cmd>OpenDdgr<cr>", { noremap = true, silent = true })

-- Terminal & Navigation
vim.keymap.set("n", "<leader>T", ":term<cr>", { desc = "Terminal Here" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Terminal left window navigation" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Terminal down window navigation" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Terminal up window navigation" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Terminal right window navigation" })

vim.keymap.set({ "n", "i", "t" }, "<C-x>", function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-\\><C-n>i", true, false, true),
    "i",
    false
  )
  executeShellCommand()
end, { noremap = true })
-- vim.keymap.set({ "n", "i", "t", "c" }, "<C-x>", "<C-\\><C-n>:Command ", { noremap = true })
vim.keymap.set(
  "n",
  "<leader>e",
  "<cmd>Oil<cr>",
  { silent = true, noremap = true, desc = "Open Oil" }
)
vim.keymap.set("n", "<leader>E", function()
  local cur_buf = vim.fn.bufnr("%")
  vim.cmd("Oil")
  local oil_buf = vim.fn.bufnr("%")
  if (oil_buf ~= cur_buf) and (vim.fn.bufexists(cur_buf) == 1) then
    -- vim.api.nvim_buf_delete(cur_buf, { force = true })
    vim.cmd("bd! " .. cur_buf)
  end
end, { noremap = true, desc = "Open Oil but close last buffer" })

-- Highlight
vim.cmd("autocmd CursorMoved * set nohlsearch")
vim.api.nvim_set_keymap("n", "n", "n:set hlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-n>", "<S-n>:set hlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "#", "#:set hlsearch<CR>", { noremap = true, silent = true })

-- Git
vim.keymap.set({ "n", "i", "t" }, "<M-g>", ":G ", { noremap = true })
vim.keymap.set("n", "<leader>gb", ":G branch<cr>", { desc = "Git branch" })
vim.keymap.set("n", "<leader>gB", ":G branch -a <cr>", { desc = "Git branch all" })
vim.keymap.set("n", "<leader>gp", ":G pull<cr>", { desc = "Git pull" })
vim.keymap.set("n", "<leader>gP", ":G push<cr>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gF", ":G push --force<cr>", { desc = "Git push force" })
vim.keymap.set("n", "<leader>gf", ":G fetch<cr>", { desc = "Git fetch" })
vim.keymap.set("n", "<leader>gA", ":G add -A<cr>", { desc = "Git stage all" })
vim.keymap.set("n", "<leader>ga", ":G add %<cr>", { desc = "Git stage current" })
-- vim.keymap.set('n', '<leader>gc', ':G commit -m ', { desc = 'Git commit' })
vim.keymap.set("n", "<leader>gs", ":G<cr>", { desc = "Git status" })
-- vim.keymap.set('n', '<leader>gk', ':G checkout ', { desc = 'Git checkout' })

vim.keymap.set("n", "<leader>gk", function()
  local checkout_destination = vim.fn.input("Checkout Destination: ")
  vim.cmd("G checkout " .. checkout_destination)
end, { desc = "Git checkout" })

vim.keymap.set("n", "<leader>gc", function()
  local commit_message = vim.fn.input("Commit message: ")
  vim.cmd('G commit -m "' .. commit_message .. '"')
end, { desc = "Git commit" })

vim.keymap.set("n", "<leader>gl", function()
  local number_of_commits = vim.fn.input("Number of commits: ")
  local cmd =
    "G log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
  if number_of_commits == "" then
    vim.cmd(cmd)
  else
    vim.cmd(cmd .. ' -n "' .. number_of_commits .. '"')
  end
  -- vim.cmd(
  --   "G log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative -n '"
  --     .. number_of_commits
  --     .. "'"
  -- )
end, { desc = "Git log" })

-- Other
vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "New Line" })
vim.keymap.set("n", "<S-CR>", "O<Esc>", { desc = "New Line Before" })
-- vim.keymap.set({ "n", "v", "i" }, "<M-s>", ":Telescope file_browser<CR>")
-- vim.keymap.set({ "n", "v", "i" }, "<M-s>", function()
--   local buffername = vim.fn.bufname()
--   if string.match(buffername, "/$") then
--     local current_dir = require("oil").get_current_dir()
--     vim.fn.execute("Telescope file_browser path=" .. string.gsub(current_dir, " ", "\\ "), "silent")
--   else
--     vim.fn.execute("Telescope file_browser", "silent")
--   end
-- end)

return {}
