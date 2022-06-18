-- Setup nvim-cmp.
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup({})
-- npairs.setup {
--   map_cr = false,
--   check_ts = true,
--   ts_config = {
--     lua = { "string", "source" },
--     javascript = { "string", "template_string" },
--     java = false,
--   },
--   disable_filetype = { "TelescopePrompt", "spectre_panel" },
--   fast_wrap = {
--     map = "<M-e>",
--     chars = { "{", "[", "(", '"', "'" },
--     pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
--     offset = 0, -- Offset from pattern match
--     end_key = "$",
--     keys = "qwertyuiopzxcvbnmasdfghjkl",
--     check_comma = true,
--     highlight = "PmenuSel",
--     highlight_grey = "LineNr",
--   },
-- }

-- local remap = vim.api.nvim_set_keymap
-- -- skip it, if you use another global object
-- _G.MUtils= {}
--
-- MUtils.completion_confirm=function()
--   if vim.fn.pumvisible() ~= 0  then
--     return vim.fn["coc#_select_confirm"]()
--   else
--     return npairs.autopairs_cr()
--   end
-- end
--
-- remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
