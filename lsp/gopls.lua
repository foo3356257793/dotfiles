-- Go.  gopls resolves the module from go.mod, so a file outside any module
-- gets degraded single-file mode rather than nothing.

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
}
