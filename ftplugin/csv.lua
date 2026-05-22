local map = vim.keymap.set

vim.bo.autoindent = false
-- restore plain paste (bypasses the global p=`] autoformat map)
map("n", "p", "p", { buffer = true, noremap = true })
map("n", "P", "P", { buffer = true, noremap = true })
