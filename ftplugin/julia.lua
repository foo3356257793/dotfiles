local map = vim.keymap.set

local tmux = require("tmux")
local b = { buffer = true, silent = true }
map("n", "m", function()
  vim.cmd.write()
  -- absolute: the REPL pane's cwd is independent of this instance's
  tmux.send('include("' .. vim.fn.expand("%:p") .. '")')
end, b)
map("n", "<localleader>lt",
  [[ofunction TEST_XXX()<CR>@testset "TEST XXX" begin<CR>end<CR>end<Esc>{=apvap:s/XXX/]],
  { buffer = true })
map("n", "<localleader>lf", "ofunction<CR>end<Esc>kA ", { buffer = true })
