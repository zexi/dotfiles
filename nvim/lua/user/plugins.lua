local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

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

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
  -- use 'm4xshen/autoclose.nvim'
  -- use 'cohama/lexima.vim'

  -- Easily comment stuff
  use "numToStr/Comment.nvim"
  -- use "kyazdani42/nvim-web-devicons"
  use { "nvim-tree/nvim-tree.lua",
    require = "nvim-tree/nvim-web-devicons" }
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "nvim-lualine/lualine.nvim"
  use "akinsho/toggleterm.nvim"
  use "stevearc/aerial.nvim"
  use "ahmedkhalf/project.nvim"
  -- use "lukas-reineke/indent-blankline.nvim"
  -- use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use {
    "folke/which-key.nvim",
  }

  -- Colorschemes
  use "EdenEast/nightfox.nvim"
  use "projekt0n/github-nvim-theme"
  use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim"
  }

  -- LSP and completion
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      -- {'williamboman/mason.nvim'},
      -- {'williamboman/mason-lspconfig.nvim'},

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'L3MON4D3/LuaSnip' },
      { "rafamadriz/friendly-snippets" },
      { 'saadparwaiz1/cmp_luasnip' },
      -- CodeAction
      {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
      }
    }
  }

  use "vim-test/vim-test"

  -- -- coc plugins
  -- use { 'neoclide/coc.nvim', branch = 'release' }
  -- use 'fannheyward/telescope-coc.nvim'

  use "buoto/gotests-vim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "BurntSushi/ripgrep"
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use 'tpope/vim-fugitive'

  -- Pretty list for showing diagnostics
  use "folke/trouble.nvim"

  -- Sessions management
  use 'rmagatti/auto-session'

  -- Markdown plugins
  use 'godlygeek/tabular'
  use 'preservim/vim-markdown'
  use 'dhruvasagar/vim-table-mode'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app &&  npx --yes yarn install' }
  use 'mzlogin/vim-markdown-toc'

  -- translator
  use 'voldikss/vim-translator'

  -- web-tools
  -- use 'ray-x/web-tools.nvim'
  use 'NvChad/nvim-colorizer.lua'

  -- notes
  use({
    'epwalsh/obsidian.nvim',
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
