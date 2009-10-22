syntax on
filetype plugin indent on
colorscheme vividchalk
" colorscheme summerfruit256
" colorscheme pyte
" colorscheme ir_black

let g:mapleader = ","

" Buffer switching
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l
nnoremap <silent><C-h> <C-w>h
nnoremap <silent><S-h> :bp<CR>
nnoremap <silent><S-l> :bn<CR>

" Nerd Tree
nmap <silent> <Leader>p :NERDTreeToggle<CR>
let NERDChristmasTree=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['tags', '\.git', '\\index$', '\\log$', 'tmp', '\\pkg', '\.swp$', '\.db$', '\.gz$', '\.DS_Store', '\~$']

" BufExplorer
nnoremap <C-B> :BufExplorer<cr>

" FuzzyFinder/FuzzyFinder_Textmate
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, }
map <leader>t :FuzzyFinderTextMate<CR>
let g:fuzzy_ignore = "**/tmp/*,**/index/*,**/log/*,*~,*.db,*.flv,*.gif,*.gz,*.jpg,*.lck,*.pdf,*.png,*.swf,*.swp"

" Taglist
map <leader>f :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Use_Right_Window = 1
let Tlist_Sort_Type = "name"
let Tlist_Show_One_File = 1
let Tlist_Display_Tag_Scope = 0

" Align
vmap <silent> <Leader>i= <ESC>:AlignPush<CR>:AlignCtrl lp1P1<CR>:'<,'>Align =<CR>:AlignPop<CR>
vmap <silent> <Leader>i, <ESC>:AlignPush<CR>:AlignCtrl lp0P1<CR>:'<,'>Align ,<CR>:AlignPop<CR>
vmap <silent> <Leader>i( <ESC>:AlignPush<CR>:AlignCtrl lp0P0<CR>:'<,'>Align (<CR>:AlignPop<CR>

function CurrentDirectoryName(path)
ruby << EOS
#result = VIM::evaluate('a:path').match(/^.*\/([^\/].*)$/)[1]
  result = `pwd`.chomp.match(/^.*\/([^\/].*)$/)[1]
  VIM::command "let l:result = \"#{result}\""
EOS
  return l:result
endfunction

function StripTrailingWhitespace()
  normal mz
  normal Hmy
  exec '%s/\s*$//g'
  normal 'yz<cr>
  normal `z
endfunction

command Trim call StripTrailingWhitespace()
