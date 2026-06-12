return {
  { "projekt0n/github-nvim-theme" },
  { "rose-pine/neovim" },
  { "catppuccin/nvim" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "github_dark",
      colorscheme = "rose-pine",
      -- colorscheme = "catppuccin-frappe",
      -- colorscheme = "cyberdream",
    },
  },
}
