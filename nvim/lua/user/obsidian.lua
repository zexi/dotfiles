-- See: https://github.com/epwalsh/obsidian.nvim
require 'obsidian'.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/Library/Mobile Documents/com~apple~CloudDocs/notebooks"
    },
  },
  disable_frontmatter = true,
  note_id_func = function(title)
    -- only use file title
    return title
  end,
  templates = {
    subdir = "my-templates",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
  },
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.fn.jobstart({ "open", url }) -- Mac OS
    -- vim.fn.jobstart({"xdg-open", url})  -- linux
  end,
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        -- local cd = vim.fn.expand("%:~:h") .. '/'
        -- vim.api.nvim_set_current_dir(cd)
        -- print("---change to " .. cd)
        -- print(vim.fn.getcwd())
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },
})
