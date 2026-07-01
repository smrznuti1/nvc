vim.pack.add { 'https://github.com/esmuellert/codediff.nvim' }

require('codediff').setup {
  highlights = {

    line_insert = 'DiffAdd',
    line_delete = 'DiffDelete',

    char_insert = nil,
    char_delete = nil,

    char_brightness = nil,

    conflict_sign = 'DiagnosticSignError',
    conflict_sign_resolved = 'Comment',
    conflict_sign_accepted = '#3fb950',
    conflict_sign_rejected = '#f85149',
  },

  diff = {
    layout = 'side-by-side',
    disable_inlay_hints = true,
    max_computation_time_ms = 5000,
    ignore_trim_whitespace = false,
    hide_merge_artifacts = false,
    original_position = 'left',
    conflict_ours_position = 'right',
    conflict_result_position = 'bottom',
    conflict_result_height = 30,
    conflict_result_width_ratio = { 1, 1, 1 },
    cycle_next_hunk = true,
    cycle_next_file = true,
    cycle_hunks_across_files = false,
    jump_to_first_change = true,
    highlight_priority = 100,
    compute_moves = false,
    compact_context_lines = 3,
    compact_sync_folds = true,
  },

  explorer = {
    position = 'left',
    hidden = false,
    width = 30,
    height = 15,
    auto_refresh = true,
    indent_markers = true,
    initial_focus = 'explorer',
    icons = {
      folder_closed = '',
      folder_open = '',
    },
    view_mode = 'list',
    flatten_dirs = true,
    file_filter = {
      ignore = { '.git/**', '.jj/**' },
    },
    focus_on_select = false,
    auto_open_on_cursor = false,
    status_right_margin = 1,
    visible_groups = {
      staged = true,
      unstaged = true,
      conflicts = true,
    },
  },

  history = {
    position = 'bottom',
    width = 40,
    height = 15,
    initial_focus = 'history',
    view_mode = 'list',
  },

  keymaps = {
    view = {
        quit = 'q',
        toggle_explorer = '<leader>b',
        focus_explorer = '<leader>e',
        next_hunk = ']c',
        prev_hunk = '[c',
        next_file = ']f',
        prev_file = '[f',
        diff_get = 'do',
        diff_put = 'dp',
        open_in_prev_tab = 'gf',
        close_on_open_in_prev_tab = false,
        toggle_stage = '-',
        stage_hunk = '<leader>hs',
        unstage_hunk = '<leader>hu',
        discard_hunk = '<leader>hr',
        hunk_textobject = 'ih',
        show_help = 'g?',
        align_move = 'gm',
        toggle_layout = 't',
        toggle_compact = 'gc',
      },
      explorer = {
        select = '<CR>',
        hover = 'K',
        refresh = 'R',
        toggle_view_mode = 'i',
        stage_all = 'S',
        unstage_all = 'U',
        restore = 'X',
        toggle_changes = 'gu',
        toggle_staged = 'gs',

        fold_open = 'zo',
        fold_open_recursive = 'zO',
        fold_close = 'zc',
        fold_close_recursive = 'zC',
        fold_toggle = 'za',
        fold_toggle_recursive = 'zA',
        fold_open_all = 'zR',
        fold_close_all = 'zM',
      },
      history = {
        select = '<CR>',
        toggle_view_mode = 'i',
        refresh = 'R',

        fold_open = 'zo',
        fold_open_recursive = 'zO',
        fold_close = 'zc',
        fold_close_recursive = 'zC',
        fold_toggle = 'za',
        fold_toggle_recursive = 'zA',
        fold_open_all = 'zR',
        fold_close_all = 'zM',
      },
      conflict = {
        accept_incoming = '<leader>ct',
        accept_current = '<leader>co',
        accept_both = '<leader>cb',
        discard = '<leader>cx',

        accept_all_incoming = '<leader>cT',
        accept_all_current = '<leader>cO',
        accept_all_both = '<leader>cB',
        discard_all = '<leader>cX',
        next_conflict = ']x',
        prev_conflict = '[x',
        diffget_incoming = '2do',
        diffget_current = '3do',
      },
    },
}

vim.cmd [[cnoreabbrev <expr> CD (getcmdtype() == ':' and getcmdline() ==# 'CD') and 'CodeDiff' or 'CD']]

vim.keymap.set('n', '<leader>ww', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.wo.linebreak = vim.wo.wrap
end, { desc = 'Toggle wrap' })
