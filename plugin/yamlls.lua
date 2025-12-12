vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["kubernetes"] = { "*.yml", "*.yaml" },
      },
    },
  },
})

