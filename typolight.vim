" File: qdiv.vim
" Author: Olivier El Mekki
" Email: olivier@el-mekki.com
" Description: Tools for Tyupolight
" Usage:
"   :DCAtext <field> - creaet a text input dca entry template

if exists('typolight_plugin')
    finish
endif

let typolight_plugin = 1


function! s:guessTableName()
  let l:line_pos = search( "\\$GLOBALS\\['TL_LANG'\\]\\['.\\{-\\}'\\]", 'bn' )
  let l:line = getline( l:line_pos )
  let l:table = substitute( l:line, ".\\{-\\}\\$GLOBALS\\['TL_LANG'\\]\\['\\([^']\\+\\)'\\].*", '\1', "")
  return l:table
endfunction



function! s:findTplPath( name )
  let l:runtime_paths = split( &rtp, ',' )

  for l:path in l:runtime_paths
    let l:guess = l:path . '/plugin/typolight_templates/' . a:name . '.tpl'
    if filereadable( l:guess )
      return l:guess
    endif
  endfor

  return 'undefined'
endfunction



function! s:TLdca( tablename )
  let l:lines = readfile( s:findTplPath( 'dca' ) )
  let l:dest  = []

  for l:line in l:lines
    call add( l:dest, substitute( l:line, 'CARBON', a:tablename, '' ) )
  endfor

  call append( line( '0' ), l:dest )
endfunction



function! s:TLmodel( args )
  let l:names = split( a:args, ' ' )
  let l:modelname = l:names[0]
  let l:tablename = l:names[1]

  let l:lines = readfile( s:findTplPath( 'emodel' ) )
  let l:dest  = []

  for l:line in l:lines
    let l:line = substitute( l:line, 'TABLE_NAME', l:tablename, '' ) 
    let l:line = substitute( l:line, 'MODEL_NAME', l:modelname, '' ) 
    call add( l:dest, l:line )
  endfor

  call append( line( '0' ), l:dest )
endfunction



function! s:TLcontroller( controllername )
  let l:lines = readfile( s:findTplPath( 'controller' ) )
  let l:dest  = []

  for l:line in l:lines
    let l:line = substitute( l:line, 'CONTROLLER_NAME', a:controllername, '' ) 
    let l:line = substitute( l:line, 'CONTROLLER_PREFIX', tolower( a:controllername ), '' ) 
    call add( l:dest, l:line )
  endfor

  call append( line( '0' ), l:dest )
endfunction



function! s:TLlangDca( tablename )
  let l:lines = readfile( s:findTplPath( 'langDca' ) )
  let l:dest  = []

  for l:line in l:lines
    call add( l:dest, substitute( l:line, 'CARBON', a:tablename, '' ) )
  endfor

  call append( line( '0' ), l:dest )
endfunction



function! s:DCAfield( inputname, fieldname )
  let l:lines = readfile( s:findTplPath( a:inputname ) )
  let l:dest  = []
  let l:tablename = s:guessTableName()

  for l:line in l:lines
    let l:line = substitute( l:line, 'TABLE_NAME', l:tablename, '' ) 
    let l:line = substitute( l:line, 'CARBON', a:fieldname, '' ) 
    call add( l:dest, l:line )
  endfor

  call append( line( '.' ), l:dest )
endfunction




com! -nargs=1 DCAtext call s:DCAfield( 'dca_text', "<args>" )
com! -nargs=1 DCAselect call s:DCAfield( 'dca_select', "<args>" )
com! -nargs=1 DCAfiletree call s:DCAfield( 'dca_filetree', "<args>" )
com! -nargs=1 DCArte call s:DCAfield( 'dca_rte', "<args>" )
com! -nargs=1 DCAm2m call s:DCAfield( 'dca_m2m', "<args>" )
com! -nargs=1 DCAdate call s:DCAfield( 'dca_date', "<args>" )
com! -nargs=1 DCAcheckbox call s:DCAfield( 'dca_checkbox', "<args>" )

com! -nargs=1 TLdca call s:TLdca("<args>")
com! -nargs=1 TLmodel call s:TLmodel("<args>")
com! -nargs=1 TLcontroller call s:TLcontroller("<args>")
com! -nargs=1 TLlangDca call s:TLlangDca("<args>")
