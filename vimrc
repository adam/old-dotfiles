syntax on
filetype plugin indent on
" colorscheme vividchalk
colorscheme summerfruit256

let g:mapleader = ","

nmap <silent> <Leader>p :NERDTreeToggle<CR>
let NERDChristmasTree=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['tags', '\.git', '\index$', '\log$', 'tmp', '\pkg', '\.swp$', '\.db$', '\.gz$', '\.DS_Store', '\~$']

" BufExplorer
nnoremap <C-B> :BufExplorer<cr>

" FuzzyFinder/FuzzyFinder_Textmate
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, }
map <leader>t :FuzzyFinderTextMate<CR>
let g:fuzzy_ignore = "**/tmp/*,**/index/*,**/log/*,*~,*.db,*.flv,*.gif,*.gz,*.jpg,*.lck,*.pdf,*.png,*.swf,*.swp"

function CurrentDirectoryName(path)
ruby << EOS
#result = VIM::evaluate('a:path').match(/^.*\/([^\/].*)$/)[1]
  result = `pwd`.chomp.match(/^.*\/([^\/].*)$/)[1]
  VIM::command "let l:result = \"#{result}\""
EOS
  return l:result
endfunction

if (has('gui_running'))
	set guifont=Monaco:h16
	set guioptions-=T
	set columns=120
	set lines=70
	set number
        set guitablabel=%{CurrentDirectoryName(getcwd())}
end
