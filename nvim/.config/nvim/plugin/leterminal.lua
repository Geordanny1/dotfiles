-- bottom_term.lua (or paste into your init.lua)

local state = {
  buf = -1,
  win = -1,
}

local function create_window()
  local buf
  if vim.api.nvim_buf_is_valid(state.buf) then
    buf = state.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- no file, scratch
    state.buf = buf
  end

  -- Open a bottom split
  vim.cmd('botright split')
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  -- Set height to 30% of total lines
  local height = math.floor(vim.o.lines * 0.3)
  vim.api.nvim_win_set_height(win, height)

  state.win = win

  -- Only spawn a shell if this buffer doesn't already have one running
  if vim.bo[buf].buftype ~= 'terminal' then
    vim.fn.termopen(os.getenv('SHELL') or '/bin/bash')
  end

  -- Cosmetic: no line numbers in the terminal split
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'

  vim.cmd('startinsert')
end

function ToggleBottomTerm()
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    state.win = -1
    return
  end

  create_window()
end

vim.keymap.set({ 'n', 't' }, '<leader>tt', ToggleBottomTerm, { desc = 'Toggle bottom terminal' })


