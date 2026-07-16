vim.g.mapleader = " "
vim.o.guicursor = "i:block"

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.keymap.set("n","<leader>w",":w<CR>")
vim.keymap.set("n","<leader>e",":Explore<CR>")


vim.pack.add({
  {src = "https://github.com/mattn/emmet-vim"},
  {src = "https://github.com/bluz71/vim-moonfly-colors"},
  {src = 'https://github.com/nvim-mini/mini.nvim' }
})

-- Lua initialization file
vim.g.moonflyTransparent = true

-- Lua initialization file
vim.cmd [[colorscheme moonfly]]

-- Lua initialization file

require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.starter').setup()

vim.g.user_emmet_settings = {
  variables = { lang = 'en-US' },
  html = {
    default_attributes = {
      option = { value = vim.NIL },
      textarea = { id = vim.NIL, name = vim.NIL, cols = 10, rows = 10 },
    },
    snippets = {
      ['html:5'] = "<!DOCTYPE html>\n"
        .. "<html lang=\"${lang}\">\n"
        .. "<head>\n"
        .. "\t<meta charset=\"${charset}\">\n"
        .. "\t<title></title>\n"
        .. "\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
        .. "</head>\n"
        .. "<body>\n\t${child}|\n</body>\n"
        .. "</html>",
    },
  },
}

