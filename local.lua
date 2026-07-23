-- Machine-local loader. Symlink to ~/.config/nvim/lua/machine.lua, which
-- init.lua requires last; keep it in step with example.machine.lua.
package.path = package.path .. ";" .. vim.fn.expand("$HOME/dotfiles/") .. "?.lua"

-- tmux.lua and tmux_nav.lua are pure modules, required lazily by the keymaps
-- and commands in init.lua.
--
-- packages first: it runs vim.pack.add, which puts the plugins on the
-- runtimepath. telescope_bindings requires telescope at its top level, so it
-- has to come after that or the module is not found on a cold start.
require("tmux_fix")
require("packages")
require("telescope_bindings")
require("lsp")
