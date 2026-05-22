-- ============================================================================
-- LEADER
-- ============================================================================

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- OPTIONS
-- ============================================================================

local opt = vim.opt

local options = {
  title = false,

  smarttab = true,
  hidden   = true,

  history = 1000,

  ignorecase = true,
  smartcase  = true,

  scrolloff     = 5,
  sidescrolloff = 5,

  gdefault = true,

  backspace = { "indent", "eol", "start" },

  autowrite = true,
  autoread  = true,

  linebreak = true,
  expandtab = true,

  splitbelow = true,
  splitright = true,

  autochdir = true,

  wrap = true,
  list = false,

  tabstop    = 4,
  shiftwidth = 4,

  shell = "/usr/bin/zsh",

  tabpagemax = 50,

  clipboard = "unnamedplus",

  backup   = true,
  swapfile = false,

  undofile   = true,
  undoreload = 10000,

  wildmenu       = true,
  wildmode       = { "longest", "list" },
  wildignorecase = true,

  laststatus = 2,

  hlsearch  = true,
  incsearch = true,
  showmatch = true,
  matchtime = 3,

  inccommand = "split",

  background    = "dark",
  termguicolors = false,

  omnifunc = "syntaxcomplete#Complete",

  number         = false,
  relativenumber = false,

  errorbells = false,
}

for k, v in pairs(options) do
  opt[k] = v
end

opt.whichwrap:append("<,>,h,l,[,]")
opt.display:append("lastline")

opt.formatoptions:append("j")
opt.formatoptions:remove("o")

opt.wildignore:append({
  "*.aux", "*.out", "*.toc", "*.pdf",
  "*.jpg", "*.bmp", "*.gif", "*.png", "*.jpeg",
})

opt.listchars = {
  tab      = "> ",
  trail    = "-",
  extends  = ">",
  precedes = "<",
  nbsp     = "+",
}

opt.runtimepath:append("/usr/bin/fzf")

opt.sessionoptions:remove("options")
opt.viewoptions:remove("options")

vim.cmd("colorscheme vim")

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

local undo_dir   = vim.fn.expand("~/.vim/.tmp/undo//")
local backup_dir = vim.fn.expand("~/.vim/.tmp/backup//")
local swap_dir   = vim.fn.expand("~/.vim/.tmp/swap//")

opt.undodir   = undo_dir
opt.backupdir = backup_dir
opt.directory = swap_dir

for _, dir in ipairs({ undo_dir, backup_dir, swap_dir }) do
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

local trailing = augroup("TrailingWhitespace", { clear = true })
local line_ret  = augroup("LineReturn",         { clear = true })

