
vim.g.mapleader = ' '
vim.o.guicursor = 'i:block'

vim.o.termguicolors = true

vim.o.number         = true
vim.o.relativenumber = true
vim.o.expandtab      = true

vim.o.shiftwidth = 2
vim.o.tabstop    = 2

vim.pack.add({

	{src = 'https://github.com/nvim-lua/plenary.nvim'},
	{src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
	{src = 'https://github.com/nvim-telescope/telescope.nvim'},

	{src = 'https://github.com/folke/flash.nvim'},

	{src = 'https://github.com/nanotech/jellybeans.vim'},
	{src = 'https://github.com/mattn/emmet-vim'}
})


vim.gwiki_root = '~/notes'
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Telescope help tags' })


vim.keymap.set({'n', 'x', 'o'}, 's', function()
  require('flash').jump()
end)

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


require('telescope').setup{

  defaults = {
  },

  pickers = {

    colorscheme = {
      enable_preview = true
    },
    find_files = {
      theme = "ivy",
    },
  },
  extensions = { } 
}

vim.cmd[[colorscheme jellybeans]]

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
  callback = function() vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {

  pattern = {'*.njk' },

  callback = function()
    vim.o.filetype = "htmldjango"

  end

})

vim.cmd[[
let g:user_emmet_settings = {
\  'variables': {'lang': 'en'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}
]]
