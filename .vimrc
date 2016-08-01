set encoding=utf-8
set fileformats=unix,dos

"dein Scripts-----

if &compatible
	set nocompatible
endif

" Install dir
let s:plugin_dir = expand('~/.vim/bundle')
" Add install dir to runtimepath
let s:dein_dir = s:plugin_dir . '/repos/github.com/Shougo/dein.vim'
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
	call dein#add('Shougo/neocomplete.vim')
	call dein#add('pocke/dicts')

	call dein#add('vim-ruby/vim-ruby')

	call dein#add('plasticboy/vim-markdown')
	call dein#add('kannokanno/previm')
	call dein#add('tyru/open-browser.vim')

	"Colorscheme
	call dein#add('vim-scripts/Zenburn')
	call dein#add('tomasr/molokai')

	"Utils
	call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

	call dein#add('itchyny/lightline.vim')
	call dein#add('vim-scripts/fcitx.vim')

	call dein#add('nathanaelkane/vim-indent-guides')
	call dein#add('bronson/vim-trailing-whitespace')

	call dein#add('hokaccha/vim-html5validator')

	call dein#add('thinca/vim-ref')

	"Haskell
	call dein#add('kana/vim-filetype-haskell')
	call dein#add('eagletmt/ghcmod-vim')
	call dein#add('ujihisa/neco-ghc')
	call dein#add('osyo-manga/vim-watchdogs')
	call dein#add('ujihisa/ref-hoogle')

	"You can specify revision/branch/tag.
	call dein#add('Shougo/vimshell', {'rev':'3787e5'})

	"Coq
	call dein#add('jvoorhis/coq.vim')
	call dein#add('vim-scripts/CoqIDE')

	" If dependency exists
	call dein#add('Shougo/unite.vim')
	call dein#add('ujihisa/unite-colorscheme', {'depends' : 'Shougo-unite.vim'})
	call dein#add('kmnk/vim-unite-giti')
	call dein#add('tpope/vim-fugitive')
	call dein#add('ujihisa/unite-haskellimport')

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
" 補完(neocomplete)

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:neocomplete#sources#dictionary#dictionaries = {
			\   'ruby': $HOME . '/dicts/ruby.dict',
			\}



"括弧補完
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
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd Ctermbg=240
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven Ctermbg=234
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

"UI周り
set number
set title
set showmatch
syntax enable
set showcmd

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

"lightline
set laststatus=2

let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'mode_map': {'c': 'NORMAL'},
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
			\ },
			\ 'component_function': {
			\   'modified': 'LightLineModified',
			\   'readonly': 'LightLineReadonly',
			\   'fugitive': 'LightLineFugitive',
			\   'filename': 'LightLineFilename',
			\   'fileformat': 'LightLineFileformat',
			\   'filetype': 'LightLineFiletype',
			\   'fileencoding': 'LightLineFileencoding',
			\   'mode': 'LightLineMode'
			\ }
			\ }

function! LightLineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
	return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		return fugitive#head()
	else
		return ''
	endif
endfunction

function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction



