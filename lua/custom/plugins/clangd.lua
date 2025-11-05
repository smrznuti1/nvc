-- local lspconfig = require 'lspconfig'
local capabilities = require("blink.cmp").get_lsp_capabilities()
capabilities =
  vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
capabilities.offsetEncoding = { "utf-16" }

vim.lsp.config("clangd", {
  settings = {
    clangd = {
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  capabilities = capabilities,
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    "Makefile",
    ".git",
  },
  -- root_dir = lspconfig.util.root_pattern(
  --   ".clangd",
  --   ".clang-tidy",
  --   ".clang-format",
  --   "compile_commands.json",
  --   "compile_flags.txt",
  --   "configure.ac",
  --   "Makefile",
  --   ".git"
  -- ),
})

vim.lsp.enable("clangd")
return {}
