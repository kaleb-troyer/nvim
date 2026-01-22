-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here


-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = false

-- Colors
vim.opt.termguicolors = true

-- Folds
vim.o.foldclose = ""

-- Tabs / spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Mouse
vim.o.mouse = "a"

-- UI
vim.o.showmode = false
vim.opt.fillchars:append({ eob = " " })
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.scrolloff = 6
vim.o.confirm = true

-- Wrapping / indent
vim.o.breakindent = true
vim.opt.wrap = false

-- Undo
vim.o.undofile = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 1000

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true

-- Whitespace display
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Live substitution preview
vim.o.inccommand = "split"

-- Clipboard (deferred for startup safety)
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- LSP options
vim.g.autoformat = false
