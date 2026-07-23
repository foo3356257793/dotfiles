# Global latexmk configuration, symlinked to ~/.latexmkrc.
#
# Its whole job is to make the engine's errors machine-readable, so tex-make can
# reduce a build's output to a few file:line: lines. latexmk reads this before
# any project-local ./latexmkrc, so a paper that needs different settings still
# wins.
#
# -file-line-error turns
#     ! Undefined control sequence.
# into
#     ./paper.tex:42: Undefined control sequence.
# The bare form names no file: recovering one means tracking (/) nesting across
# the entire transcript, which is exactly the fragile parsing this avoids.
#
# -interaction=nonstopmode keeps errors on the terminal and stops the build
# blocking on "?". It matters most when something else has asked for batchmode
# -- latexmk's own -silent does -- because in batchmode the errors go only to
# the .log and stdout has nothing to parse.
#
# Both are injected before %S rather than replacing the command, so latexmk's
# defaults survive. Position is load-bearing: latexmk substitutes its own
# options at %O, so flags placed after it win any -interaction conflict, and %S
# (the source file) has to stay last.

for my $cmd (\$latex, \$pdflatex, \$xelatex, \$lualatex) {
    $$cmd =~ s/%S/-file-line-error -interaction=nonstopmode %S/;
}

# TeX hard-wraps terminal and log output at 79 columns, splitting long messages
# and paths mid-line where no regex can follow them. tex-make sets this too, so
# it does not depend on this file; here it covers a bare `make` in a shell.
$ENV{'max_print_line'} = 10000;
