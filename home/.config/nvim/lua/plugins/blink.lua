return {
  "saghen/blink.cmp",
  lazy = true,
  dependencies = { "saghen/blink.compat" },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      compat = {},
    },
  },
}
