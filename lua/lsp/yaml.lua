local lspconfig = require 'lspconfig'

return {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  filetypes = { 'yaml', 'yml' },
  root_dir = lspconfig.util.root_pattern('.git', '.yamllint', 'yamlfmt.yaml'),
  settings = {
    yaml = {
      schemas = {
        kubernetes = '/*.yaml',
        ['https://schemastore.org/github-action.json'] = '/.github/workflows/*.yml',
        ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] = 'docker-compose*.{yml,yaml}',
      },
      validate = true,
      format = { enable = true },
      completion = true,
    },
  },
} -- ← Ensure this closing bracket is correct
