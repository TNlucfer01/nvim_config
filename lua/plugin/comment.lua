-- Comment.nvim
return{ {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end,
},		-- nvim-surround
{
  "kylechui/nvim-surround",
  version = "*", -- latest stable
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- 🔽 Change options here for practice
      keymaps = {
        normal = "ys",   -- add surround
        delete = "ds",   -- delete surround
        change = "cs",   -- change surround
      },
    })
  end,
}

}

