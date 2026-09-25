vim.o.guicursor = 'i:block'
vim.g.mapleader = ' '

vim.o.number         = true
vim.o.relativenumber = true

vim.o.expandtab   = true
vim.o.softtabstop = 2
vim.o.tabstop     = 2
vim.o.shiftwidth  = 2
vim.o.splitbelow  = true
vim.o.splitright  = true

vim.cmd('filetype on')
vim.cmd('syntax on')

vim.pack.add({

  {src = 'https://github.com/mattn/emmet-vim'},
  {src = 'https://github.com/nvim-mini/mini.nvim' },

  {src = 'https://github.com/nvim-lua/plenary.nvim'},
  {src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim'},
  {src = 'https://github.com/nvim-telescope/telescope.nvim'},
  {src = 'https://github.com/folke/flash.nvim'},
  {src = 'https://github.com/lervag/wiki.vim'},

  {src = 'https://github.com/vague-theme/vague.nvim' },

  {src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
  {src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
  {src = 'https://github.com/glench/vim-jinja2-syntax' },
})


require('mini.surround').setup()
require('mini.statusline').setup()
require('mini.completion').setup()
require('mini.files').setup()
require('mini.move').setup()
require('mini.pairs').setup()
require('mini.misc').setup()
MiniMisc.setup_auto_root()
require('flash').setup()

vim.g.wiki_root = '~/wiki'

require('vague').setup({
  transparent = false, -- If true, background is not set
  bold = false, -- Disable bold globally
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
    string = '#E3D400',
    number = '#e0a363',
    property = '#c3c3d5',
    constant = '#aeaed1',
    parameter = '#bb9dbd',
    visual = '#333738',
    error = '#d8647e',
    warning = '#f3be7c',
    hint = '#7e98e8',
    operator = '#90a0b5',
    keyword = '#6e94b2',
    type = '#9bb4bc',
    search = '#405065',
    plus = '#7fa563',
    delta = '#f3be7c',
  },
})

vim.cmd[[colorscheme vague]]

local builtin = require('telescope.builtin')
require('telescope').setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}


require('nvim-treesitter').install { 'python', 'c', 'javascript', 'markdown', 'markdown_inline', 'jinja', 'jinja_inline' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'python', 'c', 'javascript', 'markdown', 'jinja' },
  callback = function()
    vim.treesitter.start()
  end,
})

vim.filetype.add({
  extension = {
    j2     = 'jinja',
    jinja  = 'jinja',
    jinja2 = 'jinja',
    njk    = 'htmldjango',
  },
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,  { desc = 'Telescope help tags' })

vim.keymap.set('i', 'jk', '<ESC>') 
vim.keymap.set('n', '<leader>ec', ':e $MYVIMRC<CR>')

vim.keymap.set('n', '<leader>f', ':lua MiniFiles.open()<CR>')

vim.keymap.set('n', '<leader>w', ':w<CR>')

vim.keymap.set('n', '<Esc>', ':noh<CR>')

vim.keymap.set('n', ']q', ':cnext<CR>')
vim.keymap.set('n', '[q', ':cprevious<CR>')

vim.keymap.set('n', '<leader>o', ':only<CR>')

local function insert_data()
  local row,_ = unpack(vim.api.nvim_win_get_cursor(0))

  local text  = {'---','title: ', 'description: ', 'date: '.. os.date('%Y-%m-%d'), 'tags: ', '---'} 

  vim.api.nvim_buf_set_lines(0, row -1, row, false, text)
end

vim.api.nvim_create_user_command('BlogData', insert_data, {})

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
