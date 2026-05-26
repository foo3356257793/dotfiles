package.path = package.path .. ";" .. vim.fn.expand("$HOME/dotfiles/") .. "?.lua"

require("tmux")
require("tmux_fix")
require("packages")
require("workhours")
