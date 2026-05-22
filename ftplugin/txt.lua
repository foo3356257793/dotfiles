local map = vim.keymap.set

local bo = vim.bo
bo.textwidth   = 68
bo.autoindent  = true
bo.softtabstop = 4
bo.shiftwidth  = 4

map("n", "go", "o- ", { buffer = true })
map("n", "gO", "O- ", { buffer = true })

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
