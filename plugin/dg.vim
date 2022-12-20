if exists('g:loaded_dg') | finish | endif # prevent loading twice

let s:save_cpo = &cpo # save user coptions
set cpo&vim  # reset them to default

command! dg lua require'dg'.dg()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_dg = 1
