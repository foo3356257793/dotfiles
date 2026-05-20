-- ============================================================================
-- LEADER
-- ============================================================================

vim.g.mapleader = " "

-- ============================================================================
-- CORE OPTIONS
-- ============================================================================

local opt = vim.opt

local options = {
  title = false,

  smarttab = true,
  hidden = true,

  history = 1000,

  ignorecase = true,
  smartcase = true,

  scrolloff = 5,
  sidescrolloff = 5,

  gdefault = true,

  backspace = { "indent", "eol", "start" },

  autowrite = true,
  autoread = true,

  linebreak = true,

  expandtab = true,

  splitbelow = true,
  splitright = true,

  autochdir = true,

  wrap = true,
  list = false,

  lazyredraw = true,

  tabstop = 4,
  shiftwidth = 4,

  encoding = "utf-8",

  shell = "/usr/bin/zsh",

  tabpagemax = 50,

  clipboard = "unnamedplus",

  backup = true,
  swapfile = false,

  undofile = true,
  undoreload = 10000,

  wildmenu = true,
  wildmode = { "longest", "list" },
  wildignorecase = true,

  laststatus = 2,

  hlsearch = true,
  incsearch = true,
  showmatch = true,
  matchtime = 3,

  inccommand = "split",

  background = "dark",
  termguicolors = true,

  omnifunc = "syntaxcomplete#Complete",

  number = false,
  relativenumber = false,
}

for k, v in pairs(options) do
  opt[k] = v
end

opt.whichwrap:append("<,>,h,l,[,]")
opt.display:append("lastline")

opt.wildignore:append({
  "*.aux",
  "*.out",
  "*.toc",
  "*.pdf",
  "*.jpg",
  "*.bmp",
  "*.gif",
  "*.png",
  "*.jpeg",
})

opt.listchars = {
  tab = "> ",
  trail = "-",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}

opt.runtimepath:append("/usr/bin/fzf")

local undo_dir = vim.fn.expand("~/.vim/.tmp/undo//")
local backup_dir = vim.fn.expand("~/.vim/.tmp/backup//")
local swap_dir = vim.fn.expand("~/.vim/.tmp/swap//")

opt.undodir = undo_dir
opt.backupdir = backup_dir
opt.directory = swap_dir

local backup_dirs = {
  undo_dir,
  backup_dir,
  swap_dir,
}

opt.sessionoptions:remove("options")
opt.viewoptions:remove("options")

-- ============================================================================
-- FILETYPE + SYNTAX
-- ============================================================================

vim.cmd([[
  filetype plugin on
  filetype indent on
  syntax enable
]])

-- ============================================================================
-- BACKUP DIRECTORIES
-- ============================================================================

