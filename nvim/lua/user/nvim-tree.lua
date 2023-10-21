-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
--[[ nvim_tree.setup({ ]]
--[[   sort_by = "case_sensitive", ]]
--[[   view = { ]]
--[[     width = 30, ]]
--[[   }, ]]
--[[   renderer = { ]]
--[[     group_empty = true, ]]
--[[   }, ]]
--[[   filters = { ]]
--[[     dotfiles = true, ]]
--[[   }, ]]
--[[ }) ]]

nvim_tree.setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  open_on_tab = false,
  sort_by = "case_sensitive",
  update_cwd = true,
  reload_on_bufenter = false,
  respect_buf_cwd = true,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  --[[ renderer = { ]]
  --[[   add_trailing = false, ]]
  --[[   group_empty = false, ]]
  --[[   highlight_git = false, ]]
  --[[   full_name = false, ]]
  --[[   highlight_opened_files = "none", ]]
  --[[   root_folder_modifier = ":~", ]]
  --[[   indent_markers = { ]]
  --[[     enable = false, ]]
  --[[     icons = { ]]
  --[[       corner = "└ ", ]]
  --[[       edge = "│ ", ]]
  --[[       item = "│ ", ]]
  --[[       none = "  ", ]]
  --[[     }, ]]
  --[[   }, ]]
  --[[   icons = { ]]
  --[[     webdev_colors = true, ]]
  --[[     git_placement = "before", ]]
  --[[     padding = " ", ]]
  --[[     symlink_arrow = " ➛ ", ]]
  --[[     show = { ]]
  --[[       file = false, ]]
  --[[       folder = false, ]]
  --[[       folder_arrow = false, ]]
  --[[       git = true, ]]
  --[[     }, ]]
  --[[     glyphs = { ]]
  --[[       default = "", ]]
  --[[       symlink = "", ]]
  --[[       folder = { ]]
  --[[         arrow_closed = "", ]]
  --[[         arrow_open = "", ]]
  --[[         default = "", ]]
  --[[         open = "", ]]
  --[[         empty = "", ]]
  --[[         empty_open = "", ]]
  --[[         symlink = "", ]]
  --[[         symlink_open = "", ]]
  --[[       }, ]]
  --[[       git = { ]]
  --[[         unstaged = "✗", ]]
  --[[         staged = "✓", ]]
  --[[         unmerged = "", ]]
  --[[         renamed = "➜", ]]
  --[[         untracked = "★", ]]
  --[[         deleted = "", ]]
  --[[         ignored = "◌", ]]
  --[[       }, ]]
  --[[     }, ]]
  --[[   }, ]]
  --[[   special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" }, ]]
  --[[ }, ]]
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = false,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = true,
    },
    expand_all = {
      max_folder_discovery = 300,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
}
