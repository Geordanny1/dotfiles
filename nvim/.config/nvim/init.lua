
vim.g.mapleader = ' '

vim.o.number         = true
vim.o.relativenumber = true
vim.o.expandtab      = true

vim.o.shiftwidth = 2
vim.o.tabstop    = 2

vim.pack.add({

	{src = 'https://github.com/nvim-lua/plenary.nvim'},
	{src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
	{src = 'https://github.com/nvim-telescope/telescope.nvim'},

	{src = 'https://github.com/jaredgorski/fogbell.vim'},
	{src = 'https://github.com/vague-theme/vague.nvim'},
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>ec', function()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath('config')
  }
end)

require('telescope').setup{

  defaults = {
  },

  pickers = {

    find_files = {
      theme = "ivy",
    },

  },
  extensions = {
    
  }
}

require('vague').setup({
  transparent = false, -- If true, background is not set
  bold = true, -- Disable bold globally
  italic = false, -- Disable italic globally
  on_highlights = function(hl, colors) end,
  colors = {
    bg = '#141415',
    inactiveBg = '#1c1c24',
    fg = '#cdcdcd',
    floatBorder = '#878787',
    line = '#252530',
    comment = '#606079',
    builtin = '#b4d4cf',
    func = '#c48282',
    string = '#69b632',
    number = '#e0a363',
    property = '#c3c3d5',
    constant = '#aeaed1',
    parameter = '#bb9dbd',
    visual = '#333738',
    error = '#d8647e',
    warning = '#f3be7c',
    hint = '#7e98e8',
    operator = '#90a0b5',
    keyword = '#f6d631',
    type = '#9bb4bc',
    search = '#405065',
    plus = '#7fa563',
    delta = '#f3be7c',
  },
})

vim.cmd[[colorscheme vague]]

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
  callback = function() vim.hl.hl_op() end,
})

