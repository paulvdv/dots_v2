return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },

  "nvim-lua/plenary.nvim",

  -- Formatting
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require("configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },

  -- git
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
    }
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require("configs.git")
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end
  },

  -- Telescope 
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = "Telescope",
    opts = function()
      return require("configs.telescope")
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      local builtin = require("telescope.builtin")
      local map = vim.keymap.set

      map("n", "<C-p>", builtin.find_files, {})
      map("n", "<leader>fg", builtin.live_grep, {})
      map('n', '<leader>fb', builtin.buffers, {})
      map("n", "<leader><leader>", builtin.oldfiles, {})

      -- load extensions
      for _, ext in ipairs(opts.extensions) do
        telescope.load_extension(ext)
      end
    end,
  },
}
