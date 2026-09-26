local M = {}

---@class PyReplConfig
M.config = {
  -- Interpreter to launch. 'auto' picks ipython if available, else python3.
  interpreter = 'auto',
  -- How to open the split. Use 'vsplit' for left, 'botright vsplit' for right.
  split_cmd = 'botright vsplit',
  -- Width of the vertical REPL split, as a fraction of total columns (0-1).
  width_percent = 0.3,
  -- Automatically re-run the file in the REPL on :w
  auto_run_on_save = true,
  -- Enter insert mode when the REPL window is focused/opened.
  start_insert = true,
  -- Optional keymaps, set during setup(). Leave a value nil/omitted to skip it.
  -- keymaps = { toggle = '<leader>rt', run = '<leader>rr', open = '<leader>ro', close = '<leader>rc' }
  keymaps = nil,
}

---@class PyReplState
M.state = {
  buf = nil,     ---@type integer|nil
  win = nil,     ---@type integer|nil
  job_id = nil,  ---@type integer|nil
  cmd = nil,     ---@type string|nil  resolved interpreter command
}

local function resolve_interpreter()
  if M.config.interpreter ~= 'auto' then
    return M.config.interpreter
  end
  if vim.fn.executable('ipython') == 1 then
    return 'ipython --no-autoindent'
  end
  return 'python3'
end

function M.is_repl_running()
  if not M.state.job_id then
    return false
  end
  local ok, status = pcall(vim.fn.jobwait, { M.state.job_id }, 0)
  return ok and status[1] == -1
end

local function repl_width()
  return math.max(1, math.floor(vim.o.columns * M.config.width_percent))
end

local function reset_state()
  M.state.buf = nil
  M.state.win = nil
  M.state.job_id = nil
  M.state.cmd = nil
end

--- Create a brand new REPL terminal in a vertical split.
local function create_repl()
  M.state.cmd = resolve_interpreter()

  vim.cmd(M.config.split_cmd)
  vim.cmd('vertical resize ' .. repl_width())

  vim.cmd('terminal ' .. M.state.cmd)

  M.state.buf = vim.api.nvim_get_current_buf()
  M.state.win = vim.api.nvim_get_current_win()
  M.state.job_id = vim.b.terminal_job_id

  vim.bo[M.state.buf].buflisted = false
  vim.wo[M.state.win].number = false
  vim.wo[M.state.win].relativenumber = false

  vim.api.nvim_create_autocmd('TermClose', {
    buffer = M.state.buf,
    once = true,
    callback = function()
      vim.schedule(reset_state)
    end,
  })

  if M.config.start_insert then
    vim.cmd('startinsert')
  end
end

--- Open the REPL split, reusing the existing terminal buffer/job if present.
function M.open()
  -- Already visible: just focus it.
  if M.state.win and vim.api.nvim_win_is_valid(M.state.win) then
    vim.api.nvim_set_current_win(M.state.win)
    if M.config.start_insert then
      vim.cmd('startinsert')
    end
    return
  end

  -- Buffer/job alive but hidden: re-show it in a new split, no new process.
  if M.state.buf and vim.api.nvim_buf_is_valid(M.state.buf) and M.is_repl_running() then
    vim.cmd(M.config.split_cmd)
    vim.api.nvim_win_set_buf(0, M.state.buf)
    vim.cmd('vertical resize ' .. repl_width())
    M.state.win = vim.api.nvim_get_current_win()
    if M.config.start_insert then
      vim.cmd('startinsert')
    end
    return
  end

  -- Nothing usable: start fresh.
  reset_state()
  create_repl()
end

--- Hide the REPL window (keeps the process/buffer alive).
function M.close()
  if M.state.win and vim.api.nvim_win_is_valid(M.state.win) then
    vim.api.nvim_win_hide(M.state.win)
  end
  M.state.win = nil
end

--- Toggle the REPL window visibility.
function M.toggle()
  if M.state.win and vim.api.nvim_win_is_valid(M.state.win) then
    M.close()
  else
    M.open()
  end
end

--- Send raw text to the REPL's stdin.
function M.send(text)
  if not M.is_repl_running() then
    vim.notify('pyrepl: no running REPL (use :PyReplOpen)', vim.log.levels.WARN)
    return
  end
  vim.fn.chansend(M.state.job_id, text)
end

--- Re-run the current python file inside the REPL, preserving its namespace.
function M.run_current_file()
  local ft = vim.bo.filetype
  if ft ~= 'python' then
    return
  end

  local path = vim.fn.expand('%:p')
  if path == '' then
    return
  end

  -- Auto-start the REPL the first time a python file is saved, if desired.
  if not M.is_repl_running() then
    return
  end

  local cmd
  if M.state.cmd and M.state.cmd:match('^ipython') then
    -- -i runs inside the existing interactive namespace, so prior
    -- variables survive; top-level defs/classes get redefined.
    cmd = string.format('%%run -i %s\n', vim.fn.shellescape(path))
  else
    cmd = string.format('exec(open(%s).read())\n', string.format('%q', path))
  end

  M.send(cmd)
end

--- Called from the BufWritePost autocmd.
function M.on_save()
  if M.config.auto_run_on_save then
    M.run_current_file()
  end
end

local function apply_keymaps()
  local km = M.config.keymaps
  if not km then
    return
  end
  local actions = {
    toggle = M.toggle,
    run = M.run_current_file,
    open = M.open,
    close = M.close,
  }
  for name, lhs in pairs(km) do
    local fn = actions[name]
    if fn and lhs then
      vim.keymap.set('n', lhs, fn, { desc = 'PyREPL: ' .. name })
    end
  end
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', M.config, opts or {})
  apply_keymaps()
end

return M
