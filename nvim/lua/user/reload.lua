-- from: https://stackoverflow.com/questions/72412720/how-to-source-init-lua-without-restarting-neovim
function _G.ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match('^user') and not name:match('nvim-tree') then
      vim.notify("package: " .. name, vim.log.levels.INFO)
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  -- vim.notify(vim.env.MYVIMRC, vim.log.levels.INFO)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

-- Source --
vim.api.nvim_set_keymap("n", "<leader>so", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })
