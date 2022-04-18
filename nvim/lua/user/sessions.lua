local status_ok, session = pcall(require, "auto-session")
if not status_ok then
  return
end

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

session.setup({
  log_level = 'info',
  auto_ession_root_dir = vim.fn.stdpath('data').."/sessions/",
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
  -- auto_session_suppress_dirs = {'~/', '~/Projects'},
})
