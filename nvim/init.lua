if not vim.g.vscode then
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
  local lazy_conf = require "configs.lazy_nvim"

  require("options")
  require("lazy").setup({
    {
      lazy = false,
      branch = "v2.5",
      import = "plugins",
      config = function()
        require "options"
      end
    }
  }, lazy_conf)

  vim.schedule(
    function()
      require("keymap")
    end
  )

end
