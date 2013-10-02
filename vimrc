" 关闭 vi 兼容模式
set nocompatible

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'tomasr/molokai'
" Bundle 'vim-renpy'
Bundle 'zeis/vim-kolor'
Bundle 'altercation/vim-colors-solarized'
Bundle 'lilypink'

" 屏蔽方向键
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" 显示行号
set number

" 自动语法高亮
syntax on

" 设定配色方案
"let g:molokai_original = 1
"color molokai

if has('gui_running')
    set background=light
else
    set background=dark
endif

color solarized

" 设置右下角标尺
set ruler
set rulerformat=%15(%c%V\ %p%%%)

"用确认对话框（对于 gvim）或命令行选项（对于vim）来代替有未保存内容时的警告信息
set confirm

" 上下可视行数
set scrolloff=6

" 设定 tab 长度为 4
set tabstop=4

" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4

"开启时，在行首按TAB将加入shiftwidth个空格，否则加入tabstop个空格。
set smarttab

"是否将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB>
set expandtab

" 中文帮助
set helplang=cn

" 保留历史记录
set history=1024

" 行控制
set linebreak " 英文单词在换行时不被截断
"set textwidth=80 " 设置每行80个字符自动换行，加上换行符

" 高亮光标所在的行
set cursorline

" 覆盖文件时不备份
set nobackup
set nowb

" 自动切换当前目录为当前文件所在的目录
set autochdir

" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
set ignorecase
set smartcase

" 搜索到文件两端时不重新搜索
set nowrapscan

" 实时搜索
set incsearch

" 搜索时高亮显示被找到的文本
set hlsearch

" 关闭错误声音
set noerrorbells
set novisualbell
set t_vb=

" 设定在任何模式下鼠标都可用
set mouse=a

" 自动重新读入
set autoread " 当文件在外部被修改，自动更新该文件

set lines=40 columns=100

" 设置leader为,
"let mapleader=","
"let g:mapleader=","

" 检测文件类型
filetype plugin indent on

" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set backspace=indent,eol,start
set whichwrap+=<,>,h,l

" 不自动换行
"set nowrap
"How many tenths of a second to blink
set mat=2

" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set hidden

" 智能自动缩进
set smartindent

" 设定命令行的行数为 1
set cmdheight=1

" 显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2

"显示括号配对情况
set showmatch

" 解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题
set display=lastline

" 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)\ %=\[%P]

" 显示Tab符
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu " 只在下拉菜单中显示匹配项目，并且会自动插入所有匹配项目的相同文本

"启动时不显示 捐赠提示
set shortmess=atl

"blank      空白
"buffers    缓冲区
"curdir     当前目录
"folds      折叠
"help       帮助
"options    选项
"tabpages   选项卡
"winsize    窗口大小
"slash      转换文件路径中的\为/以使session文件兼容unix
"unix       设置session文件中的换行模式为unix
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,slash,unix,resize

" 跳过页头注释，到首行实际代码
func! GotoFirstEffectiveLine()
    let l:c = 0
    while l:c<line("$") && (
                \ getline(l:c) =~ '^\s*$'
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*Comment.*"
                \ || synIDattr(synID(l:c, 1, 0), "name") =~ ".*PreProc$"
                \ )
        let l:c = l:c+1
    endwhile
    exe "normal ".l:c."Gz\<CR>"
endf

" 返回当前时期
func! GetDateStamp()
    return strftime('%Y-%m-%d')
endfunction

" 全选
func! SelectAll()
    let s:current = line('.')
    exe "norm gg" . (&slm == "" ? "VG" : "gH\<C-O>G")
endfunc

" {{{ 开始折叠
set foldenable

" 设置语法折叠
" manual  手工定义折叠
" indent  更多的缩进表示更高级别的折叠
" expr    用表达式来定义折叠
" syntax  用语法高亮来定义折叠
" diff    对没有更改的文本进行折叠
" marker  对文中的标志折叠
set foldmethod=indent

