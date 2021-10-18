require "nvim-treesitter.configs".setup {
  ensure_installed = {
      "c",
      "cpp",
      "rust",
      "toml",
      "json",
      "lua",
      "html",
      "css",
      "javascript",
      "python",
  },
  highlight = {
    enable = true,
  },
}
