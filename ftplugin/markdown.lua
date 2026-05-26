local map = vim.keymap.set

local bo = vim.bo
bo.softtabstop = 2
bo.shiftwidth  = 2
bo.textwidth   = 0
vim.wo.foldlevel = 99

local hl = vim.api.nvim_set_hl
hl(0, 'MarkdownH1', { bold = true, ctermbg = 2, ctermfg = 0 })
hl(0, 'MarkdownH2', { bold = true, ctermbg = 11, ctermfg = 0 })
hl(0, 'MarkdownH3', { bold = true, ctermbg = 1, ctermfg = 7 })
hl(0, 'MarkdownH4', { bold = true, ctermbg = 4, ctermfg = 0 })
hl(0, 'MarkdownH5', { bold = true, ctermbg = 11, ctermfg = 'none' })
hl(0, 'MarkdownH6', { bold = true, ctermbg = 1, ctermfg = 'none' })

hl(0, "@markup.heading.1.markdown", { bold = true, bg = 2, fg = 0 })
hl(0, "@markup.heading.2.markdown", { bold = true, bg = 11, fg = 0 })
hl(0, "@markup.heading.3.markdown", { bold = true, bg = 1, fg = 7 })
hl(0, "@markup.heading.4.markdown", { bold = true, bg = 4, fg = 0 })
hl(0, "@markup.heading.5.markdown", { bold = true, bg = 11, fg = 'none' })
hl(0, "@markup.heading.6.markdown", { bold = true, bg = 1, fg = 'none' })

-- Clear old matches to protect editor performance
for _, match in ipairs(vim.fn.getmatches()) do
    if match.group:find("^MarkdownH") then
        vim.fn.matchdelete(match.id)
    end
end

-- Explicitly assign priority 100 so it overrides TreeSitter's foreground rules
vim.fn.matchadd("MarkdownH1", [[^#\s.*$]], 100)
vim.fn.matchadd("MarkdownH2", [[^##\s.*$]], 100)
vim.fn.matchadd("MarkdownH3", [[^###\s.*$]], 100)
vim.fn.matchadd("MarkdownH4", [[^####\s.*$]], 100)
vim.fn.matchadd("MarkdownH5", [[^#####\s.*$]], 100)
vim.fn.matchadd("MarkdownH6", [[^######\s.*$]], 100)

local b = { buffer = true }
map("n", "go",         "o* ", b)
map("n", "gO",         "O* ", b)
map("i", "$$<CR>",     "$$<CR>$$<Esc>O", b)
map("n", "<leader>lc", "o```python<CR>```<Esc>O", b)
map("n", "<localleader>lp",
  "vap:!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", b)
map("v", "<localleader>lp",
  ":!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", b)

local tmux = require("tmux")
map("n", "<leader>m", function()
  vim.cmd.write()
  tmux.send('codeblock_eval("' .. vim.fn.expand("%") .. '",' .. vim.fn.line(".") .. ')')
end, vim.tbl_extend("force", b, { silent = true }))
map("n", "<leader>M", function()
  vim.cmd.write()
  tmux.send('codeblock_eval("' .. vim.fn.expand("%") .. '")')
end, vim.tbl_extend("force", b, { silent = true }))

-- text effects
hl(0, 'markdownItalic', { bold = true, ctermfg = 14 })
hl(0, 'markdownItalicDelimiter', { bold = true, ctermfg = 14 })
hl(0, 'markdownBold', { bold = true, ctermfg = 11 })
hl(0, 'markdownBoldDelimiter', { bold = true, ctermfg = 11 })
hl(0, 'markdownBoldItalic', { bold = true, ctermfg = 13 })
hl(0, 'markdownBoldItalicDelimiter', { bold = true, ctermfg = 13 })

-- code block highlighting
local code_style = { ctermfg = 7, ctermbg = 'none' }
hl(0, 'markdownCode', code_style)
hl(0, 'markdownCodeBlock', code_style)
hl(0, 'markdownCodeDelimiter', code_style)

-- lists and links
hl(0, 'markdownListMarker', { ctermfg = 4})
hl(0, 'markdownAutomaticLink', { ctermfg = 12})

-- Date Headers
map('n', '<leader>G', function()
    local date = os.date("%Y%m%d")
    local keys = string.format("# %s\n\t= ", date)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i" .. keys .. "<Esc>", true, false, true), 'n', false)
end, vim.tbl_extend("force", b, { desc = "Insert Markdown Date Header"}))

map('n', '<leader>T', function()
    local date = os.date("%a %b %d %Y")
    vim.api.nvim_put({date}, 'c', true, true)
end, vim.tbl_extend("force", b, { desc = "Insert Full Date" }))

-- copy everything
map('n', '<localleader>C', 'Go<esc>pkdgg', b)
map('n', '<localleader>c', 'ggyG<C-o><C-o>', b)

-- insert mode bracket snippet
map('i', '\\[<cr>', '[\n[\n<Esc>O<Tab>', b)

local md_tex_snippets = {
    ['<localleader>l('] = [[i\left(<cr>\right)<esc>O]],
    ['<localleader>l['] = [[i\left[<cr>\right]<esc>O]],
    ['<localleader>la'] = [[i\begin{align*}<cr>\end{align*}<esc>O]],
    ['<localleader>lb'] = [[i\begin{bmatrix}<cr>\end{bmatrix}<esc>O]],
}

for trigger, action in pairs(md_tex_snippets) do
    map('n', trigger, action, b)
end

vim.keymap.set(
    "n",
    "<localleader>t",
    function()
        require("workhours").show_options()
    end,
    { desc = "Show work hour options" }
)
