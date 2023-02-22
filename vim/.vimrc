set nocompatible											" 不兼容vi的设置
source $VIMRUNTIME/vimrc_example.vim

let s:iswindows = has('win32') || has('win64')

if s:iswindows
	source $VIMRUNTIME/mswin.vim
	behave mswin
endif

" 基本设置
syntax enable												" 语法高亮

set hlsearch												" 高亮显示搜索字符串
set incsearch												" 同步高亮显示搜索字符串
" set wrapscan												" 搜索到末尾,继续从开头继续查找
" set ignorecase											" 搜索忽略大小写
set number													" 显示行号

set enc=utf-8												" 设置编码
set fenc=utf-8												" 设置文件编码
set fencs=utf-8,gbk,gb2312,ucs-bom,cp936					" 设置文件编码检测类型及支持格式

set langmenu=zh_CN.UTF-8									" 指定菜单语言
language message zh_CN.UTF-8								" 提示信息编码

" 设置终端编码
if s:iswindows
	set termencoding=GBK
else
	set termencoding=UTF-8
endif

" 菜单乱码解决
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set fileformats=unix										" 保存文件格式(简写：set ff)
" set foldmethod=indent										" 按缩进折叠
set cindent
set autoindent												" 自动缩进
set smartindent												" 智能自动缩进 开启cindent 此项无效
set tabstop=4												" tab宽度
set softtabstop=4											" 插入tab时把tab算作的空格数
set shiftwidth=4											" 每步缩进空格数
" set expandtab												" 空格代替制表符
set showmatch												" 匹配括号
set history=100												" 设置记录查找或者命令的历史数目
set ruler													" 总在Vim窗口的右下角显示当前光标位置
set showcmd													" 在Vim窗口右下角,标尺的右边显示未完成的命令
set textwidth=0												" 关闭插入文本的最大宽度限制
" set nowrap													" 关闭自动换行
set wrap													" 自动换行
set noundofile												" 取消 undo 操作文件
set noswapfile												" 取消swap文件
set sidescroll=10											" 1次滚动10个字符
" set list													" 显示tab键以及换行符
set sessionoptions+=unix,slash								" 保存的session会话文件的格式在两种系统上都适用
set guioptions+=bR											" 水平滚动条
set clipboard+=unnamed										" 粘贴板
let mapleader=","											" 命令前缀设置

if has('gui_running')
	set cursorline												" 开启窗口游标行标尺
	set cursorcolumn											" 开启窗口游标列标尺
	set listchars=eol:$,tab:→\ ,trail:·,extends:>,precedes:<	" 高亮显示Tab键
else
	set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<		" 高亮显示Tab键
endif

nmap <F6> <ESC>:!cls && php -f <C-R>%<CR>					" 执行当前php脚本
" let g:pep8_map=<F5>										" pep8快捷键


" 字体设置 微软雅黑
" 10px（适合<14英寸屏幕）
" set guifont=Bitstream_Vera_Sans_Mono:h9:cANSI
" set gfw=Yahei_Mono:h10:cGB2312
" 10.5px（适合>17英寸屏幕）
" set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
" set gfw=Yahei_Mono:h10.5:cGB2312

" 关闭自动备份
if has('vms')
	set nobackup
else
	set nobackup
endif

" 启动时 窗口最大化
if s:iswindows
	au GUIEnter * simalt ~x
elseif has('gui_running')
	au GUIEnter * call MaximizeWindow()
	" set lines=999 columns=9999
endif

function! MaximizeWindow()
	" Linux下需要安装wmctrl
	silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction


"""""""""""""""""""""""""""""""""""""""" 分割线 """"""""""""""""""""""""""""""""""""""""


" Vundle设置

" let s:bundle = s:iswindows ? '$HOME/vimfile/bundle' : '$HOME/.vim/bundle'
let s:bundle = '$HOME/.vim/bundle'
let s:bundle_dir = expand(s:bundle, 1)
let $vundle_dir = s:bundle_dir.'/vundle'

if !isdirectory(s:bundle_dir)
	call mkdir(s:bundle_dir, 'p')
endif

if !isdirectory($vundle_dir)
	let cmd = 'git clone https://github.com/gmarik/vundle.git "' . $vundle_dir . '"'
	" let output = system(cmd)
	call system(cmd)
endif

filetype off
set rtp+=$vundle_dir
call vundle#rc(s:bundle)


"""""""""""""""""""""""""""""""""""""""" 分割线 """"""""""""""""""""""""""""""""""""""""


" Vundle管理自己(必须)
Plugin 'http://github.com/gmarik/vundle'


" [github repository]

" 主题背景
if has('gui_running')
	set background=dark
else
	set background=light
endif

" 主题配色方案

" Plugin 'https://github.com/altercation/vim-colors-solarized'
" let g:solarized_termcolors = 256
" let g:solarized_bold = 1									" 粗体控制
" let g:solarized_underline = 1								" 下划线控制
" let g:solarized_italic = 0									" 斜体控制
" let g:solarized_contrast = "normal"							" 对比度 normal|high|low
" let g:solarized_visibility = "normal"						" 透明度 normal|high|low
" if isdirectory(s:bundle_dir.'/vim-colors-solarized')
	" colorscheme solarized
" endif

" Plugin 'https://github.com/sjl/badwolf.git'
" let g:badwolf_darkgutter = 1
" let g:badwolf_tabline = 1
" let g:badwolf_html_link_underline = 1
" let g:badwolf_css_props_highlight = 1
" if isdirectory(s:bundle_dir.'/badwolf')
	" colorscheme badwolf
" endif

