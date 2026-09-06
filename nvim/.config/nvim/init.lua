vim.g.mapleader = " "
vim.o.guicursor = "i:block"

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.splitbelow = true
vim.o.splitright = true

vim.pack.add({
  {src = 'https://github.com/mattn/emmet-vim'},
  {src = 'https://github.com/nvim-mini/mini.nvim' },
  {src = 'https://github.com/blazkowolf/gruber-darker.nvim'},
  {src = 'https://codeberg.org/andyg/leap.nvim'},
  {src = 'https://github.com/mhartington/oceanic-next'},
  {src = 'https://github.com/vague-theme/vague.nvim'},
})

require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.completion').setup()
require('mini.pick').setup()
require('mini.move').setup()
require('mini.fuzzy').setup()

-- shortcuts --
vim.keymap.set({ 'n', 'x', 'o' }, 's',  '<Plug>(leap)')
vim.keymap.set('n',               'S',  '<Plug>(leap-from-window)')

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>e", ":Explore<CR>")

vim.keymap.set("n", "<leader>gg", ":copen | :silent :grep ")
vim.keymap.set("n", "]q", ":cnext<CR>")
vim.keymap.set("n", "[q", ":cprevious<CR>")

vim.keymap.set("n", "<leader>f", function() MiniPick.builtin.files() end)


-- colorscheme --
vim.cmd('colorscheme vague')

vim.g.user_emmet_settings = {
  variables = { lang = 'en-US' },
  html = {
    default_attributes = {
      option = { value = vim.NIL },
      textarea = { id = vim.NIL, name = vim.NIL, cols = 10, rows = 10 },
    },
    snippets = {
      ['html:5'] = "<!DOCTYPE html>\n" .. "<html lang=\"${lang}\">\n" .. "<head>\n"
        .. "\t<meta charset=\"${charset}\">\n"
        .. "\t<title></title>\n"
        .. "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
        .. "</head>\n"
        .. "<body>\n\t${child}|\n</body>\n"
        .. "</html>",
    },
  },
}



