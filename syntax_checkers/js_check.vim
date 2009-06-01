" File: php_check.vim
" Author: Olivier El Mekki
" Email: olivier@el-mekki.com
" Description: js syntax checks the buffer. 
" Depends on Rhino
" Provides third-party lib jslint.js
" Usage:
"   :JSCheck - lauch the syntax check

if exists('js_check_plugin')
    finish
endif

let js_check_plugin = 1


"Main function
function! s:JSCheck()
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
  echo system( g:rhino_path . ' ' . g:jslint_path . ' ' . a:file )
endfunction



" Find the jslint.js path
" @return string the path
function! s:JsLintPath()
  let l:runtime_paths = split( &rtp, ',' )

  for l:path in l:runtime_paths
    let l:guess = l:path . '/plugin/js/jslint.js'
    if filereadable( l:guess )
      return l:guess
    endif
  endfor

  return 'undefined'
endfunction



let g:rhino_path = '/usr/bin/jsscript-1.6'
let g:jslint_path = s:JsLintPath()

command! JSCheck call s:JSCheck()
