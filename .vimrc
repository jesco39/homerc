if ! has("gui_running")
       " Make X terminal emulators mo' better
       if &term != "linux"
               " 256 colors
               set t_Co=256
               " better mouse handling
               set ttymouse=xterm2
       endif
       " fancy mouse support (such as resize windows and visual mode with mouse)
       "set mouse=nvh
       set mouse=a
       if &term == "screen" || &term == "screen-bce"
               " fix End key
               exec "set <End>=\eOF"
               " set custom title
               "set titlestring=%M%{hostname()}:\ %t
               set titlestring=%M%h:\ %t
               set titlelen=15
               exec "set t_ts=\ek"
               exec "set t_fs=\e\\"
               set title
       endif
endif

colorscheme zenburn

" Tab and other spacing.....
set ts=2
set sw=2

" Used for :TOhtml (works in visual mode too!)
let html_no_pre = 1
let html_use_css = 1
let use_xhtml = 1

" line numbers
set nu
" add <> to % matching
set matchpairs+=<:>
" use indents for folds
set foldmethod=indent
set foldlevel=1
" Use US English for spell
setlocal spell spelllang=en_us
" Custom dictionary
set spellfile=~/.vim/spellfile.add
set dictionary=/usr/share/dict/words
" no spell checking by default
set nospell
" create windows under current one
set splitbelow
" create windows to the right
set splitright

" :make for perl
autocmd FileType perl compiler perl
autocmd FileType php compiler php

" omnicompletion for different languages
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" set listchars+=tab:»·,trail:·

" Key mappings
" <C-FOO>: Ctrl + Key
" <M-FOO>: Alt + Key
" <S-FOO>: Shift + Key
" <CR>: Carriage Return, <BS>: Backspace

" NERD Tree
map <silent> <F1> :NERDTreeToggle<CR>
" jump to next tag
map <silent> <F2> :TlistToggle<CR>
" toggle search highlighting
map <silent> <F3> :set invhls<CR>
" jump to next tag
map <silent> <F4> :tnext<CR>
" make (duh)
map <F5> :make<CR>
" export to colorized HTML
map <silent> <F6> :TOhtml<CR>
" toggle spell checking
map <silent> <F7> :set invspell<CR>
" toggle list modes
map <silent> <F8> :set invlist<CR>
" toggle paste mode
map <silent> <F10> :set invpaste<CR>
" toggle line numbers
map <silent> <F11> :set invnumber<CR>
" toggle fold on line
map <F12> za
" recursively toggle folds on line
map <S-F12> zA
" next buffer
map <silent> <C-B><Space> :bnext!<CR>
" previous buffer
map <silent> <C-B><BS> :bprev!<CR>
" new buffer
map <silent> <C-B>n :enew<CR>
" delete current buffer
map <silent> <C-B>c :bdelete<CR>
" go to modified buffer
map <silent> <C-B>@ :bmod!<CR>
" first buffer
map <silent> <C-B>^ :brewind!<CR>
" go to the buffer I was previously on
map <silent> <C-B># :b!#<CR>
" last buffer
map <silent> <C-B>$ :blast!<CR>
" new tab
map <silent> <C-H>n :tabnew<CR>
" close tab
map <silent> <C-H>c :tabclose<CR>
" next tab
map <silent> <C-H><Space> :tabn<CR>
" previous tab
map <silent> <C-H><BS> :tabp<CR>
" next file
map <silent> <C-N><Space> :next!<CR>
" previous file
map <silent> <C-N><BS> :prev!<CR>
" first file
map <silent> <C-N>^ :rewind!<CR>
" last file
map <silent> <C-N>$ :last!<CR>

" move viewport one line up
map <C-Up> <C-Y>
" move viewport one line down
map <C-Down> <C-E>
" next tab
noremap <silent> <S-Right> :tabn<CR>
" previous tab
noremap <silent> <S-Left> :tabp<CR>

nmap <silent> <C-S-c> <Plug>Comment
nmap <silent> <C-S-d> <Plug>DeComment

" nnoremap: only in normal mode
" open fold on line
nnoremap <C-Right> zo
" close fold on line
nnoremap <C-Left> zc

" inoremap: only in visual mode
" Ctrl+Space omnicompletion
inoremap <F2> <C-O>:TlistToggle<CR>
inoremap <Nul> <C-X><C-O>
inoremap <F3> <C-O>:set invhls<CR>
inoremap <F6> <C-O><C-W>w
inoremap <S-F6> <C-O><C-W>W
inoremap <F7> <C-O>:set invspell<CR>
inoremap <F10> <C-O>:set paste!<CR>
inoremap <F11> <C-O>:set invnumber<CR>
inoremap <F12> <C-O>za
inoremap <S-F12> <C-O>zA
inoremap <C-Up> <C-O><C-Y>
inoremap <C-Down> <C-O><C-E>
inoremap <S-Right> <C-O>:tabn<CR>
inoremap <S-Left> <C-O>:tabp<CR>

imap <C-c> <C-O><Plug>Comment
imap <C-d> <C-O><Plug>DeComment

set autoindent
set cindent
syntax on
set hlsearch