" Plugin 'https://github.com/morhetz/gruvbox.git'
" if isdirectory(s:bundle_dir.'/gruvbox')
	" colorscheme gruvbox
" endif

Plugin 'https://github.com/tomasr/molokai.git'
" let g:molokai_original = 1
" let g:rehash256 = 1
if isdirectory(s:bundle_dir.'/molokai')
	colorscheme molokai
endif

" 主题管理
Plugin 'https://github.com/heronotears/vim-cs-explorer.git'


" 代码补全
" Plugin 'https://github.com/ervandew/supertab'
" let g:SuperTabRetainCompletionType=2
" let g:SuperTabMappingForward = '<c-tab>'
" let g:SuperTabDefaultCompletionType="context"
" "let g:SuperTabDefaultCompletionType="<C-X><C-O>"
" set completeopt=longest,menu								" 关掉智能补全时的预览窗口 new-omni-completion

" 状态栏美化-powerline
Plugin 'https://github.com/powerline/powerline.git'
set laststatus=2
set t_Co=256
let s:PL_symbols = s:iswindows ? 'fancy' : 'compatible'
let g:Powerline_symbols = s:PL_symbols						" compatible | unicode | fancy
" let g:Powerline_theme = 'solarized256'
" let g:Powerline_colorscheme = 'solarized256'
let g:Powerline_stl_path_style = 'full'
let g:Powerline_dividers_override = ['>>', '>', '<<', '<']

" 状态栏美化-airline
Plugin 'https://github.com/bling/vim-airline.git'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

" 神级插件 ZenCoding可以让你以一种神奇而无比爽快的感觉写HTML、CSS
" Plugin 'https://github.com/mattn/emmet-vim'

" indentLine(缩进对齐线 用于以空格缩进的代码 如果以tab缩进的,可以使用:set list lcs=tab:\|\) 注意:(行太长会导致 行移动慢)
" Plugin 'https://github.com/Yggdroot/indentLine'

" 较于Command-T等查找文件的插件,ctrlp.vim最大的好处在于没有依赖,干净利落
Plugin 'https://github.com/kien/ctrlp.vim'

" NERD出品的在VIM的编辑窗口树状显示文件目录
Plugin 'https://github.com/scrooloose/nerdtree'

" NERD出品的快速给代码加注释插件 :h NERDCommenter
Plugin 'https://github.com/scrooloose/nerdcommenter'
" let g:NERDMenuMode = 0										" 关闭菜单项
let g:NERDSpaceDelims = 1									" 在注释的开头和末尾添加一个空格

Plugin 'https://github.com/majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>									" 设置快捷键
let g:tagbar_width = 40										" 设置宽度，默认为40
" autocmd VimEnter * nested :call tagbar#autoopen(1)			" 打开vim时自动打开tagbar
" let g:tagbar_left = 1										" 在左侧
let g:tagbar_right = 1										" 在右侧


" Track the engine.
" Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
" Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" 神级代码补全 函数跳转插件(windows下需安装非官方的windows版本)
" Plugin 'https://github.com/Valloric/YouCompleteMe.git'

" Plugin 'https://github.com/davidhalter/jedi-vim.git'

" 赋值对齐
Plugin 'https://github.com/godlygeek/tabular'

" json语法高亮
Plugin 'https://github.com/elzr/vim-json'

" 去除尾部空格
Plugin 'https://github.com/gagoar/StripWhiteSpaces'

" 语法检查
Plugin 'https://github.com/scrooloose/syntastic.git'

" git wrapper
Plugin 'https://github.com/tpope/vim-fugitive.git'

Plugin 'https://github.com/tpope/vim-markdown.git'

" Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'

" 自动补全() [] {} "" ''等
Plugin 'https://github.com/Raimondi/delimitMate.git'


"""""""""""""""""""""""""""""""""""""""" 分割线 """"""""""""""""""""""""""""""""""""""""


" [vim-scripts repository -- http://vim-scripts.org/vim/scripts.html]

" 自动识别文件编码
Plugin 'FencView.vim'

Plugin 'taglist.vim'
map ,t :Tlist<CR>											" 用于浏览tags的脚本
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1								" 在右侧窗口中显示taglist窗口

" 窗口管理
Plugin 'winmanager'
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<CR>


"""""""""""""""""""""""""""""""""""""""" 分割线 """"""""""""""""""""""""""""""""""""""""


" [git repository but not in github]



" 在vundle管理后必须设置
filetype plugin indent on									" 自动嗅探文件类型并使用相应的类型插件以及缩进文件配置

" :h vundle					- show help
" :PluginList				- list configured bundles
" :PluginInstall(!)			- install(update) bundles
" :PluginSearch(!) foo		- search(or refresh cache first) for foo
" :PluginClean(!)			- confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..


" set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
	if &sh =~ '\<cmd'
	  let cmd = '""' . $VIMRUNTIME . '\diff"'
	  let eq = '"'
	else
	  let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
	endif
  else
	let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" 常用映射
" map <C-D> "=strftime("%Y-%m-%d %H:%M:%S")<CR>gP		" 插入当前日期
nmap <F2> :source %<CR>								" 执行vim测试脚本

" autocmd! BufNewFile *.py 0read $VIM/vimfiles/ftplugin/python/template.py
" autocmd! BufNewFile *.php 0read $VIM/vimfiles/template/template.php

autocmd FileType python setlocal expandtab
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

iabbr icode <code class="inset">!cursor!</code><Esc>:call search('!cursor!','b')<CR>cf!
iabbr forl for (int i = 0; i < !cursor!; i++) {<ESC>:call search('!cursor!','b')<CR>cf!

autocmd! BufWritePost _vimrc source %				" 自动加载配置文件
