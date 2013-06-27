set nocompatible
filetype off

set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'gmarik/vundle'

" githubにあるプラグイン
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
"Bundle 'Lokaltog/vim-powerline'

" vim-scripts上にあるプラグイン
Bundle 'molokai'
Bundle 'Zenburn'
Bundle 'wombat256.vim'

filetype plugin indent on

"hi Comment ctermfg=blue
" molokai
"let g:molokai_original=1
set t_Co=256
colorscheme wombat256mod
"colorscheme zenburn
syntax on

set hidden
set wildmenu
set wildmode=longest,list,full
set hlsearch
set incsearch
set wrapscan

set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent

set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set scrolloff=5
set showmatch matchtime=3
set number
set foldmethod=marker

"インデント
set shiftwidth=4
set tabstop=4
set expandtab
"set smartindent
set cindent

"ステータス表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P "ステータス行の表示内容を設定する
set showcmd  "入力中のステータスに表示する

"キーバインド
imap <C-f> <esc>
nmap <Space> <PageDown>
vmap <BS> x

"PHP
"文法チェック
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
"文法オプション
let php_sql_query=1
let php_htmlInStrings=1
"let php_noShortTags=1
let php_folding=1

"文字コード自動判別
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

"plugin
" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
" php Documentor (source /.vim/php-doc.vim)
inoremap <C-P> <esc>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
" powerline
"let g:Powerline_symbols='fancy'


if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set fileformats=unix,dos,mac

if exists('&ambiwidth')
  set ambiwidth=double
endif

""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
