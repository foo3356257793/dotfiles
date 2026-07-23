-- Lua.  The only server here needing settings: without them lua-language-
-- server flags `vim` as an undefined global on nearly every line of this
-- config.  $VIMRUNTIME/lua carries the LuaCATS annotations in vim/_meta that
-- declare the global and the whole core API, so pointing the library at it is
-- enough; scanning the full runtimepath would also index every plugin, which
-- costs a startup for completion on the handful of require() calls here.
--
-- checkThirdParty stops the "do you want to configure this as a luassert /
-- busted workspace?" prompt on unfamiliar directories.

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = { vim.env.VIMRUNTIME .. "/lua" },
        checkThirdParty = false,
      },
    },
  },
}
