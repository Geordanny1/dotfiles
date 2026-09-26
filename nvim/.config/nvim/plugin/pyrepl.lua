if vim.g.loaded_pyrepl then
  return
end
vim.g.loaded_pyrepl = true

local pyrepl = require('pyrepl')

vim.api.nvim_create_user_command('PyReplToggle', function()
  pyrepl.toggle()
end, { desc = 'Toggle the vertical Python REPL split' })

vim.api.nvim_create_user_command('PyReplOpen', function()
  pyrepl.open()
end, { desc = 'Open/focus the vertical Python REPL split' })

vim.api.nvim_create_user_command('PyReplClose', function()
  pyrepl.close()
end, { desc = 'Hide the Python REPL split (keeps it running)' })

vim.api.nvim_create_user_command('PyReplRun', function()
  pyrepl.run_current_file()
end, { desc = 'Re-run current file in the REPL, preserving state' })

local group = vim.api.nvim_create_augroup('PyReplAutoRun', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = group,
  pattern = '*.py',
  callback = function()
    pyrepl.on_save()
  end,
})
