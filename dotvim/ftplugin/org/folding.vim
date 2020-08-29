function! GetOrgFold(lnum)

  let thisline = getline(a:lnum)

  if thisline =~ '^\*'
    if thisline =~ '^\*[^\*]\+\*'
      return '='
    endif
    if thisline =~ '^\*\*'
      if thisline =~ '^\*\*\*'
        return '>3'
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
setlocal foldexpr=GetOrgFold(v:lnum)
