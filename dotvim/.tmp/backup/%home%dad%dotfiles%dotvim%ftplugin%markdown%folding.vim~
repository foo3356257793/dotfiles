function! GetMarkdownFold(lnum)

  let thisline = getline(a:lnum)

  if thisline =~ '^#'
    if thisline =~ '^##'
      if thisline =~ '^###'
        if thisline =~ '^####'
          if thisline =~ '^#####'
            if thisline =~ '^######'
              return '>6'
            else
              return '>5'
            endif
          else
            return '>4'
          endif
        else
          return '>3'
        endif
      else
        return '>2'
      endif
    else
      return '>1'
    endif
  endif
  return '='
endfunction

setlocal foldmethod=expr
setlocal foldexpr=GetMarkdownFold(v:lnum)
