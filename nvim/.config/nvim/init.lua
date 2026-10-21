
vim.g.mapleader = ' '
vim.o.guicursor = 'i:block'

vim.o.termguicolors  = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.expandtab      = true

vim.o.shiftwidth = 2
vim.o.tabstop    = 2

vim.pack.add({

	{src = 'https://github.com/morhetz/gruvbox'},
  {src = 'https://github.com/ibhagwan/fzf-lua'},

	{src = 'https://github.com/godlygeek/tabular'},
	{src = 'https://github.com/folke/flash.nvim'},

	{src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
	{src = 'https://github.com/mattn/emmet-vim'},
	{src = 'https://github.com/neovimhaskell/haskell-vim'},

	{src = 'https://github.com/lervag/wiki.vim'},

})

vim.cmd.colorscheme('gruvbox')

require('nvim-treesitter').install { 'markdown', 'latex', 'python', 'haskell' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'md', 'python', 'py', 'haskell', 'hs' },
  callback = function() vim.treesitter.start() end,
})

vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
  function() FzfLua.complete_path() end,
  { silent = true, desc = "Fuzzy complete path" })

vim.keymap.set('n', '<leader>fg', function() 
  require('fzf-lua').live_grep()
end,  { desc = 'live grep' })

vim.keymap.set('n', '<leader>fb', function()
  require('fzf-lua').buffers()
end,    { desc = 'Telescope buffers' })

vim.keymap.set('n', '<leader>fh', function()
  require('fzf-lua').helptags()
end,  { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>ff', function()
  require('fzf-lua').files()
end)

vim.keymap.set('n', '<leader>l', ':vert belowright sb ' )

vim.keymap.set({'n', 'x', 'o'}, 's', function()
  require('flash').jump()
end)

vim.keymap.set('n', '<Esc>', function()
  vim.cmd.noh()
end)

vim.keymap.set('n', '<leader>w', function()
  vim.cmd.write()
end)

vim.keymap.set('n', '<leader>ec', function()

  local config_path = vim.fn.stdpath("config")
  require('fzf-lua').files({cwd = config_path})

end)

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
  callback = function() vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {

  pattern = {'*.njk' },

  callback = function()
    vim.o.filetype = 'htmldjango'

  end

})

vim.g.wiki_root = '~/notes'

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
\
\    },
\  },
\}
]]
vim.api.nvim_create_user_command('InserBlogData', function()
  local current_row = vim.api.nvim_win_get_cursor(0)[1]

  local template = {
    "---",
    "title: 'Blog Post number 1' ",
    "date: 2012-08-14",
    "permalink: /posts/foo",
    "tags:",
    " -foo",
    " -bar",
    " -waz",
    "---"
  }

  vim.api.nvim_buf_set_lines(0, current_row-1, current_row-1, false, template)

end)

vim.g.mapleader = ' '
vim.o.guicursor = 'i:block'

vim.o.termguicolors  = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.expandtab      = true

vim.o.shiftwidth = 2
vim.o.tabstop    = 2

vim.pack.add({

	{src = 'https://github.com/morhetz/gruvbox'},
  {src = 'https://github.com/ibhagwan/fzf-lua'},

	{src = 'https://github.com/godlygeek/tabular'},
	{src = 'https://github.com/mg979/vim-visual-multi'},
	{src = 'https://github.com/folke/flash.nvim'},

	{src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
	{src = 'https://github.com/mattn/emmet-vim'},
	{src = 'https://github.com/neovimhaskell/haskell-vim'},

	{src = 'https://github.com/lervag/wiki.vim'},

})

vim.cmd.colorscheme('gruvbox')

require('nvim-treesitter').install { 'markdown', 'latex', 'python', 'haskell' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'md', 'python', 'py', 'haskell', 'hs' },
  callback = function() vim.treesitter.start() end,
})

vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>",
  function() FzfLua.complete_path() end,
  { silent = true, desc = "Fuzzy complete path" })

vim.keymap.set('n', '<leader>fg', function() 
  require('fzf-lua').live_grep()
end,  { desc = 'live grep' })

vim.keymap.set('n', '<leader>fb', function()
  require('fzf-lua').buffers()
end,    { desc = 'Telescope buffers' })

vim.keymap.set('n', '<leader>fh', function()
  require('fzf-lua').helptags()
end,  { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>ff', function()
  require('fzf-lua').files()
end)

vim.keymap.set('n', '<leader>l', ':vert belowright sb ' )

vim.keymap.set({'n', 'x', 'o'}, 's', function()
  require('flash').jump()
end)

vim.keymap.set('n', '<Esc>', function()
  vim.cmd.noh()
end)

vim.keymap.set('n', '<leader>w', function()
  vim.cmd.write()
end)


vim.keymap.set('n', '<leader>w', function()
  vim.cmd.write()
end)

-- vim.keymap.set('n', '<leader>e', ":exe 'edit' stdpath('config') .. '/init.lua'<CR>" )

vim.keymap.set('n', '<leader>ec', function()

  local config_path = vim.fn.stdpath("config")
  require('fzf-lua').files({cwd = config_path})

end)

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
  callback = function() vim.hl.hl_op()
  end,
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {

  pattern = {'*.njk' },

  callback = function()
    vim.o.filetype = 'htmldjango'

  end

})

vim.g.wiki_root = '~/notes'

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
\
\    },
\  },
\}
]]

vim.api.nvim_create_user_command('InsertBlogData', function()

  local current_row = vim.api.nvim_win_get_cursor(0)[1]

  local current_date  = os.date("%Y-%m-%d")
  local current_year  = os.date("%Y")
  local current_month = os.date("%m")

  local filename = vim.fn.expand('%:t')

  local template = {
    "---",
    "title: " .. filename,
    "date: ".. current_date ,
    "permalink: /posts/" .. current_year .. "/" .. current_month,
    "tags:",
    " - tag",
    " - tag",
    " - tag",
    "---"
  }

  vim.api.nvim_buf_set_lines(0, current_row-1, current_row-1, false, template )

end, {})
