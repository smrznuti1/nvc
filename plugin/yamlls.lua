vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["kubernetes"] = { "*-k8s.yml", "*-k8s.yaml" },
      },
    },
  },
})
