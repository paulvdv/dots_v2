return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local telescopeConfig = require("telescope.config")

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- don't search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")

      telescope.setup({
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
        },
        file_ignore_patterns = {
          ".git/*",
          "node_modules/*",
          "bower_components/*",
          ".svn/*",
          ".hg/*",
          "CVS/*",
          ".next/*",
          ".docz/*",
          ".DS_Store",
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      local builtin = require("telescope.builtin")
      local map = vim.keymap.set

      map("n", "<C-p>", builtin.find_files, {})
      map("n", "<leader>fg", builtin.live_grep, {})
      map('n', '<leader>fb', builtin.buffers, {})
      map("n", "<leader><leader>", builtin.oldfiles, {})

      require("telescope").load_extension("ui-select")
    end,
  },
}
