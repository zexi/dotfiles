local lsp_zero = require('lsp-zero')

vim.lsp.buf.references({ includeDeclaration = false })

--[[ vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { ]]
--[[   border = "rounded", ]]
--[[ }) ]]
--[[]]
--[[ vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { ]]
--[[   border = "rounded", ]]
--[[ }) ]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    underline = true,
  })
vim.opt['signcolumn'] = 'no'

lsp_zero.on_attach(function(client, bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions jump_type=never ignore_filename=false<cr>", opts)
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references include_current_line=false include_declaration=false<cr>", opts)
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations jump_type=never ignore_filename=false<cr>", opts)
  keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  -- always use the active servers do autoformat
  lsp_zero.buffer_autoformat()
end)

-- auto formatting
--[[ lsp_zero.format_on_save({ ]]
--[[   format_opts = { ]]
--[[     asynv = false, ]]
--[[     timeout_ms = 10000, ]]
--[[   }, ]]
--[[   servers = { ]]
--[[     ['gopls'] = {'go'}, ]]
--[[   } ]]
--[[ }) ]]


--- auto completion setup

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    {
      name = 'buffer',
      -- REF: https://github.com/hrsh7th/cmp-buffer#get_bufnrs-type-fun-number
      --[[ option = { ]]
      --[[   get_bufnrs = function() ]]
      --[[     local bufs = {} ]]
      --[[     for _, win in ipairs(vim.api.nvim_list_wins()) do ]]
      --[[       bufs[vim.api.nvim_win_get_buf(win)] = true ]]
      --[[     end ]]
      --[[     return vim.tbl_keys(bufs) ]]
      --[[   end ]]
      --[[ } ]]
    },
    { name = 'nvim_lua' }
    --[[ { name = "path" }, ]]
  },
  -- preselect = 'item',
  --[[ preselect = cmp.PreselectMode.None, ]]
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          cmp.confirm()
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  -- (Optional) Show source name in completion menu
  formatting = cmp_format,
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
-- ref: https://github.com/windwp/nvim-autopairs/wiki/Completion-plugin


------- server configurations
-- CHECK: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local lspconfig = require('lspconfig')

local util = require 'lspconfig/util'

lspconfig.lua_ls.setup({
  -- for Neovim completions
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    }
  },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})

lspconfig.pyright.setup({
  settings = {
    python = {
      -- FROM: https://github.com/microsoft/pyright/blob/main/docs/settings.md
      analysis = {
        typeCheckingMode = 'off'
      }
    }
  }
})

lspconfig.gopls.setup({
  cmd = { 'gopls', 'serve' },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod"),
  init_options = {
    usePlaceholders = false,
  },
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    }
  }
})

lspconfig.clangd.setup({
  cmd = { "clangd", "--function-arg-placeholders=0" }
})

lspconfig.tsserver.setup({})
