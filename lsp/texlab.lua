-- LaTeX and BibTeX.  This shares tex buffers with vimtex, which keeps the
-- parts it is better at: vimtex sets 'omnifunc' itself, and vim.lsp only
-- claims 'omnifunc' when it is still at its default, so completion stays
-- vimtex's (citations, labels, \ref) and texlab never sees it.  What texlab
-- adds in tex is hover and go-to-definition on \ref and \cite.
--
-- bib is where it is uncontested -- no vimtex ftplugin runs there -- so it
-- brings entry syntax diagnostics and document symbols.
--
-- Not claiming plaintex: that filetype mostly shows up on misdetected .tex
-- fragments, and spawning a server for those is noise.
--
-- Expect duplicate error reports in tex: texlab parses the source, vimtex
-- reads the build log via :VimtexErrors.  Overlapping, not conflicting.
--
-- Formatting needs latexindent on PATH; without it texlab simply declines.

return {
  cmd = { "texlab" },
  filetypes = { "tex", "bib" },
  root_markers = { ".latexmkrc", "latexmkrc", "Tectonic.toml", ".git" },
}
