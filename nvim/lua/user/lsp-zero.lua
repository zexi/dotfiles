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
--[[ vim.opt['signcolumn'] = 'no' ]]

lsp_zero.on_attach(function(client, bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  -- keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions reuse_win=true<cr>", opts)
  keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_type_definitions reuse_win=true<cr>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references include_current_line=false include_declaration=false<cr>", opts)
  keymap(bufnr, "n", "gi", "<cmd>Telescope lsp_implementations jump_type=never reuse_win=true<cr>", opts)
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- keymap(bufnr, "n", '<leader>g', "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", '<leader>g', "<cmd>CodeActionMenu<cr>", opts)

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
local lsp_types = require('cmp.types').lsp
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind_comparator = function(conf)
  return function(entry1, entry2)
    local src_name1 = entry1.source.name
    local src_name2 = entry2.source.name
    -- if src_name1 ~= 'nvim_lsp' and src_name1 ~= 'luasnip' then
    --   if src_name2 == 'nvim_lsp' then
    --     return false
    --   else
    --     return nil
    --   end
    -- end
    if src_name1 ~= 'nvim_lsp' then
      if src_name2 == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end

    local kind_name1 = entry1:get_kind()
    local kind_name2 = entry2:get_kind()

    local kind1 = lsp_types.CompletionItemKind[kind_name1]
    if src_name1 == 'luasnip' then
      kind1 = 'luasnip'
    end
    local kind2 = lsp_types.CompletionItemKind[kind_name2]
    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0

    if priority1 == priority2 then
      return nil
    end
    if priority2 < priority1 then
      return true
    end
    return false
  end
end

local snippet_comparator = function(entry1, entry2)
  local src_name1 = entry1.source.name
  local src_name2 = entry2.source.name
  if src_name2 == 'luasnip' and src_name1 == 'nvim_lsp' then
    if lsp_types.CompletionItemKind[entry1:get_kind()] == 'Snippet' then
      print(src_name1)
      print(src_name2)
      return false
    end
  end
  return nil
end

local label_comparator = function(entry1, entry2)
  return false
  -- print(entry1)
  -- print(entry2)
  -- print("-----")
  -- if #entry1.completion_item.label == #entry2.completion_item.label then
  --   return false
  -- end
  -- return #entry1.completion_item.label < #entry2.completion_item.label
end

cmp.setup({
  -- FROM: https://www.reddit.com/r/neovim/comments/u3c3kw/how_do_you_sorting_cmp_completions_items/
  sources = {
    { name = 'nvim_lsp', keyword_length = 1, priority = 8 },
    { name = 'luasnip',  keyword_length = 1, priority = 7 },
    {
      name = 'buffer',
      keyword_length = 2,
      priority = 7,
      --[[ option = { ]]
      --[[   get_bufnrs = function() ]]
      --[[     local bufs = {} ]]
      --[[     for _, win in ipairs(vim.api.nvim_list_wins()) do ]]
      --[[       bufs[vim.api.nvim_win_get_buf(win)] = true ]]
      --[[     end ]]
      --[[     return vim.tbl_keys(bufs) ]]
      --[[   end ]]
      --[[ } ]]
      -- REF: https://github.com/hrsh7th/cmp-buffer#get_bufnrs-type-fun-number
    },
    { name = 'nvim_lua', keyword_length = 1, priority = 5 },
    { name = "path",     priority = 4 },
  },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_fullfuzzy_matching = false,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      -- FROM: https://github.com/hrsh7th/nvim-cmp/issues/156#issuecomment-916338617
      lspkind_comparator({
        kind_priority = {
          Keyword = 12,
          Variable = 11,
          Field = 11,
          Property = 11,
          Method = 11,
          Function = 11,
          Constant = 11,
          Operator = 10,
          Class = 10,
          Struct = 10,
          Enum = 10,
          EnumMember = 10,
          Event = 10,
          luasnip = 10,
          Snippet = 10,
          Reference = 10,
          File = 8,
          Folder = 8,
          Color = 5,
          Module = 5,
          Constructor = 1,
          Interface = 1,
          Text = 1,
          TypeParameter = 1,
          Unit = 1,
          Value = 1,
        },
      }),
      -- snippet_comparator,
      -- label_comparator,
      cmp.config.compare.exact,    -- Entries with exact == true will be ranked higher.
      cmp.config.compare.offset,   -- Entries with smaller offset will be ranked higher.
      cmp.config.compare.scopes,   -- Entries definied in a closer scope will be ranked higher (e.g., prefer local variables to globals).
      cmp.config.compare.score,    -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      -- cmp.config.compare.recently_used, -- Entries that are used recently will be ranked higher.
      cmp.config.compare.locality, -- Entries with higher locality (i.e., words that are closer to the cursor) will be ranked higher. See GH-183 for more details.
      -- cmp.config.compare.kind,          -- Entires with smaller ordinal value of 'kind' will be ranked higher. See lsp.CompletionItemKind enum. Exceptions are that Text(1) will be ranked the lowest, and snippets be the highest.
      -- cmp.config.compare.sort_text, -- Entries will be ranked according to the lexicographical order of sortText.
      cmp.config.compare.length, -- Entries with shorter label length will be ranked higher
      cmp.config.compare.order,  -- Entries with smaller id will be ranked higher.
    },
  },
  -- preselect = 'item',
  preselect = cmp.PreselectMode.None,
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
        -- elseif luasnip.expand_or_jumpable() then
        --   luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    ['<C-j>'] = cmp_action.luasnip_jump_forward(),
    ['<C-k>'] = cmp_action.luasnip_jump_backward(),
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
  -- settings = {
  --   gopls = {
  --     experimentalPostfixCompletions = true,
  --     analyses = {
  --       unusedparams = true,
  --       shadow = true,
  --     },
  --     staticcheck = true,
  --   }
  -- }
})

lspconfig.clangd.setup({
  cmd = { "clangd", "--function-arg-placeholders=0" }
})

lspconfig.tsserver.setup({})
lspconfig.html.setup({
  init_options = {
    provideFormatter = false
  }
})
lspconfig.cssls.setup({})
lspconfig.emmet_ls.setup({})
