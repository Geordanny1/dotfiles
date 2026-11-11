vim.g.mapleader = ' '
vim.o.guicursor = 'i:block'
vim.o.termguicolors  = true
vim.o.number         = true 
vim.o.relativenumber = true 
vim.o.expandtab      = true

vim.o.shiftwidth = 2
vim.o.tabstop    = 2

vim.pack.add({
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/godlygeek/tabular' },
  { src = 'https://github.com/mg979/vim-visual-multi' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/mattn/emmet-vim' },
  { src = 'https://github.com/neovimhaskell/haskell-vim' },
  { src = 'https://github.com/lervag/wiki.vim' },
})

vim.cmd.colorscheme('vim')

-- mini.nvim modules
require('mini.pairs').setup()
require('mini.cmdline').setup()
require('mini.move').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.move').setup()

-- Treesitter
require('nvim-treesitter').install { 'markdown', 'latex', 'python', 'haskell', 'bash', 'cpp', 'c' }

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start treesitter highlighting',
  pattern = { 'markdown', 'python', 'haskell', 'cpp', 'c', 'sh', 'bash' },
  callback = function() pcall(vim.treesitter.start) end,
})

-- Keymaps
vim.keymap.set({ 'n', 'v', 'i' }, '<C-x><C-f>',
  function() require('fzf-lua').complete_path() end,
  { silent = true, desc = 'Fuzzy complete path' })

vim.keymap.set('n', '<leader>fg', function() require('fzf-lua').live_grep() end,
  { desc = 'Live grep' })

vim.keymap.set('n', '<leader>fb', function() require('fzf-lua').buffers() end,
  { desc = 'Buffers' })

vim.keymap.set('n', '<leader>fh', function() require('fzf-lua').helptags() end,
  { desc = 'Help tags' })

vim.keymap.set('n', '<leader>ff', function() require('fzf-lua').files() end,
  { desc = 'Find files' })

vim.keymap.set('n', '<leader>ec', function()
  require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Edit config files' })

vim.keymap.set('n', '<leader>l', ':vert belowright sb ', { desc = 'Open buffer in vertical split' })

vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { desc = 'Clear search highlight' })

vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = 'Write file' })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})


vim.api.nvim_create_user_command('ChangeColor', function()
  require('fzf-lua').colorschemes()
end, {})


-- Nunjucks templates use the htmldjango filetype
vim.filetype.add({ extension = { njk = 'htmldjango' } })

-- wiki.vim
vim.g.wiki_root = '~/notes'

-- emmet-vim
vim.cmd [[
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

vim.api.nvim_create_autocmd({ "TermEnter", "BufEnter", "WinEnter" }, {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd[[set nospell]]
    end
  end,
})



-- vim.api.nvim_create_user_command('ChangeColor', function()
--   vim.cmd[[lua require('fzf-lua').colorschemes()]]
-- end, {})

-- Blog front-matter helper (disabled)
-- vim.api.nvim_create_user_command('InsertBlogData', function()
--   local row = vim.api.nvim_win_get_cursor(0)[1]
--   local template = {
--     '---',
--     "title: 'Blog Post number 1'",
--     'date: 2012-08-14',
--     'permalink: /posts/foo',
--     'tags:',
--     ' - foo',
--     ' - bar',
--     ' - waz',
--     '---',
--   }
--   vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, template)
-- end, {})
