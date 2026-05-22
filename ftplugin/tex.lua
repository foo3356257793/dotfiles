local map = vim.keymap.set

local bo = vim.bo
bo.textwidth   = 68
bo.tabstop     = 2
bo.shiftwidth  = 2
bo.softtabstop = 2
bo.autoindent  = true

local b = { buffer = true }
map("n", "<leader>a",       "{gq}<C-o><C-o>", b)
map("n", [[<localleader>"]], [[viW<Esc>a''<Esc>hBi``<Esc>lEl]], b)
map("i", [[\[<CR>]],         [[\[<CR>\]<Esc>O]], b)
map("i", "$$<CR>",           "$$<CR>$$<Esc>O", b)
map("n", "<localleader>li",  "i\\begin{itemize}<CR>\\end{itemize}<Esc>O\\item ", b)
map("n", "<localleader>le",  "i\\begin{enumerate}<CR>\\end{enumerate}<Esc>O\\item ", b)
map("n", "<localleader>la",  "i\\begin{align*}<CR>\\end{align*}<Esc>O", b)
map("n", "<localleader>lb",  "i\\begin{bmatrix}<CR>\\end{bmatrix}<Esc>O", b)
map("n", "<localleader>ls",  "i\\section{}<Esc>i", b)
map("n", "<localleader>lS",  "i\\subsection{}<Esc>i", b)
map("n", "<localleader>lB",  "i\\subsubsection{}<Esc>i", b)
map("n", "<localleader>lp",  "i\\paragraph{}<Esc>i", b)
map("n", "go",               "o\\item ", b)
map("n", "gO",               "O\\item ", b)

local abbrevs = {
  { "teh",       "the"        },
  { "hte",       "the"        },
  { "taht",      "that"       },
  { "htat",      "that"       },
  { "thigns",    "things"     },
  { "adn",       "and"        },
  { "waht",      "what"       },
  { "somewaht",  "somewhat"   },
  { "tehn",      "then"       },
  { "sucess",    "success"    },
  { "succes",    "success"    },
  { "sucessful", "successful" },
  { "succesful", "successful" },
  { "worte",     "wrote"      },
  { "htem",      "them"       },
  { "wsa",       "was"        },
  { "ot",        "to"         },
  { "mroe",      "more"       },
}
for _, ab in ipairs(abbrevs) do
  vim.cmd(string.format("iabbrev <buffer> %s %s", ab[1], ab[2]))
end
