package.path = package.path .. ";" .. vim.fn.expand("$HOME/dotfiles/") .. "?.lua"

require("telescope_bindings")
require("tmux")
require("tmux_fix")
require("packages")
