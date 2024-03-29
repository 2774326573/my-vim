"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "      " 定义<leader>键{{{
set nocompatible    " 设置不兼容原始vi模式
filetype on         " 设置开启文件类型侦测
filetype plugin on  " 设置加载对应文件类型的插件
set noeb            " 关闭错误的提示
syntax enable       " 开启语法高亮功能
syntax on           " 自动语法高亮
set t_Co=256        " 开启256色支持
set cmdheight=2     " 设置命令行的高度
set showcmd         " select模式下显示选中的行数
set ruler           " 总是显示光标位置
set cursorcolumn    " 十字架"
set laststatus=2    " 总是显示状态栏
set number               " 开启行号显示
set cursorline           " 高亮显示当前行
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码缩进和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent           " 设置自动缩进{{{
set cindent              " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0    " 设置C/C++语言的具体缩进方式
set smartindent          " 智能的选择对其方式
filetype indent on       " 自适应不同语言的智能缩进
set expandtab            " 将制表符扩展为空格
set tabstop=4            " 设置编辑时制表符占用空格数
set shiftwidth=4         " 设置格式化时制表符占用空格数
set softtabstop=4        " 设置4个空格为制表符
set smarttab             " 在行和段开始处使用制表符
set wrap               " 禁止折行
set backspace=2          " 使用回车键正常处理indent,eol,start等
set sidescroll=10        " 设置向右滚动字符数
set foldenable         " 启用折叠代码
set foldmethod=marker
au BufWinLeave  silent mkview
au BufWinEnter  silent loadview"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码补全
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu             " vim自身命名行模式智能补全{{{
set completeopt-=preview " 补全时不显示窗口，只显示补全列表}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch            " 高亮显示搜索结果{{{
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup            " 设置不备份{{{
set noswapfile          " 禁止生成临时文件
set autoread            " 文件在vim之外修改过，自动重新读入
set autowrite           " 设置自动保存
set confirm             " 在处理未保存或只读文件的时候，弹出确认
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8"{{{
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gvim/macvim设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running") "{{{
    let system = system('uname -s')
    if system == "Darwin\n"
        set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h18 " 设置字体
    else
        set guifont=DroidSansMono\ Nerd\ Font\ Regular\ 18      " 设置字体
    endif
    set guioptions-=m           " 隐藏菜单栏
    set guioptions-=T           " 隐藏工具栏
    set guioptions-=L           " 隐藏左侧滚动条
    set guioptions-=r           " 隐藏右侧滚动条
    set guioptions-=b           " 隐藏底部滚动条
    set showtabline=0           " 隐藏Tab栏
    set guicursor=n-v-c:ver5    " 设置光标为竖线
endif"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 卸载默认插件UnPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:deregister(repo)"{{{
  let repo = substitute(a:repo, '[\/]\+$', '', '')
  let name = fnamemodify(repo, ':t:s?\.git$??')
  call remove(g:plugs, name)
endfunction
command! -nargs=1 -bar UnPlug call s:deregister(<args>)
"}}}
"markdown
let g:mkdp_browserfunc='MKDP_browserfunc_default'"preview使用默认设置"
let g:mkdp_auto_start=1"markdown preview全部自动"
let g:mkdp_auto_open=1
let g:mkdp_auto_close=1
let g:mdip_imgdir='.'"image paste的文件夾目录"
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter_disabled=1
let g:vim_markdown_new_window=1
let g:vim_markdown_browser_open_command="xdg-open"
autocmd FileType markdown nmap <buffer><silent><leader>i :call mdip#MarkdownClipboardImage()<CR>
" 这里将markdown预览所使用的浏览器指定为firefix
let g:mkdp_browser = '/usr/bin/firefox'

"
" 编辑vimrc相关配置文件
nnoremap <leader>e :edit $MYVIMRC<cr>
nnoremap <leader>vc :edit ~/my-vim/vimrcs/plugins_config.vim<cr>
nnoremap <leader>vp :edit ~/my-vim/vimrcs/plugins.vim<cr>
nnoremap <leader>vb :edit ~/my-vim/vimrcs/basic.vim<cr>

" 查看vimplus的help文件
nnoremap <leader>h :view +let\ &l:modifiable=0 ~/.vimplus/help.md<cr>

" 打开当前光标所在单词的vim帮助文档
nnoremap <leader>H :execute ":help " . expand("<cword>")<cr>

" 重新加载vimrc文件
nnoremap <leader>s :source $MYVIMRC<cr>

" 安装、更新、删除插件
nnoremap <leader><leader>i :PlugInstall<cr>
nnoremap <leader><leader>u :PlugUpdate<cr>
nnoremap <leader><leader>c :PlugClean<cr>

" 窗口分屏
nnoremap s " "
nnoremap sv :vsp<CR>
nnoremap sh :sp<CR>

" 分屏窗口移动
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-h> <C-w>h
nnoremap <A-l> <C-w>l

" 关闭当前窗口
nnoremap sc <C-w>c
"关闭其他
nnoremap so <C-w>o
"相等比例
nnoremap s= <C-w>=

" 替换方向键为调节分屏大小
map <C-up> :res -5<CR>
map <C-down> :res +5<CR>
map <C-left> :vertical resize+5<CR>
map <C-right> :vertical resize-5<CR>

inoremap jk <ESC> 

" 按键映射
map ww :w<CR>
map <leader>q :q!<CR>
map qq :wqa!<CR>
map te :terminal<CR>

" 复制当前选中到系统剪切板
vmap <C-c> "+y

" 将系统剪切板内容粘贴到vim
nnoremap <C-v> "+p

" 打开文件自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" 主题设置
set background=dark
let g:onedark_termcolors=256
