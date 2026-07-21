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

  laststatus = 3,

  hlsearch  = true,
  incsearch = true,
  showmatch = true,
  matchtime = 3,

  inccommand = "split",

  background    = "dark",
  termguicolors = false,

  number         = false,
  relativenumber = false,

  errorbells = false,

  mouse = "",
}

for k, v in pairs(options) do
  opt[k] = v
end

opt.whichwrap:append("<,>,h,l,[,]")
opt.display:append("lastline")

opt.formatoptions:append("j")
opt.formatoptions:remove("o")

-- align changed lines within diff hunks up to 60 lines (default caps at 40)
opt.diffopt:remove("linematch:40")
opt.diffopt:append("linematch:60")

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

local state_dir  = vim.fn.stdpath("state")
local undo_dir   = state_dir .. "/undo"
local backup_dir = state_dir .. "/backup"
local swap_dir   = state_dir .. "/swap"

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

vim.api.nvim_set_hl(0, "EndOfLineSpace", { link = "ErrorMsg", default = true })
vim.cmd([[match EndOfLineSpace /\s\+$/]])

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
  group    = trailing,
  callback = function() vim.api.nvim_set_hl(0, "EndOfLineSpace", { link = "Normal" }) end,
})

autocmd("InsertLeave", {
  group    = trailing,
  callback = function() vim.api.nvim_set_hl(0, "EndOfLineSpace", { link = "ErrorMsg" }) end,
})

-- ============================================================================
-- TEMPLATES
-- ============================================================================

local tmpl_dir  = vim.fn.expand("$HOME/dotfiles/templates/")
local tmpl_group = augroup("Templates", { clear = true })

local function template(pattern, file)
  autocmd("BufNewFile", {
    group   = tmpl_group,
    pattern = pattern,
    callback = function()
      local path = tmpl_dir .. file
      if vim.fn.filereadable(path) == 1 then
        vim.cmd("0r " .. vim.fn.fnameescape(path))
      end
    end,
  })
end

template("*.py",          "python.py")
template("*.sage",        "sage.sage")
template("*.spyx",        "sage.sage")
template("*.c",           "c.c")
template({ "*.cpp", "*.cc" }, "cpp.cpp")
template("*.jl",          "julia.jl")
template("*.tex",         "latex.tex")
template("*.rs",          "rust.rs")
template("*.go",          "go.go")
template("*.pl",          "perl.pl")

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

-- window navigation; falls through to the tmux pane that way when there is no
-- split left to move to. Terminal mode leaves the terminal first.
for _, key in ipairs({ "h", "j", "k", "l" }) do
  local nav = ([[<Cmd>lua require("tmux_nav").nav("%s")<CR>]]):format(key)
  map("n", "<C-" .. key .. ">", nav, opts)
  map("i", "<C-" .. key .. ">", "<Esc>" .. nav, opts)
  map("t", "<C-" .. key .. ">", [[<C-\><C-n>]] .. nav, opts)
end
map("n", [[<C-\>]], [[<Cmd>lua require("tmux_nav").prev()<CR>]], opts)

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

map("n", "-",         ":bp<CR>",      opts)
map("n", "+",         ":bn<CR>",      opts)

-- terminal (C-hjkl are mapped with the other window navigation, above)
map("t", "<C-s>", [[<C-\><C-n><C-w>N]])

-- send to the REPL in the tmux pane; required lazily because machine.lua is
-- what puts ~/dotfiles on package.path, and it loads at the end of this file
map("v", "<leader>s", [[:<C-u>lua require("tmux").send_selection()<CR>]], opts)
map("n", "<leader>s", [[<Cmd>lua require("tmux").send_region()<CR>]], opts)
map("n", "<leader>e", [[<Cmd>lua require("tmux").errors()<CR>]], opts)

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
-- TMUX
-- ============================================================================

-- Where require("tmux") looks for the REPL, before it caches a pane id.
vim.g.tmux_target = "right"

vim.api.nvim_create_user_command("TmuxTarget", function(args)
  require("tmux").retarget(args.args)
end, { nargs = "?", desc = "Re-resolve the REPL pane, optionally from a new target" })

-- Publish this instance to tmux, so the panes around it can find it:
--   @is_vim       "this pane is running vim" (tmux.conf, tmux_nav.lua)
--   @nvim_server  this instance's server socket, so a sibling pane can open
--                 files in here (the `v` function and $EDITOR wrapper in zshrc)
--
-- Both are cleared on suspend as well as exit: a suspended nvim's pane is a
-- shell, and its server will not answer.
--
-- Both are pane-scoped, and every call targets $TMUX_PANE explicitly.
--
-- Pane-scoped because a window can hold more than one nvim -- a $EDITOR
-- fallback opening in the shell pane, say. On a window-scoped option the
-- newcomer overwrites the socket, and then unsets it outright when it exits,
-- orphaning the nvim that is still running next door. Per-pane, each instance
-- owns exactly its own entry.
--
-- Explicitly targeted because without -t, tmux applies the option to the
-- session's *current* window rather than to the caller's, so an nvim started
-- in a background window would mark the wrong pane entirely.
local tmux_grp = augroup("TmuxIntegration", { clear = true })

local function publish(set)
  if not vim.env.TMUX then return end
  local pane = vim.env.TMUX_PANE

  if set then
    vim.fn.system({ "tmux", "set-option", "-p", "-t", pane, "@is_vim", "yes" })
    vim.fn.system({ "tmux", "set-option", "-p", "-t", pane,
                    "@nvim_server", vim.v.servername })
  else
    vim.fn.system({ "tmux", "set-option", "-p", "-t", pane, "-u", "@is_vim" })
    vim.fn.system({ "tmux", "set-option", "-p", "-t", pane, "-u", "@nvim_server" })
  end
end

autocmd({ "VimEnter", "VimResume" }, {
  group    = tmux_grp,
  callback = function() publish(true) end,
})

autocmd({ "VimLeave", "VimSuspend" }, {
  group    = tmux_grp,
  callback = function() publish(false) end,
})

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

-- Absent on machines without a machine.lua, so failure to load is not an
-- error; report anything else rather than dropping it.
local ok, err = pcall(require, "machine")
if not ok and not tostring(err):match("module 'machine' not found") then
  vim.notify("machine.lua: " .. tostring(err), vim.log.levels.WARN)
end