"折叠相关的快捷键
"zR 打开所有的折叠
"za Open/Close (toggle) a folded group of lines.
"zA Open a Closed fold or close and open fold recursively.
"zi 全部 展开/关闭 折叠
"zo 打开 (open) 在光标下的折叠
"zc 关闭 (close) 在光标下的折叠
"zC 循环关闭 (Close) 在光标下的所有折叠
"zM 关闭所有可折叠区域
" 设置折叠区域的宽度
set foldcolumn=0

" 设置折叠层数
setlocal foldlevel=1

"设置代码块折叠后显示的行数
set foldexpr=1

" 新建的文件，刚打开的文件不折叠
autocmd! BufNewFile,BufRead * setlocal nofoldenable

" }}}

" Alt-W切换自动换行
noremap <a-w> :exe &wrap==1 ? 'set nowrap' : 'set wrap'<cr>

" 选中状态下 Ctrl+c 复制
vnoremap <c-c> "+y

" Shift + Delete 插入系统剪切板中的内容
noremap <S-Del> "+p
inoremap <S-Del> <esc>"+pa
vnoremap <S-Del> d"+P

if has("gui_running")
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    set showtabline=0 " 隐藏Tab栏

    if has("win32")
        " Windows 兼容配置
        source $VIMRUNTIME/mswin.vim

        " F11 最大化
        map <f11> :call libcallnr('fullscreen.dll', 'ToggleFullScreen', 0)<cr>

        " 字体配置
        set guifont=YaHei_Consolas_Hybrid:h12:cANSI
        set guifontwide=YaHei_Consolas_Hybrid:h12
    endif

    if has("unix") && !has('gui_macvim')
        set guifont=Monaco\ 10
    endif

    if has("mac") || has("gui_macvim")
        if has("gui_macvim")
            " MacVim 下的字体配置
            set guifont=Monaco:h14
            set guifontwide=Monaco:h14

            set transparency=2
            set lines=200 columns=120

            " 使用 MacVim 原生的全屏幕功能
            set fuopt+=maxhorz

        endif
    endif
endif

" F2切换工具栏
map <silent> <F2> :if &guioptions =~# 'T' <bar>
        \set guioptions-=T <bar>
    \else <bar>
        \set guioptions+=T <bar>
    \endif<cr>

"编辑vim配置文件
if has("unix")
    set fileformats=unix,dos,mac
    nmap <leader>e :tabnew $HOME/.vimrc<cr>
    let $VIMFILES = $HOME."/.vim"
else
    set fileformats=dos,unix,mac
    nmap <leader>e :tabnew $VIM/_vimrc<cr>
    let $VIMFILES = $VIM."/vimfiles"
endif

" Alt-Space is System menu
if has("gui")
  noremap <m-space> :simalt ~<cr>
  inoremap <m-space> <c-o>:simalt ~<cr>
  cnoremap <m-space> <c-c>:simalt ~<cr>
endif

" {{{ 编码字体设置
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8

    if has('win32')
        language english
        let &termencoding=&encoding " 处理consle输出乱码
    endif

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,shift-jis,cp936,cp950,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set ambiwidth=double
" }}}

" 删除所有行未尾空格
nnoremap <f12> :%s/[ \t\r]\+$//g<cr>

" 窗口切换
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

" Buffers/Tab操作快捷方式!
nnoremap <s-h> :bprevious<cr>
nnoremap <s-l> :bnext<cr>
nnoremap <s-j> :tabnext<cr>
nnoremap <s-k> :tabprev<cr>

" 插入模式下上下左右移动光标
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk

"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nnoremap <leader>1 :set filetype=xhtml<cr>
nnoremap <leader>2 :set filetype=css<cr>
nnoremap <leader>3 :set filetype=javascript<cr>
nnoremap <leader>4 :set filetype=php<cr>

" nerdtree
let g:NERDTreeWinSize=25
let g:NERDTreeMinimalUI=1
let g:nerdtree_tabs_open_on_gui_startup=0
nmap nc :NERDTreeTabsToggle<cr>
