return {
  {
    "tpope/vim-fugitive", -- Git commands
  },
  {
    "lewis6991/gitsigns.nvim", -- Show changes in the sign column
    config = function()
      require("gitsigns").setup()
    end,
  },
}

