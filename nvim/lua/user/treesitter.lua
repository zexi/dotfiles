local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "go", "python", "lua", "rust", "vue", "c", "lua" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    -- enable = true,
    enable = false,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  -- indent = { enable = true, disable = { "yaml" } },
  -- context_commentstring = {
  --   enable = false,
  --   enable_autocmd = false,
  -- },
}

-- folding: https://github.com/nvim-treesitter/nvim-treesitter#folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldenable=false
