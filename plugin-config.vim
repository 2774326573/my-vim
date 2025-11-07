" =============== 插件配置 ===============

" =============== 主题配置 ===============
" 默认主题: gruvbox
silent! colorscheme gruvbox
set background=dark

" Lightline 状态栏
let g:lightline = {
\ "colorscheme": "gruvbox",
\ "active": {
\   "left": [["mode", "paste"], ["readonly", "filename", "modified"]],
\   "right": [["lineinfo"], ["percent"], ["fileformat", "fileencoding", "filetype"]]
\ }
\}

" 主题切换命令
command! ThemeGruvbox colorscheme gruvbox | set background=dark | let g:lightline.colorscheme = 'gruvbox' | call lightline#init() | call lightline#colorscheme()
command! ThemeGruvboxLight colorscheme gruvbox | set background=light | let g:lightline.colorscheme = 'gruvbox' | call lightline#init() | call lightline#colorscheme()
command! ThemeOneDark colorscheme onedark | let g:lightline.colorscheme = 'onedark' | call lightline#init() | call lightline#colorscheme()
command! ThemeDracula colorscheme dracula | let g:lightline.colorscheme = 'dracula' | call lightline#init() | call lightline#colorscheme()
command! ThemeNord colorscheme nord | let g:lightline.colorscheme = 'nord' | call lightline#init() | call lightline#colorscheme()
command! ThemeAyu colorscheme ayu | let g:lightline.colorscheme = 'ayu' | call lightline#init() | call lightline#colorscheme()

" =============== Coc.nvim ===============
let g:coc_global_extensions = [
\ "coc-clangd","coc-pyright","coc-lua","coc-html","coc-css",
\ "coc-tsserver","coc-json","coc-emmet","coc-sh","coc-prettier"
\ ]

" =============== NERDTree ===============
if exists('g:loaded_nerdtree')
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=0
  let NERDTreeMinimalUI=1
  let NERDTreeIgnore=['\.git$', '\.pyc$', '__pycache__']
  let NERDTreeHijackNetrw=0  " 不自动替换 netrw
endif

" 防止 NERDTree 自动打开
let g:NERDTreeHijackNetrw=0
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | endif

" =============== UndoTree ===============
" 无需特殊配置

" =============== Tagbar 大纲 ===============
let g:tagbar_width = 35
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_show_linenumbers = 0
let g:tagbar_autoshowtag = 1

" 自定义图标
let g:tagbar_iconchars = ['▸', '▾']

" 快捷键
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" =============== EasyAlign ===============
" 无需特殊配置

" =============== EasyMotion ===============
if exists('g:loaded_easymotion')
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
endif

" =============== GitGutter ===============
" 使用默认配置

" =============== Vimspector ===============
let g:vimspector_enable_mappings = "HUMAN"

" UI 配置
let g:vimspector_sidebar_width = 60
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 75

" 自定义快捷键
nmap <F5> <Plug>VimspectorContinue
nmap <F3> <Plug>VimspectorStop
nmap <F4> <Plug>VimspectorRestart
nmap <F6> <Plug>VimspectorPause
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F8> <Plug>VimspectorAddFunctionBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <F12> <Plug>VimspectorStepOut

" Leader 键快捷键
nnoremap <leader>du :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dr :call vimspector#Reset()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>
nnoremap <leader>di :call vimspector#StepInto()<CR>
nnoremap <leader>do :call vimspector#StepOver()<CR>
nnoremap <leader>dO :call vimspector#StepOut()<CR>

" =============== CMake ===============
" 使用默认配置

" =============== Vim-Translator 翻译 ===============
" 翻译引擎配置
let g:translator_target_lang = 'zh'
let g:translator_source_lang = 'auto'
let g:translator_default_engines = ['bing', 'youdao', 'google']

" 翻译窗口配置
let g:translator_window_type = 'popup'
let g:translator_window_max_width = 0.6
let g:translator_window_max_height = 0.6
let g:translator_history_enable = v:true

