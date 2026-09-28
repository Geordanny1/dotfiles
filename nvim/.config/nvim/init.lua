
vim.g.mapleader = ' '

vim.o.guicursor = 'i:block'
vim.o.number         = true
vim.o.relativenumber = true
vim.o.expandtab      = true

vim.o.shiftwidth = 2
vim.o.tabstop    = 2

vim.pack.add({

	{src = 'https://github.com/nvim-lua/plenary.nvim'},
	{src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
	{src = 'https://github.com/nvim-telescope/telescope.nvim'},

	{src = 'https://github.com/nanotech/jellybeans.vim'},
	{src = 'https://github.com/lervag/wiki.vim'},
})

vim.gwiki_root = '~/notes'

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>ec', function()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath('config')
  }
end)

vim.keymap.set('n', '<Esc>', function()
  vim.cmd.noh()
end)

vim.keymap.set('n', '<leader>w', function()
  vim.cmd.write()
end)


vim.keymap.set('n', '<leader>x', ':so<CR>')

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

vim.o.termguicolors = true
vim.cmd[[colorscheme jellybeans]]

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
  callback = function() vim.hl.hl_op() end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {

  pattern = {'*.njk' },

  callback = function()
    vim.o.filetype = "htmldjango"

  end

})