autocmd("BufReadPost", {
  group = line_ret,
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd([[normal! g`"zvzz]])
    end
  end,
})

autocmd("InsertEnter", {
  group   = trailing,
  command = "highlight link EndOfLineSpace Normal",
})

autocmd("InsertLeave", {
  group   = trailing,
  command = "highlight link EndOfLineSpace ErrorMsg",
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

-- visual-line movement
map("n", "j", "gj")
map("n", "k", "gk")

map("n", "m", ":w<CR>:!make<CR>", opts)
map("n", "Q", ":w<CR>", opts)
map("n", "Y", "y$")

map("n", "<leader><space>", ":noh<CR>", opts)

map("i", "<C-u>", "<Esc>vawUea")

map("n", "<C-e>", "3<C-e>")
map("n", "<C-y>", "3<C-y>")

map("n", "<leader>n", ":set invnumber<CR>", opts)
map("n", "<leader>r", [[:%s/\v\s+$//<CR>``:noh<CR>]], opts)

-- splits
map("n", "_", "<C-w>s")
map("n", "|", "<C-w>v")

-- window navigation
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("i", "<C-j>", "<Esc><C-j>")
map("i", "<C-k>", "<Esc><C-k>")
map("i", "<C-h>", "<Esc><C-h>")
map("i", "<C-l>", "<Esc><C-l>")

-- paste with auto-indent; C- variants bypass it
map("n", "p",     "p=`]")
map("n", "P",     "P=`]")
map("n", "<C-p>", "p")
map("n", "<C-P>", "P")

-- window resize
map("n", "<Up>",    ":resize +5<CR>",          opts)
map("n", "<Down>",  ":resize -5<CR>",          opts)
map("n", "<Left>",  ":vertical resize +5<CR>", opts)
map("n", "<Right>", ":vertical resize -5<CR>", opts)

-- column width
map("n", "<leader>+", ":set columns=160<CR>:vsplit<CR>", opts)
map("n", "<leader>-", ":set columns=80<CR>", opts)

-- tabs
map("n", "<leader>t", ":tabnew<CR>",      opts)
map("n", "<Tab>",     ":tabnext<CR>",     opts)
map("n", "<S-Tab>",   ":tabprevious<CR>", opts)

-- buffers
map("n", "<leader>b", ":Buffers<CR>", opts)
map("n", "-",         ":bp<CR>",      opts)
map("n", "+",         ":bn<CR>",      opts)

-- fzf
map("n", "<leader>f", ":Files<CR>", opts)
vim.cmd([[imap <c-x><c-f> <plug>(fzf-complete-path)]])

-- terminal
map("t", "<C-s>", [[<C-\><C-n><C-w>N]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- file-based clipboard (works across tmux panes)
map("v", "<leader>y", [["cy:call writefile(getreg('c',1,1),'/home/foo/.clipboard.txt')<CR>]])
map("n", "<leader>p", [[:let @c = system('cat /home/foo/.clipboard.txt')<CR>"cp]])

-- time logger
map("n", "<leader>l",
  [[:!$HOME/Documents/time_logger/get_tags.py | fzf | $HOME/Documents/time_logger/log_time.py<CR>]],
  opts)

-- syntax
map("n", "<leader>x", ":syntax sync fromstart<CR>", opts)
map("n", "<F10>", function()
  local r, c = vim.fn.line("."), vim.fn.col(".")
  local syn = vim.fn.synIDattr(vim.fn.synID(r, c, 1), "name")
  local tr  = vim.fn.synIDattr(vim.fn.synID(r, c, 0), "name")
  local lo  = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(r, c, 1)), "name")
  print("hi<" .. syn .. "> trans<" .. tr .. "> lo<" .. lo .. ">")
end)

-- headline underline / surround
for _, ch in ipairs({ "=", "-", "#", "*" }) do
  map("n", "<leader>h" .. ch, "yypVr" .. ch)
  map("n", "<leader>H" .. ch, "yyPVr" .. ch .. "yyjp")
end

-- tabularize
map("n", "<leader>a=", ":Tabularize /=/<CR>")
map("v", "<leader>a=", ":Tabularize /=/<CR>")
map("n", "<leader>A=", [[:Tabularize /\S*=\S*/<CR>:Tabularize /=\S*/l0l1l0<CR>]])
map("v", "<leader>A=", [[:Tabularize /\S*=\S*/<CR>gv:Tabularize /=\S*/l0l1l0<CR>]])

-- ============================================================================
-- STATUSLINE
-- ============================================================================

opt.statusline = "%{expand('%:p')}"

-- ============================================================================
-- TAB COMPLETE
-- ============================================================================

vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-p>" end
  local col  = vim.fn.col(".") - 1
  local line = vim.fn.getline(".")
  if col == 0 or line:sub(1, col):match("^%s*$") then return "<Tab>" end
  return "<C-p>"
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("i", "<S-Tab>", function()
  return "<C-n>"
end, { expr = true, noremap = true, silent = true })

-- ============================================================================
-- FUGITIVE
-- ============================================================================

map("n", "<leader>gg", function() vim.cmd.Git() end,         { desc = "Git status" })
map("n", "<leader>gc", function() vim.cmd("Git commit") end, { desc = "Git commit" })
map("n", "<leader>gp", function() vim.cmd("Git push") end,   { desc = "Git push"   })

-- ============================================================================
-- TMUX TARGETS
-- ============================================================================

vim.g.tmux_target = "right"

-- ============================================================================
-- BOOKMARKS
-- ============================================================================

local bookmarks_file = vim.fn.expand("$HOME/dotfiles/bookmarks.vim")

map("n", "<leader>0", ":tabnew " .. bookmarks_file .. "<CR>",    opts)
map("n", "<leader>1", ":tabnew $HOME/dotfiles/init.lua<CR>",     opts)
map("n", "<leader>2", ":tabnew $HOME/dotfiles/local.lua<CR>",    opts)
map("n", "<leader>3", ":tabnew $HOME/dotfiles/packages.lua<CR>", opts)
map("n", "<leader>4", ":tabnew $HOME/dotfiles/tmux.conf<CR>",    opts)
map("n", "<leader>5", ":tabnew $HOME/dotfiles/zshrc<CR>",        opts)

-- open bookmarks.vim, append an entry for the current file, position cursor
-- at the slot number so it can be overtyped
map("n", "M", function()
  local filepath = vim.fn.expand("%:p")
  vim.cmd("tabnew " .. bookmarks_file)
  local last = vim.fn.line("$")
  vim.api.nvim_buf_set_lines(0, last, last, false,
    { "", "nnoremap <leader>9 :e " .. filepath .. "<CR>" })
  vim.fn.cursor(last + 2, 1)
  vim.cmd("normal! 0EEs")
end)

-- ============================================================================
-- FILETYPE DETECTION
-- ============================================================================

vim.filetype.add({
  extension = {
    sage  = "python.sage",
    spyx  = "python.sage",
    twiki = "markdown.twiki",
    org   = "org",
    txt   = "txt",
    csv   = "csv",
    jl    = "julia",
  },
  pattern = {
    ["time_log.*%.yaml"] = "yaml.timelog",
  },
})

-- ============================================================================
-- ABBREVIATIONS
-- ============================================================================

vim.cmd([[iabbrev reutrn return]])

-- ============================================================================
-- MACHINE-SPECIFIC SETTINGS
-- ============================================================================

pcall(require, "machine")
