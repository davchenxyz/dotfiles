local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print 'Installing packer close and reopen Neovim...'
    vim.cmd [[packadd packer.nvim]]
    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

local helpers = require('helpers')
local augroup = helpers.augroup
local autocmd = helpers.autocmd

-- Reload Neovim whenever you save the plugins.lua file
augroup('PackerUserConfig', function(group)
  autocmd('BufWritePost', {
    group = group,
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile'
  })
end)

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use 'EdenEast/nightfox.nvim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = [[require('plugins.lualine')]]
  }

  use {
    'kylechui/nvim-surround',
    tag = '*',
    config = [[require('nvim-surround').setup()]]
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({})

      -- https://github.com/windwp/nvim-autopairs/wiki/Endwise
      -- npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
      -- npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
      -- npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
    end
  }

  use {
    'numToStr/Comment.nvim', 
    as = 'comment',
    config = [[require('comment').setup()]]
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = [[require('telescope').setup()]],
  }

  -- Helpers for shell commands like mkdir/mv
  use 'tpope/vim-eunuch'

  -- Git operations
  use { 'tpope/vim-fugitive', opt = true, cmd = { 'G' } }

  use 'elixir-editors/vim-elixir'
  use {
    'mhinz/vim-mix-format',
    config = function()
      vim.cmd [[
        let g:mix_format_on_save = 1
      ]]
    end
  }

  -- Markdown
  use {
    'plasticboy/vim-markdown',
    requires = { 'godlygeek/tabular' },
    config = [[require('plugins.markdown')]]
  }

  -- Markdown preview
  use {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
    config = [[require('plugins.markdown_preview')]]
  }

  -- Fulltext search
  use 'mhinz/vim-grepper'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
