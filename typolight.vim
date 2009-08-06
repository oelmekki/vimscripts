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


function! s:DCAtext( fieldname )
  let l:block = []
  call add( l:block, "                '" . a:fieldname . "' => array" )
  call add( l:block, "                (" )
  call add( l:block, "                        'label'                   => &$GLOBALS['TL_LANG']['" . s:guessTableName() . "']['" . a:fieldname . "']," )
  call add( l:block, "                        'exclude'                 => true," )
  call add( l:block, "                        'inputType'               => 'text'," )
  call add( l:block, "                        'eval'                    => array('mandatory'=>true, 'maxlength'=>255)" )
  call add( l:block, "                )," )
  call append( line('.'), l:block )
endfunction


function! s:DCAselect( fieldname )
  let l:block = []
  call add( l:block, "                '" . a:fieldname . "' => array" )
  call add( l:block, "                (" )
  call add( l:block, "                        'label'                   => &$GLOBALS['TL_LANG']['" . s:guessTableName() . "']['" . a:fieldname . "']," )
  call add( l:block, "                        'exclude'                 => true," )
  call add( l:block, "                        'inputType'               => 'select'," )
  call add( l:block, "                        'options'                 => array()," )
  call add( l:block, "                        'options_callback'        => ''," )
  call add( l:block, "                        'foreignKey'              => ''," )
  call add( l:block, "                        'eval'                    => array('mandatory'=>true, 'multiple'=> false)" )
  call add( l:block, "                )," )
  call append( line('.'), l:block )
endfunction


function! s:DCAfiletree( fieldname )
  let l:block = []
  call add( l:block, "                '" . a:fieldname . "' => array" )
  call add( l:block, "                (" )
  call add( l:block, "                        'label'                   => &$GLOBALS['TL_LANG']['" . s:guessTableName() . "']['" . a:fieldname . "']," )
  call add( l:block, "                        'exclude'                 => true," )
  call add( l:block, "                        'inputType'               => 'eFileTree'," )
  call add( l:block, "                        'eval'                    => array('mandatory'=>true, 'fieldType' => 'radio', 'files' => true,  'path' => 'tl_files/')" )
  call add( l:block, "                )," )
  call append( line('.'), l:block )
endfunction


function! s:DCArte( fieldname )
  let l:block = []
  call add( l:block, "                '" . a:fieldname . "' => array" )
  call add( l:block, "                (" )
  call add( l:block, "                        'label'                   => &$GLOBALS['TL_LANG']['" . s:guessTableName() . "']['" . a:fieldname . "']," )
  call add( l:block, "                        'exclude'                 => true," )
  call add( l:block, "                        'inputType'               => 'textarea'," )
  call add( l:block, "                        'eval'                    => array('mandatory'=>true, 'rte'=> 'tinyMCE')" )
  call add( l:block, "                )," )
  call append( line('.'), l:block )
endfunction


function! s:DCAm2m( fieldname )
  let l:block = []
  call add( l:block, "                '" . a:fieldname . "' => array" )
  call add( l:block, "                (" )
  call add( l:block, "                        'label'                   => &$GLOBALS['TL_LANG']['" . s:guessTableName() . "']['" . a:fieldname . "']," )
  call add( l:block, "                        'exclude'                 => true," )
  call add( l:block, "                        'inputType'               => 'manyToManyCheckbox'," )
  call add( l:block, "                        'foreignKey'              => ''," )
  call add( l:block, "                        'eval'                    => array('mandatory'=>true, 'thisModel' => '', 'thatModel' => '', 'multiple' => true)," )
  call add( l:block, "                )," )
  call append( line('.'), l:block )
endfunction


function! s:DCAdate( fieldname )
  let l:block = []
  call add( l:block, "                '" . a:fieldname . "' => array" )
  call add( l:block, "                (" )
  call add( l:block, "                        'label'                   => &$GLOBALS['TL_LANG']['" . s:guessTableName() . "']['" . a:fieldname . "']," )
  call add( l:block, "                        'exclude'                 => true," )
  call add( l:block, "                        'inputType'               => 'text'," )
  call add( l:block, "                        'eval'                    => array('rgxp'=>'date', 'datepicker'=>$this->getDatePickerString(), 'tl_class'=>'w50 wizard')" )
  call add( l:block, "" )
  call add( l:block, "                )," )
  call append( line('.'), l:block )
endfunction



com! -nargs=1 DCAtext call s:DCAtext("<args>")
com! -nargs=1 DCAselect call s:DCAselect("<args>")
com! -nargs=1 DCAfiletree call s:DCAfiletree("<args>")
com! -nargs=1 DCArte call s:DCArte("<args>")
com! -nargs=1 DCAm2m call s:DCAm2m("<args>")
com! -nargs=1 DCAdate call s:DCAdate("<args>")
