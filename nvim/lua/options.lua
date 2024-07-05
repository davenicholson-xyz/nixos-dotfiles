vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.showmode = false

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.o.background = "dark"

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>qq', ':qa!<CR>', { desc = 'Quit everything' })

vim.keymap.set('n', '[b', '<CMD>bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', ']b', '<CMD>bnext<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', 'H', '<CMD>bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', 'L', '<CMD>bnext<CR>', { desc = "Previous buffer" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
