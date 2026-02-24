-- return {
--   'nvim-treesitter/nvim-treesitter',
--   dependencies = {
--     {
--       'nvim-treesitter/nvim-treesitter-context',
--       opts = {
--         max_lines = 4,
--         multiline_threshold = 2,
--       },
--     },
--   },
--   lazy = false,
--   branch = 'main',
--   build = ':TSUpdate',
--   config = function()
--     local ts = require('nvim-treesitter')
--
--     -- State tracking for async parser loading
--     local parsers_loaded = {}
--     local parsers_pending = {}
--     local parsers_failed = {}
--
--     local ns = vim.api.nvim_create_namespace('treesitter.async')
--
--     -- Helper to start highlighting and indentation
--     local function start(buf, lang)
--       local ok = pcall(vim.treesitter.start, buf, lang)
--       if ok then
--         vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--       end
--       return ok
--     end
--
--     -- Install core parsers after lazy.nvim finishes loading all plugins
--     vim.api.nvim_create_autocmd('User', {
--       pattern = 'LazyDone',
--       once = true,
--       callback = function()
--         ts.install({
--           'bash',
--           'comment',
--           'css',
--           'diff',
--           'fish',
--           'git_config',
--           'git_rebase',
--           'gitcommit',
--           'gitignore',
--           'html',
--           'javascript',
--           'json',
--           'latex',
--           'lua',
--           'luadoc',
--           'make',
--           'markdown',
--           'markdown_inline',
--           'norg',
--           'python',
--           'query',
--           'regex',
--           'scss',
--           'svelte',
--           'toml',
--           'tsx',
--           'typescript',
--           'typst',
--           'vim',
--           'vimdoc',
--           'vue',
--           'xml',
--         }, {
--           max_jobs = 8,
--         })
--       end,
--     })
--
--     -- Decoration provider for async parser loading
--     vim.api.nvim_set_decoration_provider(ns, {
--       on_start = vim.schedule_wrap(function()
--         if #parsers_pending == 0 then
--           return false
--         end
--         for _, data in ipairs(parsers_pending) do
--           if vim.api.nvim_buf_is_valid(data.buf) then
--             if start(data.buf, data.lang) then
--               parsers_loaded[data.lang] = true
--             else
--               parsers_failed[data.lang] = true
--             end
--           end
--         end
--         parsers_pending = {}
--       end),
--     })
--
--     local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
--
--     local ignore_filetypes = {
--       'checkhealth',
--       'lazy',
--       'mason',
--       'snacks_dashboard',
--       'snacks_notif',
--       'snacks_win',
--     }
--
--     -- Auto-install parsers and enable highlighting on FileType
--     vim.api.nvim_create_autocmd('FileType', {
--       group = group,
--       desc = 'Enable treesitter highlighting and indentation (non-blocking)',
--       callback = function(event)
--         if vim.tbl_contains(ignore_filetypes, event.match) then
--           return
--         end
--
--         local lang = vim.treesitter.language.get_lang(event.match) or event.match
--         local buf = event.buf
--
--         if parsers_failed[lang] then
--           return
--         end
--
--         if parsers_loaded[lang] then
--           -- Parser already loaded, start immediately (fast path)
--           start(buf, lang)
--         else
--           -- Queue for async loading
--           table.insert(parsers_pending, { buf = buf, lang = lang })
--         end
--
--         -- Auto-install missing parsers (async, no-op if already installed)
--         ts.install({ lang })
--       end,
--     })
--   end,
-- }


-- treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require 'nvim-treesitter'
        local parsers = {
            "bash",
            "comment",
            "css",
            "diff",
            "dockerfile",
            "elixir",
            "git_config",
            "gitcommit",
            "gitignore",
            "groovy",
            "go",
            "heex",
            "hcl",
            "html",
            "http",
            "java",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "regex",
            "rst",
            "rust",
            "scss",
            "ssh_config",
            "sql",
            "terraform",
            "typst",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        }

        for _, parser in ipairs(parsers) do
            ts.install(parser)
        end

        -- Not every tree-sitter parser is the same as the file type detected
        -- So the patterns need to be registered more cleverly
        local patterns = {}
        for _, parser in ipairs(parsers) do
            local parser_patterns = vim.treesitter.language.get_filetypes(parser)
            for _, pp in pairs(parser_patterns) do
                table.insert(patterns, pp)
            end
        end

        vim.treesitter.language.register("groovy", "Jenkinsfile")
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'

        vim.api.nvim_create_autocmd('FileType', {
            pattern = patterns,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}

