return {
  "qvalentin/helm-ls.nvim",
  ft = "helm",
  config = function()
    vim.lsp.config("helm_ls", {
      settings = {
        helm_ls = {
          yamlls = {
            path = "yaml-language-server",
          },
        },
      },
    })
  end,
}