" 快捷键配置
" 翻译光标下的单词或选中文本
nmap <silent> <Leader>tt <Plug>TranslateW
vmap <silent> <Leader>tt <Plug>TranslateWV
" 翻译并替换
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
" 翻译并在窗口中显示
nmap <silent> <Leader>tw <Plug>Translate
vmap <silent> <Leader>tw <Plug>TranslateV
" 替换为翻译结果
nmap <silent> <Leader>tx <Plug>TranslateX
vmap <silent> <Leader>tx <Plug>TranslateXV

" =============== Startify 启动页 ===============
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_lists = [
\ { 'type': 'files',     'header': ['   最近文件']            },
\ { 'type': 'dir',       'header': ['   当前目录 '. getcwd()] },
\ { 'type': 'sessions',  'header': ['   会话']                },
\ { 'type': 'bookmarks', 'header': ['   书签']                },
\ { 'type': 'commands',  'header': ['   命令']                },
\ ]

let g:startify_bookmarks = [
\ { 'v': '~/.vimrc' },
\ { 'p': '~/vimfiles/plugins.vim' },
\ { 's': '~/vimfiles/settings.vim' },
\ { 'k': '~/vimfiles/keymaps.vim' },
\ ]

let g:startify_commands = [
\ { 'i': ['安装插件', 'PlugInstall'] },
\ { 'u': ['更新插件', 'PlugUpdate'] },
\ { 'c': ['清理插件', 'PlugClean'] },
\ ]

let g:startify_custom_header = [
\ '                                                                   ',
\ '    ██████╗ ███╗   ██╗███████╗██╗    ██╗██╗   ██╗               ',
\ '   ██╔═══██╗████╗  ██║██╔════╝██║    ██║██║   ██║     ⸜(｡˃ ᵕ ˂ )⸝',
\ '   ██║   ██║██╔██╗ ██║█████╗  ██║ █╗ ██║██║   ██║       ╱|、      ',
\ '   ██║   ██║██║╚██╗██║██╔══╝  ██║███╗██║██║   ██║      (˚ˎ 。7     ',
\ '   ╚██████╔╝██║ ╚████║███████╗╚███╔███╔╝╚██████╔╝       |、˜〵     ',
\ '    ╚═════╝ ╚═╝  ╚═══╝╚══════╝ ╚══╝╚══╝  ╚═════╝       じしˍ,)ノ   ',
\ '                                                                   ',
\ '                [ 按 <Space> 查看快捷键菜单 ]                     ',
\ '                                                                   ',
\ ]

let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 3
let g:startify_session_delete_buffers = 1
let g:startify_change_to_dir = 1
let g:startify_enable_special = 0

" =============== Which-Key ===============
" 使用 vim-which-key (Vim 兼容版本)
" 配置选项
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}
let g:which_key_fallback_to_native_key = 1
let g:which_key_position = 'botright'
let g:which_key_run_map_on_popup = 0  " 禁止自动弹出

" 创建 Leader 键字典
let g:which_key_map = {}

" 文件操作
let g:which_key_map.f = {
      \ 'name' : '+文件' ,
      \ 'f' : ['Files'     , '查找文件'],
      \ 'g' : ['Rg'        , '全文搜索'],
      \ 'b' : ['Buffers'   , 'Buffer列表'],
      \ 'h' : ['Helptags'  , '搜索帮助'],
      \ 'r' : ['History'   , '最近文件'],
      \ 'c' : ['History:'  , '命令历史'],
      \ 'm' : ['Marks'     , '标记列表'],
      \ 'w' : ['Windows'   , '窗口列表'],
      \ 'n' : ['enew'      , '新建文件'],
      \ 'e' : ['NERDTreeToggle', '文件树'],
      \ 't' : ['TagbarToggle', '大纲视图'],
      \ }

