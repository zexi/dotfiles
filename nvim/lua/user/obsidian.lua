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
  }
})
