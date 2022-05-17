local cmp_opts = { noremap = true, silent = true, expr = true }
local remap = vim.api.nvim_set_keymap

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<Esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], cmp_opts)
remap('i', '<C-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], cmp_opts)
-- remap('i', '<BS>', [[pumvisible() ? "<c-e><BS>" : "<BS>"]], cmp_opts)
remap('i', '<Tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], cmp_opts)
remap('i', '<CR>', [[pumvisible() ? (complete_info().selected == -1 ? "<C-e><CR>" : "<C-y>") : "<CR>"]], cmp_opts)
-- remap('i', '<Tab>', [[pumvisible() ? (complete_info().selected == -1 ? "<C-e><Tab>" : "<C-y>") : "<Tab>"]], cmp_opts)
remap('i', '<S-Tab>', [[pumvisible() ? "<c-p>" : "<c-h>"]], cmp_opts)

vim.g.coq_settings = {
  keymap = {
    recommended = false,
    jump_to_mark = '',
    bigger_preview = '',
    -- pre_select = true,
  },
  auto_start = true,
  display = {
    pum = {
      fast_close = false
    }
  },
  clients = {
    snippets = {
      enabled = false,
      warn = {},
    },
    tree_sitter = {
      enabled = false,
    },
    tags = {
      enabled = false,
    },
    buffers = {
      enabled = false,
    },
    tmux = {
      enabled = false,
    },
  },
  -- completion = {
  --   stop_syms = {
  --     '{', '}', '(', ')', '[', ']', '', ',', ';',
  --   },
  -- },
  -- match = {
  --   exact_matches = 0,
  --   look_ahead = 0,
  -- },
  -- weights = {
  --   prefix_matches = 0,
  --   edit_distance = 0,
  -- }
}

local status_ok, coq = pcall(require, "coq")
if not status_ok then
  return
end

local M = {}
M.capabilities = function(opts)
  return coq.lsp_ensure_capabilities(opts)
end

return M
