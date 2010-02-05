" Turn off VI-compatibility.
set nocompatible

set t_Co=16
set background=dark

colorscheme vividchalk

" Turn on syntax highlighting.
syntax on

" Automatically load plugins based on filetype detection.
filetype plugin on

" Automatically load indent files based on filetype detection.
filetype indent on

" Copy indent from current line when starting a new line.
set autoindent

" Automatically reload files when changed outside of VIM.
set autoread

" Allow edited but unsaved background buffers.
set hidden

" Enhanced command-line completion (using <TAB>)
set wildmenu
set wildmode=list:longest

" Allow backspacing over autoindent, line breaks, and over the start of insert.
set backspace=indent,eol,start

" Print the line number in front of each line.
"set number

" Include as much as possible of the last line in the window.
set display=lastline

" Highlight previous search matches.
set hlsearch

" Search while typing.
set incsearch

" Always show a status line.
set laststatus=2

" Turn on list mode, making it easy to see the difference between tabs and
" spaces and for trailing blanks.
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Always show at least 1 line above and below the cursor.
set scrolloff=1

" Always show at least 5 characters left and right of the cursor.
set sidescrolloff=5

" Show (partial) command in the last line of the screen.
set showcmd

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" A <Tab> in front of a line inserts blanks according to shiftwidth, a <BS>
" will delete a shiftwidth worth of space.
set smarttab

" Enable <Tab> indent and <S-Tab> unindent.
vnoremap <silent> <Tab> >gv
vnoremap <silent> <S-Tab> <gv

" Map leader to "," (normally "\").
let g:mapleader = ","

" Setup shortcuts for buffer switching.
" Allows single keystrokes for moving between buffers (hjkl).
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l
nnoremap <silent><C-h> <C-w>h

" MiniBufExplorer configuration.
map <Leader>b :MiniBufExplorer<CR>
"let g:miniBufExplMapWindowNavVim=1
"let g:miniBufExplMapWindowNavArrows=1
"let g:miniBufExplMapCTabSwitchBufs=1
"let g:miniBufExplModSelTarget=1
let g:miniBufExplMapWindowNavVim=1

" Fuzzy Finder / Fuzzy Finder TextMate
" Similar to TextMate's "Go to File"
map <leader>t :FuzzyFinderTextMate<CR>

" NERD Tree
" Toggle NERD Tree with ",p"
nmap <silent> <Leader>p :NERDTreeToggle<CR>
" Make NERD Tree colorful and pretty
let g:NERDChristmasTree=1
" Display hidden files
let g:NERDTreeShowHidden=1
" Ignores
let g:NERDTreeIgnore=['tags', '\.git', '\\index$', '\\log$', 'tmp', '\\pkg', '\.swp$', '\.db$', '\.gz$', '\.DS_Store', '\~$']
" Close NERD Tree after opening a file
let g:NERDTreeQuitOnOpen=1
"let g:NERDTreeHighlightCursorline=1

" Taglist
" Toggle the taglist window
nnoremap <silent> <Leader>f :TlistToggle<CR>
" Display the tag list on the right.
let g:Tlist_Use_Right_Window=1
" Jump to taglist window on open.
let g:Tlist_GainFocus_On_ToggleOpen=1
" Reduce the number of empty lines in the taglist window.
let g:Tlist_Compact_Format=1
" Hide the Vim fold column.
let g:Tlist_Enable_Fold_Column=0
" Only display tags for the current active buffer.
let g:Tlist_Show_One_File=1
" Automatically close the taglist window when a tag is selected.
let g:Tlist_Close_On_Select=1
" Sort the tags by name
let g:Tlist_Sort_Type="name"

autocmd FileType eruby setlocal expandtab shiftwidth=2 softtabstop=2

" HTML, XHTML, CSS
autocmd FileType html,xhtml,css setlocal expandtab shiftwidth=2 softtabstop=2

" Javascript - Set shiftwidth, softtabstop, and add "$" to keyword characters.
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 iskeyword+=$

" Ruby
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2

" Yaml
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2

" Vim
autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2 keywordprg=:help

function! RunTests(target, args)
  silent ! echo
  exec 'silent ! echo -e "\033[1;36mRunning tests in ' . a:target . '\033[0m"'
  set makeprg=spec
  silent w
  exec "make " . a:target . " " . a:args
endfunction

function! RunTestsForFile(args)
  if @% =~ 'test_'
    call RunTests('%', a:args)
  else
    " let test_file_name = TestModuleForCurrentFile()
    " call RunTests(test_file_name, a:args)
  endif
endfunction

function! JumpToError()
  if getqflist() != []
    for error in getqflist()
      if error['valid']
        break
      endif
    endfor
    let error_message = substitude(error['text'], '^ &', '', 'g')
    silent cc!
    exec ":sbuffer " . error['bufnr']
    call RedBar()
    echo error_message
  else
    call GreenBar()
    echo "All tests passed"
  endif
endfunction

function! GreenBar()
  hi GreenBar ctermfg=white ctermbg=green guibg=green
  echohl GreenBar
  echon repeat(" ",&columns - 1)
  echohl
endfunction

function! RedBar()
  hi RedBar ctermfg=white ctermbg=red guibg=red
  echohl RedBar
  echon repeat(" ",&columns - 1)
  echohl
endfunction

nnoremap <LEADER>m :call RunTestsForFile('')<CR>:redraw<CR>:call JumpToError()<CR>
