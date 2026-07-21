vim.pack.add { 'https://github.com/FylerOrg/fyler.nvim' }

local function cursor_path(self)
  local node = require('fyler.finder').parse_cursor_line(self)
  if not node then return nil end
  local libpath = require 'fyler.lib.path'
  return libpath.to_os(libpath.to_abs(node.link or node.path))
end

require('fyler').setup {
  use_as_default_explorer = true,
  kind = 'replace',
  auto_confirm_simple_mutation = true,
  bound_cursor = true,
  follow_current_file = true,
  follow_root_dir = true,
  win_opts = {
    wrap = false,
    signcolumn = 'no',
    cursorcolumn = false,
    foldcolumn = '0',
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = 'nvic',
  },
  ui = {
    hidden_items = {
      switches = {},
      patterns = {},
      always_visible = {},
      always_hidden = {},
    },
    indent_guides = false,
  },
  mappings = {
    n = {
      ['gy'] = {
        action = function(self)
          local path = cursor_path(self)
          if not path then return end
          vim.fn.setreg('+', path)
          vim.notify('Yanked: ' .. path)
        end,
      },
      ['gh'] = { action = 'select', args = { split = true } },
      ['gv'] = { action = 'select', args = { vsplit = true } },
      ['<C-t>'] = { action = 'select', args = { tabedit = true } },
      ['<C-c>'] = { action = 'close' },
      ['gl'] = { action = 'refresh', args = { recursive = true, force = true } },
      ['-'] = { action = 'visit', args = { parent = true } },
      ['_'] = {
        action = function(self)
          self:visit { path = require('fyler.lib.path').to_normalize(vim.fn.getcwd()) }
        end,
      },
      ['`'] = {
        action = function(self)
          vim.cmd.cd { args = { vim.fn.fnameescape(self.state.pseudo_root_path) } }
        end,
      },
      ['~'] = {
        action = function(self)
          vim.cmd.tcd { args = { vim.fn.fnameescape(self.state.pseudo_root_path) } }
        end,
      },
      ['gx'] = {
        action = function(self)
          local path = cursor_path(self)
          if path then vim.ui.open(path) end
        end,
      },
      ['g.'] = { action = 'toggle_ui', args = { 'hidden_items' } },
      ['/'] = { action = function() require('snacks.picker').lines() end },
      ['gP'] = {
        action = function(self) vim.fn.setreg('+', self.state.pseudo_root_path) end,
      },
    },
  },
}
