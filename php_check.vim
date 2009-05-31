" File: tab_alternate.vim
" Author: Olivier El Mekki
" Email: olivier@el-mekki.com
" Description: script allow to switch to the last seen tab, as the screen C-a a
" Usage:
"   :Tabalter - go to the last seen tab

if exists('php_check_plugin')
    finish
endif

let php_check_plugin = 1


"Main function
function! s:PHPCheck()
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
  echo system( 'php -l ' . a:file )
endfunction



command! PHPCheck call s:PHPCheck()
nnoremap <C-c> :PHPCheck<CR>
inoremap <C-c> <esc>:PHPCheck<CR>
