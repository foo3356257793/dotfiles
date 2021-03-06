" highlight the escaped braces
syn match juliaEscapedQuote +{{+ contained containedin=juliaStringPrefixed
syn match juliaEscapedQuote +}}+ contained containedin=juliaStringPrefixed

syntax region  juliafString	matchgroup=juliaStringDelim start=+f\z("\(""\)\?\)+ end=+\z1+ contains=juliaInterpolation
 
syn region juliaInterpolation contained
      \ matchgroup=SpecialChar
      \ start=+{{\@!+ end=+}}\@!+ skip=+{{+ keepend
      \ contains=ALLBUT

syn match juliaStringModifier /:\(.[<^=>]\)\?[-+ ]\?#\?0\?[0-9]*[_,]\?\(\.[0-9]*\)\?[bcdeEfFgGnosxX%]\?/ contained containedin=juliaInterpolation
syn match juliaStringModifier /![sra]/ contained containedin=juliaInterpolation
" 
hi link juliafString String
hi link juliaStringModifier PreProc
