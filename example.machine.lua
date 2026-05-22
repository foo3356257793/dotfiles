package.path = package.path .. ";" .. vim.fn.expand("$HOME/dotfiles/") .. "?.lua"

require("tmux_fix")
require("packages")
