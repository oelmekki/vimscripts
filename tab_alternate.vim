" File: tab_alternate.vim
" Author: Olivier El Mekki
" Email: olivier@el-mekki.com
" Description: script allow to switch to the last seen tab, as the screen C-a C-a
" Usage:
"   :Tabalter - go to the last seen tab

if exists('tab_alternate_plugin')
    finish
endif

let tab_alternate_plugin = 1

function! s:SetLastSeen()
    let s:last_seen = tabpagenr()
endfunction

function! s:GetLastSeen()
    silent! execute ":tabnext ". s:last_seen
endfunction

au TabLeave * call s:SetLastSeen()
command! Tabalter call s:GetLastSeen()
nnoremap <C-p> :Tabalter<CR>
inoremap <C-p> <esc>:Tabalter<CR>

