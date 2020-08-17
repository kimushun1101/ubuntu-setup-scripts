"Display
colorscheme desert
"set background=dark
"syntax on   "シンタックスカラーリングを設定する
"set number    "行番号を表示する
"set title    "編集中のファイル名を表示する
"set showcmd    "入力中のコマンドを表示する
"set ruler    "座標を表示する
"set showmatch   "閉じ括弧の入力時に対応する括弧を表示する
"set matchtime=3 "showmatchの表示時間
"set laststatus=2    "ステータスラインを常に表示する
"set tabstop=4
"set shiftwidth=4

"colorscheme elflord

" full screen
set lines=200
set columns=120
winpos 1200 0

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" Mac IME off
if has('mac')
	set imdisable
"	set noimdisableactivate
endif