for _, dir in ipairs(backup_dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

-- ============================================================================
-- HIGHLIGHTS
-- ============================================================================

vim.cmd([[
  highlight default link EndOfLineSpace ErrorMsg
  match EndOfLineSpace /\s\+$/
]])

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position
local line_return = augroup("LineReturn", { clear = true })

autocmd("BufReadPost", {
  group = line_return,
  callback = function()
    local line = vim.fn.line([['"]])

    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd([[normal! g`"zvzz]])
    end
  end,
})

-- Trailing whitespace highlight behavior
local trailing = augroup("TrailingWhitespace", { clear = true })

autocmd("InsertEnter", {
  group = trailing,
  command = "highlight link EndOfLineSpace Normal",
})

autocmd("InsertLeave", {
  group = trailing,
  command = "highlight link EndOfLineSpace ErrorMsg",
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

local map = vim.keymap.set

local opts = { noremap = true, silent = true }

-- Visual line movement
map("n", "j", "gj")
map("n", "k", "gk")

-- Save + make
map("n", "m", ":w<CR>:!make<CR>", opts)

-- Clear search highlight
map("n", "<leader><space>", ":noh<CR>", opts)

-- Caps word
map("i", "<C-u>", "<Esc>vawUea")

-- Faster scrolling
map("n", "<C-e>", "3<C-e>")
map("n", "<C-y>", "3<C-y>")

-- Toggle numbers
map("n", "<leader>n", ":set invnumber<CR>", opts)

-- Splits
map("n", "_", "<C-w>s")
map("n", "|", "<C-w>v")

-- Remove trailing whitespace
map("n", "<leader>r", [[:%s/\v\s+$//<CR>``:noh<CR>]], opts)

-- Window navigation
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

map("i", "<C-j>", "<Esc><C-j>")
map("i", "<C-k>", "<Esc><C-k>")
map("i", "<C-h>", "<Esc><C-h>")
map("i", "<C-l>", "<Esc><C-l>")

-- Paste positioning
map("n", "p", "p=`]")
map("n", "P", "P=`]")
map("n", "<C-p>", "p")
map("n", "<C-P>", "P")

-- Save file
map("n", "Q", ":w<CR>", opts)

-- Resize windows
map("n", "<Up>", ":resize +5<CR>", opts)
map("n", "<Down>", ":resize -5<CR>", opts)
map("n", "<Left>", ":vertical resize +5<CR>", opts)
map("n", "<Right>", ":vertical resize -5<CR>", opts)

-- Tabs
map("n", "<leader>t", ":tabnew<CR>", opts)
map("n", "<Tab>", ":tabnext<CR>", opts)
map("n", "<S-Tab>", ":tabprevious<CR>", opts)

-- Sensible Y
map("n", "Y", "y$")

-- FZF
map("n", "<leader>f", ":Files<CR>", opts)

-- Buffers
map("n", "<leader>b", ":Buffers<CR>", opts)
map("n", "-", ":bp<CR>", opts)
map("n", "+", ":bn<CR>", opts)

-- Terminal mappings
map("t", "<C-s>", [[<C-\><C-n><C-w>N]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- ============================================================================
-- FILETYPE SETTINGS
-- ============================================================================

local ft_group = augroup("FiletypeSettings", { clear = true })

-- Python
autocmd("FileType", {
  group = ft_group,
  pattern = "python",
  callback = function()
    local bo = vim.bo
    local wo = vim.wo

    bo.softtabstop = 4
    bo.shiftwidth = 4
    bo.expandtab = true

    bo.autoindent = true
    bo.smartindent = true

    bo.textwidth = 80

    wo.foldmethod = "indent"
    wo.foldlevel = 99

    map("n", "m", function()
      vim.cmd.write()
      vim.cmd("!python %")
    end, {
      buffer = true,
      silent = true,
      desc = "Run python file",
    })
  end,
})

-- Sage
vim.filetype.add({
  extension = {
    sage = "python.sage",
  },
})

-- Lua
autocmd("FileType", {
  group = ft_group,
  pattern = "lua",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- Markdown
autocmd("FileType", {
  group = ft_group,
  pattern = "markdown",
  callback = function()
    local bo = vim.bo
    local wo = vim.wo

    bo.softtabstop = 2
    bo.shiftwidth = 2
    bo.textwidth = 0

    wo.foldlevel = 99

    map("n", "go", "o* ", { buffer = true })
    map("n", "gO", "O* ", { buffer = true })
  end,
})

-- TeX
autocmd("FileType", {
  group = ft_group,
  pattern = "tex",
  callback = function()
    local bo = vim.bo

    bo.textwidth = 68
    bo.tabstop = 2
    bo.shiftwidth = 2
    bo.softtabstop = 2

    bo.autoindent = true
    bo.smartindent = true
  end,
})

-- C / C++
autocmd("FileType", {
  group = ft_group,
  pattern = { "c", "cpp" },
  callback = function()
    local bo = vim.bo

    bo.softtabstop = 2
    bo.shiftwidth = 2
    bo.expandtab = true

    bo.autoindent = true
    bo.smartindent = true

    bo.textwidth = 80

    vim.opt_local.cinkeys:remove("0#")
  end,
})

-- Rust
autocmd("FileType", {
  group = ft_group,
  pattern = "rust",
  callback = function()
    local bo = vim.bo

    bo.softtabstop = 4
    bo.shiftwidth = 4
    bo.expandtab = true

    bo.autoindent = true
    bo.smartindent = true

    bo.textwidth = 80
  end,
})

-- Vimscript
autocmd("FileType", {
  group = ft_group,
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2

    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- ============================================================================
-- ABBREVIATIONS
-- ============================================================================

vim.cmd([[
  iabbrev reutrn return
]])

-- ============================================================================
-- STATUSLINE
-- ============================================================================

opt.statusline = "%{expand('%:p')}"


-- ============================================================================
-- TAB COMPLETE
-- ============================================================================
-- Map Tab to behave like Ctrl+P in Insert Mode, unless at the start of a line
vim.keymap.set('i', '<Tab>', function()
  -- If the completion menu is visible, go to the previous item
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  end

  -- Get current line and cursor column position
  local col = vim.fn.col('.') - 1
  local line = vim.fn.getline('.')

  -- Check if cursor is at the start or only preceded by whitespace
  if col == 0 or line:sub(1, col):match('^%s*$') then
    return '<Tab>'
  end

  -- If menu isn't open and we are in text, trigger keyword completion (backwards)
  return '<C-p>'
end, { expr = true, noremap = true, silent = true })

-- Map Shift+Tab to behave like Ctrl+N to cycle forwards
vim.keymap.set('i', '<S-Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  else
    return '<C-n>'
  end
end, { expr = true, noremap = true, silent = true })

-- ============================================================================
-- Fugitive
-- ============================================================================
map("n", "<leader>gg", function()
  vim.cmd.Git()
end, { desc = "Git status" })

map("n", "<leader>gc", function()
  vim.cmd("Git commit")
end, { desc = "Git commit" })

map("n", "<leader>gp", function()
  vim.cmd("Git push")
end, { desc = "Git push" })
