" File: php_check.vim
" Author: Olivier El Mekki
" Email: olivier@el-mekki.com
" Description: ruby syntax checks the buffer
" Usage:
"   :RUBYCheck - lauch the syntax check

if exists('ruby_check_plugin')
    finish
endif

let ruby_check_plugin = 1


"Main function
function! s:RUBYCheck()
  let l:bufname = bufname( '%' )

  if ! filereadable( l:bufname ) || &modified
    let l:file = s:CreateTmp()
  else
    let l:file = l:bufname
  endif

  call s:Run( l:file )
endfunction



" Create a temporary file and copy the current buffer content in it
" @return string  the temporary file path
function! s:CreateTmp()
  let l:file = tempname()
  let l:text = getline( 0, line( '$' ) )
  call writefile( l:text, l:file )
  return l:file
endfunction



" Do the check and echo it
" @param string   the file to check
function! s:Run( file )
  echo system( 'ruby -c ' . a:file )
endfunction



command! RUBYCheck call s:RUBYCheck()