" 窗口操作
let g:which_key_map.w = {
      \ 'name' : '+窗口' ,
      \ 'w' : ['<C-w>w'     , '切换窗口'],
      \ 'd' : ['<C-w>c'     , '删除窗口'],
      \ 's' : ['split'      , '水平分屏'],
      \ 'v' : ['vsplit'     , '垂直分屏'],
      \ 'o' : ['<C-w>o'     , '只保留当前'],
      \ }

" Buffer 操作
let g:which_key_map.b = {
      \ 'name' : '+Buffer' ,
      \ 'b' : ['Buffers'   , 'Buffer列表'],
      \ 'd' : ['bdelete'   , '删除Buffer'],
      \ 'D' : ['bdelete!'  , '强制删除'],
      \ 'o' : ['bufdo bd'  , '删除其他'],
      \ }

" Tab 操作
let g:which_key_map.tab = {
      \ 'name' : '+标签页' ,
      \ }

" LSP 操作
let g:which_key_map.c = {
      \ 'name' : '+代码/LSP' ,
      \ 'a' : ['coc-codeaction', '代码操作'],
      \ 'f' : ['CocFormat'     , '格式化'],
      \ 'l' : ['coc-codeaction-line', '行操作'],
      \ 'd' : ['CocList diagnostics', '诊断列表'],
      \ 's' : ['CocList symbols'    , '符号列表'],
      \ 'o' : ['CocList outline'    , '大纲'],
      \ 'c' : ['CocList commands'   , '命令列表'],
      \ 'g' : ['CMakeGenerate', 'CMake生成'],
      \ 'b' : ['CMakeBuild'  , 'CMake构建'],
      \ 'r' : ['CMakeRun'    , 'CMake运行'],
      \ 't' : ['CMakeSelectBuildType', '选择构建类型'],
      \ }

" Git 操作
let g:which_key_map.g = {
      \ 'name' : '+Git' ,
      \ 'g' : ['Git'        , 'Git状态'],
      \ 'd' : ['Git diff'   , 'Git差异'],
      \ 'b' : ['Git blame'  , 'Git责任'],
      \ 'l' : ['Git log'    , 'Git日志'],
      \ 'p' : ['Git push'   , 'Git推送'],
      \ 'P' : ['Git pull'   , 'Git拉取'],
      \ 'c' : ['Git commit' , 'Git提交'],
      \ 'a' : ['Git add %'  , '暂存当前'],
      \ 'A' : ['Git add .'  , '暂存所有'],
      \ 's' : ['GitGutterStageHunk'  , '暂存Hunk'],
      \ 'u' : ['GitGutterUndoHunk'   , '撤销Hunk'],
      \ 'h' : ['GitGutterPreviewHunk', '预览Hunk'],
      \ }

" 调试
let g:which_key_map.d = {
      \ 'name' : '+调试' ,
      \ 'u' : ['VimspectorToggleUI', '调试UI'],
      \ 'r' : ['VimspectorReset'   , '重置'],
      \ }

" 其他
let g:which_key_map.u = {
      \ 'name' : '+工具' ,
      \ 'u' : ['UndotreeToggle', '撤销树'],
      \ 'w' : ['set wrap!'       , '切换换行'],
      \ 'r' : ['set relativenumber!', '切换相对行号'],
      \ 'n' : ['set number!'     , '切换行号'],
      \ 's' : ['set spell!'      , '切换拼写'],
      \ 'l' : ['set list!'       , '切换不可见字符'],
      \ 'c' : ['set cursorline!' , '切换光标行'],
      \ 'x' : ['set cursorcolumn!', '切换光标列'],
      \ }

" 翻译菜单
let g:which_key_map.t = {
      \ 'name' : '+翻译' ,
      \ 't' : ['Translate'        , '翻译单词/文本'],
      \ 'r' : ['TranslateR'       , '翻译并替换'],
      \ 'w' : ['TranslateWindow'  , '在窗口显示'],
      \ 'x' : ['TranslateX'       , '替换光标词'],
      \ 'b' : ['TagbarToggle'     , '大纲视图'],
      \ }

" 注册 Which-Key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
