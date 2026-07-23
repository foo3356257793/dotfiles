-- Python, plus the python.sage compound filetype set in init.lua for .sage
-- and .spyx.
--
-- Two things are needed to reach sage files.  Attachment is an exact string
-- match on the whole filetype (vim/lsp.lua), so "python" alone never matches
-- "python.sage" -- unlike ftplugin loading, which splits on the dot.  And the
-- languageId sent to the server defaults to that same filetype string, which
-- pyright would not recognise as Python; get_language_id rewrites it.
--
-- Sage's own namespace stays unresolved: sage runs from its conda env, not
-- the system python, so QQ, ZZ, matrix and friends report as undefined and
-- `from sage.all import *` as unresolved.  Only the plain-Python parts of a
-- .sage file are really checked.  To fix it on a machine that has sage, set
-- settings.python.pythonPath to that env's python from machine.lua -- the
-- path is machine-specific, so it does not belong in here.

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python", "python.sage" },

  get_language_id = function(_, filetype)
    return filetype == "python.sage" and "python" or filetype
  end,

  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "pyrightconfig.json",
    ".git",
  },
}
