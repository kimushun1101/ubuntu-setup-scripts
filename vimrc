"Display
colorscheme elflord
set background=dark
syntax on					"シンタックスカラーリングを設定する
set number				"行番号を表示する
set title					"編集中のファイル名を表示する
set showcmd				"入力中のコマンドを表示する
set ruler					"座標を表示する
set showmatch			"閉じ括弧の入力時に対応する括弧を表示する
set matchtime=3		"showmatchの表示時間
set laststatus=2	"ステータスラインを常に表示する
set tabstop=2
set shiftwidth=2
set cursorline		"カーソルラインを入れる"
" 以下，文字化けを防ぐ
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac


" 改行時の自動コメントアウトをオフにする
augroup auto_comment_off
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=r
	autocmd BufEnter * setlocal formatoptions-=o
augroup END

set backup
set backupdir=$HOME/.vimbackup
au BufWritePre * let &bex = '.' . strftime("%Y%m%d_%H%M%S")
" バックアップを取得するファイル名を「ファイル名.タイムスタンプ」とする

nnoremap <Space>h  ^
nnoremap <Space>l  $

nnoremap k	gk
nnoremap j	gj
vnoremap k	gk
vnoremap j	gj
nnoremap gk	k
nnoremap gj	j
vnoremap gk	k
vnoremap gj	j

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" move window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

" jkでエスケープ
inoremap <silent> jk <ESC>
" 日本語入力で”ｊｋ”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> ｊｋ <ESC>
nmap <CR> i<CR><ESC>	"nomal mode Enter を有効にする
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>

set list
set listchars=tab:>-,trail:_,nbsp:%
",eol:$
