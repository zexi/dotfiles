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
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  -- use 'cohama/lexima.vim'

  -- Easily comment stuff
  use { "numToStr/Comment.nvim", tag = 'v0.6' }
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  -- use "akinsho/bufferline.nvim"
  -- use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  -- use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  -- use "lukas-reineke/indent-blankline.nvim"
  -- use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  -- use "romainl/Apprentice"
  use {"adisen99/apprentice.nvim", requires = {"rktjmp/lush.nvim"}}
  use 'marko-cerovac/material.nvim'
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'

  -- LSP and completion
  -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  -- cmp plugins
  use "neovim/nvim-lspconfig" -- enable LSP
  -- coq completion
  -- use { "zexi/coq_nvim", branch = 'stop-cmp-syms' }
  -- -- use "ms-jpq/coq.artifacts"
  use { "lukas-reineke/lsp-format.nvim", tag = "v2.2.3" }
  use { "folke/lua-dev.nvim" }
  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- cmp completion
  -- use "hrsh7th/nvim-cmp" -- The completion plugin
  -- use "hrsh7th/cmp-nvim-lsp"
  -- use "hrsh7th/cmp-buffer" -- buffer completions
  -- use "hrsh7th/cmp-path" -- path completions
  -- use "hrsh7th/cmp-cmdline" -- cmdline completions
  -- use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'fannheyward/telescope-coc.nvim'
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
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use 'mzlogin/vim-markdown-toc'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
