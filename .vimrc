set encoding=utf-8
set fileformats=unix,dos,mac

"dein Scripts----- 

if &compatible
    set nocompatible
endif

" Install dir
let s:plugin_dir = expand('~/.vim/bundle')
" Add install dir to runtimepath
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_dir

" If dein hadn't installed yet, 'git clone' first.
if !isdirectory(s:dein_dir)
    call mkdir(s:dein_dir, 'p')
    silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
endif

" Install plugins when Vim started
augroup PluginInstall
    autocmd!
    autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END


if dein#load_state(s:plugin_dir)
call dein#begin(s:plugin_dir)

"Let dein manage dein
call dein#add('Shougo/dein.vim')

"Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplcache')
call dein#add('pocke/dicts')
call dein#add('vim-ruby/vim-ruby')
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('vim-scripts/Zenburn')
call dein#add('anekos/felis-cat-igirisu-toast-express')

"You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', {'rev':'3787e5'})

" If dependency exists
call dein#add('Shougo/unite.vim')
call dein#add('ujihisa/unite-colorscheme', {'depends' : 'Shougo-unite.vim'})

"Required:
call dein#end()
call dein#save_state()
endif

"End dein Scripts-----

filetype plugin indent on

"開き括弧を消したときに隣接する開き括弧を消す
function! DeleteParenthesesAdjoin()
    let pos = col(".") - 1  " カーソルの位置．1からカウント
    let str = getline(".")  " カーソル行の文字列
    let parentLList = ["(", "[", "{", "\'", "\""]
    let parentRList = [")", "]", "}", "\'", "\""]
    let cnt = 0

    let output = ""
	    
    " カーソルが行末の場合
    if pos == strlen(str)
	return "\b"
    endif
    for c in parentLList
	"カーソルの左右が同種の括弧
	if str[pos-1] == c && str[pos] == parentRList[cnt]
	    call cursor(line("."), pos + 2)
	    let output = "\b"
	    break
	endif
        let cnt += 1
    endfor
    return output."\b"
endfunction
" BackSpaceに割当て
inoremap <silent> <BS> <C-R>=DeleteParenthesesAdjoin()<CR>

"プラグインの設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#dictionary#dictionaries = {
\   'ruby': $HOME . '/dicts/ruby.dict',
\}

"補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

"フォントとカラースキーム
set guifont=Ricty:h11
set guifontwide=Ricty:h11
colorscheme zenburn 
set t_Co=256

set background=dark

"UI周り
set number
set title
set showmatch
syntax enable
set showcmd

"インデント
""set cindent
""set expandtab
""set autoindent
""set shiftwidth=2

"検索
set ignorecase
set smartcase
set wrapscan                      

"Ruby
autocmd FileType ruby setl iskeyword+=?
"markdown
au BufRead,BufNewFile *.md set filetype=markdown
"HTML
let g_indent_inctags = "html,body,head,tbody"

