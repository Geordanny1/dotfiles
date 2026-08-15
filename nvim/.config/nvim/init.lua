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
  {src = 'https://github.com/mattn/emmet-vim'},
  {src = 'https://github.com/vague-theme/vague.nvim'},
  {src = 'https://github.com/nvim-mini/mini.nvim' }
})


require('vague').setup({
  transparent = true, -- If true, background is not set
  bold = true, -- Disable bold globally
  italic = true, -- Disable italic globally
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
    string = '#e8b589',
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

vim.cmd.colorscheme('vague')

require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.starter').setup()
require('mini.completion').setup()

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

