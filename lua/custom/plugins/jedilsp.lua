local cmp = require("blink.cmp")
local lspconfig = require("lspconfig")
local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_capabilities = vim.tbl_deep_extend("force", lsp_capabilities, cmp.get_lsp_capabilities())
-- lspconfig.pylsp.setup({
--   settings = {
--     pylsp = {
--       plugins = {
--         -- formatter options
--         black = { enabled = false },
--         autopep8 = { cmd = "autopep8", enabled = false },
--         yapf = { enabled = false },
--         -- linter options
--         pylint = { enabled = false, executable = "pylint" },
--         pyflakes = { enabled = false },
--         pycodestyle = { enabled = false, maxLineLength = 200 },
--         -- type checker
--         pylsp_mypy = { enabled = true, live_mode = true, strict = false },
--         -- auto-completion options
--         jedi_completion = {
--           enabled = false,
--           fuzzy = true,
--           include_params = true,
--           include_class_objects = true,
--           include_function_objects = true,
--           resolve_at_most = 10,
--           eager = true,
--         },
--         jedi_definition = { enabled = false },
--         jedi_hover = { enabled = false },
--         jedi_references = { enabled = false },
--         jedi_signature_help = { enabled = false },
--         jedi_symbols = { enabled = false },
--         -- import sorting
--         pyls_isort = { enabled = false },
--         rope_autoimport = {
--           enabled = false,
--           completions = { enabled = true },
--           code_actions = { enabled = true },
--         },
--         rope_completion = {
--           enabled = false,
--           eager = true,
--         },
--         ruff = {
--           enabled = true, -- Enable the plugin
--           formatEnabled = true, -- Enable formatting using ruffs formatter
--           -- executable = "<path-to-ruff-bin>", -- Custom path to ruff
--           -- config = "<path_to_custom_ruff_toml>", -- Custom config for ruff to use
--           extendSelect = { "I" }, -- Rules that are additionally used by ruff
--           extendIgnore = { "C90", "I004" }, -- Rules that are additionally ignored by ruff
--           format = { "I" }, -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
--           severities = { ["D212"] = "I" }, -- Optional table of rules where a custom severity is desired
--           unsafeFixes = false, -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action
--
--           -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
--           lineLength = 200, -- Line length to pass to ruff checking and formatting
--           exclude = { "__about__.py" }, -- Files to be excluded by ruff checking
--           select = { "F" }, -- Rules to be enabled by ruff
--           ignore = { "D210" }, -- Rules to be ignored by ruff
--           perFileIgnores = { ["__init__.py"] = "CPY001" }, -- Rules that should be ignored for specific files
--           preview = true, -- Whether to enable the preview style linting and formatting.
--           targetVersion = "py310", -- The minimum python version to target (applies for both linting and formatting).
--         },
--       },
--     },
--   },
--   flags = {
--     debounce_text_changes = 200,
--   },
--   capabilities = lsp_capabilities,
--   root_dir = lspconfig.util.root_pattern("pyproject.toml", "requirements.txt", ".git"),
-- })

require("lspconfig").jedi_language_server.setup({
  init_options = {
    codeAction = {
      nameExtractVariable = "jls_extract_var",
      nameExtractFunction = "jls_extract_def",
    },
    completion = {
      disableSnippets = false,
      resolveEagerly = false,
      ignorePatterns = {},
    },
    diagnostics = {
      enable = true,
      didOpen = true,
      didChange = true,
      didSave = true,
    },
    hover = {
      enable = true,
      disable = {
        class = { all = false, names = {}, fullNames = {} },
        ["function"] = { all = false, names = {}, fullNames = {} },
        instance = { all = false, names = {}, fullNames = {} },
        keyword = { all = false, names = {}, fullNames = {} },
        module = { all = false, names = {}, fullNames = {} },
        param = { all = false, names = {}, fullNames = {} },
        path = { all = false, names = {}, fullNames = {} },
        property = { all = false, names = {}, fullNames = {} },
        statement = { all = false, names = {}, fullNames = {} },
      },
    },
    jediSettings = {
      autoImportModules = {},
      caseInsensitiveCompletion = true,
      debug = false,
    },
    markupKindPreferred = "markdown",
    workspace = {
      extraPaths = {},
      symbols = {
        ignoreFolders = { ".nox", ".tox", ".venv", "__pycache__", "venv" },
        maxSymbols = 20,
      },
    },
  },
  capabilities = lsp_capabilities,
  root_dir = function(fname)
    return lspconfig.util.root_pattern("pyproject.toml", "requirements.txt", ".git")(fname)
      or vim.fs.dirname(fname)
  end,
  -- root_dir = lspconfig.util.root_pattern("pyproject.toml", "requirements.txt", ".git"),
})

return {}
