vim.o.guicursor = 'i:block'
vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.splitbelow = true
vim.o.splitright = true

vim.cmd('filetype on')
vim.cmd('syntax on')

-- vim.opt.timeoutlen = 500

vim.pack.add({
  {src = 'https://github.com/mattn/emmet-vim'},
  {src = 'https://github.com/nvim-mini/mini.nvim' },
  {src = 'https://codeberg.org/andyg/leap.nvim'},
  {src = 'https://github.com/nvim-lua/plenary.nvim'},
  {src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
  {src = 'https://github.com/nvim-telescope/telescope.nvim'},
  {src = 'https://github.com/miikanissi/modus-themes.nvim'},
  {src = 'https://github.com/folke/flash.nvim'},
  {src = 'https://github.com/rebelot/kanagawa.nvim'},

})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>ec', ':e $MYVIMRC<CR>')

require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.completion').setup()
require('mini.move').setup()
require('mini.pairs').setup()
require('mini.misc').setup()

require('flash').setup()

MiniMisc.setup_auto_root()

-- shortcuts --
vim.keymap.set({ 'n', 'x', 'o' }, 's',  '<Plug>(leap)')
vim.keymap.set('n',               'S',  '<Plug>(leap-from-window)')

vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>e', ':Explore<CR>')

vim.keymap.set('n', '<leader>gg', ':copen | :silent :grep ')
vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprevious<CR>')

vim.keymap.set('n', '<leader>o', ':only<CR>')

-- colorscheme --
vim.cmd('colorscheme kanagawa-dragon')

vim.g.user_emmet_settings = {
  variables = { lang = 'en-US' },
  html = {
    default_attributes = {
      option = { value = vim.NIL },
      textarea = { id = vim.NIL, name = vim.NIL, cols = 10, rows = 10 },
    },
    snippets = {
      ['html:5'] = '<!DOCTYPE html>\n' .. '<html lang=\'${lang}\'>\n' .. '<head>\n'
        .. '\t<meta charset=\'${charset}\'>\n'
        .. '\t<title></title>\n'
        .. '\t<meta name=\'viewport\' content=\'width=device-width, initial-scale=1.0\'>\n'
        .. '</head>\n'
        .. '<body>\n\t${child}|\n</body>\n'
        .. '</html>',
    },
  },
}

vim.env.KITTYCONF = "/home/geordanny/.config/kitty/kitty.conf"

