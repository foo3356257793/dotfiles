-- Machine-local loader. Symlink to ~/.config/nvim/lua/machine.lua, which
-- init.lua requires last; keep it in step with example.machine.lua.
package.path = package.path .. ";" .. vim.fn.expand("$HOME/dotfiles/") .. "?.lua"

-- tmux.lua and tmux_nav.lua are pure modules, required lazily by the keymaps
-- and commands in init.lua.
require("telescope_bindings")
require("tmux_fix")
require("packages")
require("lsp")
