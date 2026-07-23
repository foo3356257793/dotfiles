-- C/C++.  clangd wants a compilation database to know your flags: either
-- compile_commands.json (cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1, or bear --
-- make) or a hand-written compile_flags.txt, one flag per line.  With neither
-- it guesses, and the guesses are poor on anything with include paths.

return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".clangd",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
}
