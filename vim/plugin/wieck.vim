set nocompatible
set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i
set display=lastline
if &grepprg ==# 'grep -n $* /dev/null'
  set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude='*.log'\ --exclude=tags\ $*\ /dev/null
endif
set hlsearch
set incsearch
set laststatus=2
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list
set scrolloff=1
set sidescrolloff=5
set showcmd
set showmatch
set smarttab
if &statusline == ''
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%=%-16(\ %l,%c-%v\ %)%P
endif
set ttimeoutlen=50
set wildmenu

if $TERM == '^\%(screen\|xterm-color\)$' && t_Co == 8
  set t_Co=16
endif

let g:is_bash = 1
let g:ruby_minlines = 500
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDShutUp = 1
let g:VCSCommandDisableMappings = 1

let g:surround_{char2nr('s')} = " \r"
let g:surround_indent = 1

map Y y$
nnoremap <silent> <C-L> :nohis<CR><C-L>
inoremap <C-C> <Esc>`^
cnoremap <C-O> <Up>
inoremap ø <C-O>o
inoremap <M-o> <C-O>o
inoremap <C-X><C-@> <C-A>
" Emacs style mappings
inoremap <C-A> <C-O>^
cnoremap <C-A> <Home>
" If at end of a line of spaces, delete back to the previous line.
" Otherwise, <Left>
"inoremap <silent> <C-B>
"<C-R>=getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"<CR>
"cnoremap <C-B> <Left>
" If at end of line, decrease indent, else <Del>
"inoremap <silent> <C-D>
"<C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"<CR>
"cnoremap <C-D> <Del>
" If at end of line, fix indent, else <Right>
"inoremap <silent> <C-F>
"<C-R>=col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"<CR>
"inoremap <C-E> <End>
"cnoremap <C-F> <Right>

noremap <F1> <Esc>
noremap! <F1> <Esc>

nmap \\ <Plug>NERDCommenterInvert
xmap \\ <Plug>NERDCommenterInvert

" Enable TAB indent and SHIFT-TAB unindent
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

syntax on
filetype plugin indent on

augroup wieck
  autocmd!

  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
    \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif

  au BufRead,BufNewFile *.less setfiletype css

  autocmd FileType javascript             setlocal et sw=2 sts=2 isk+=$
  autocmd FileType html,xhtml,css         setlocal et sw=2 sts=2
  autocmd FileType eruby,yaml,ruby        setlocal et sw=2 sts=2
  autocmd FileType cucumber               setlocal et sw=2 sts=2
  autocmd FileType gitcommit              setlocal spell
  autocmd FileType racc                   setlocal et sw=2 sts=2
  autocmd FileType ruby                   setlocal comments=:#\  tw=79
  autocmd FileType vim                    setlocal et sw=2 sts=2 keywordprg=:help

  autocmd Syntax css syn sync minlines=50
augroup END
