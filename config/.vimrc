"Display
set number  "行番号を表示する
set title    "編集中のファイル名を表示する
set showcmd  "入力中のコマンドを表示する
set ruler    "座標を表示する
set showmatch  "閉じ括弧の入力時に対応する括弧を表示する
set matchtime=3  "showmatchの表示時間
set laststatus=2  "ステータスラインを常に表示する
set tabstop=2
set shiftwidth=2
set cursorline  "カーソルラインを入れる"

set backup
set backupdir=$HOME/.vimbackup
au BufWritePre * let &bex = '.' . strftime("%Y%m%d_%H%M%S")
" バックアップを取得するファイル名を「ファイル名.タイムスタンプ」とする

nnoremap <Space>j  ^
nnoremap <Space>k  $
nnoremap <Space>l  $
nnoremap <Space>l  $

nnoremap j  gj
nnoremap k  gk
vnoremap j  gj
vnoremap k  gk
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j

inoremap <silent> jk <ESC>
inoremap <silent> ｊｋ <ESC>
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>
