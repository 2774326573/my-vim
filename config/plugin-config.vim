" =============== 插件配置 ===============

" =============== auto-pairs 配置 ===============
" 禁用 auto-pairs 对回车键的映射，让补全菜单的回车键能正常工作
let g:AutoPairsMapCR = 0

" =============== 彩虹括号 ===============
let g:rainbow_active = 1
let g:rainbow_conf = {
\  'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\  'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\  'operators': '_,_',
\  'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\  'separately': {
\    '*': {},
\    'tex': {
\      'parentheses': ['start=/(/ end=/)/'],
\    },
\    'vim': {
\      'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
\    },
\  }
\}

" =============== 彩虹缩进 ===============
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
" 自定义彩虹缩进颜色（使用更明显的对比色）
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#282828 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3836 ctermbg=237
let g:indent_guides_exclude_filetypes = ['help', 'startify', 'nerdtree', 'tagbar']
" 快捷键切换彩虹缩进
nnoremap <leader>ig :IndentGuidesToggle<CR>

" =============== 智能代码折叠 ===============
" FastFold - 提高折叠性能
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" SimpylFold - Python 智能折叠
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 1
let g:SimpylFold_fold_import = 0

" =============== 主题配置 ===============
" 默认主题: gruvbox
silent! colorscheme gruvbox
set background=dark

" Lightline 状态栏
let g:lightline = {
\ "colorscheme": "wombat",
\ "active": {
\   "left": [["mode", "paste"], ["readonly", "filename", "modified"]],
\   "right": [["lineinfo"], ["percent"], ["fileformat", "fileencoding", "filetype"]]
\ }
\}

" 主题切换命令
command! ThemeGruvbox colorscheme gruvbox | set background=dark | let g:lightline.colorscheme = 'wombat' | call lightline#init() | call lightline#colorscheme()
command! ThemeGruvboxLight colorscheme gruvbox | set background=light | let g:lightline.colorscheme = 'wombat' | call lightline#init() | call lightline#colorscheme()
command! ThemeOneDark colorscheme onedark | let g:lightline.colorscheme = 'onedark' | call lightline#init() | call lightline#colorscheme()
command! ThemeDracula colorscheme dracula | let g:lightline.colorscheme = 'dracula' | call lightline#init() | call lightline#colorscheme()
command! ThemeNord colorscheme nord | let g:lightline.colorscheme = 'nord' | call lightline#init() | call lightline#colorscheme()
" ayu 主题配置（支持 light/dark/mirage 三种模式）
let g:ayucolor="dark"  " 默认暗色主题，可选: light, dark, mirage
command! ThemeAyu colorscheme ayu | let g:lightline.colorscheme = 'ayu' | call lightline#init() | call lightline#colorscheme()
command! ThemeAyuLight let g:ayucolor="light" | colorscheme ayu | let g:lightline.colorscheme = 'ayu' | call lightline#init() | call lightline#colorscheme()
command! ThemeAyuMirage let g:ayucolor="mirage" | colorscheme ayu | let g:lightline.colorscheme = 'ayu' | call lightline#init() | call lightline#colorscheme()

" =============== 补全菜单美化 ===============
" 设置补全菜单的颜色和样式
if has('termguicolors')
  try
    set termguicolors
  catch /E954/
    " 当前终端不支持 24 位彩色，继续使用 cterm 配色。
  endtry
endif

" 补全菜单样式配置
highlight Pmenu ctermfg=15 ctermbg=236 guifg=#ffffff guibg=#3a3a3a
highlight PmenuSel ctermfg=0 ctermbg=109 guifg=#000000 guibg=#83a598
highlight PmenuSbar ctermbg=239 guibg=#4e4e4e
highlight PmenuThumb ctermbg=246 guibg=#949494

" 避免 vim-polyglot 在无文件启动时通过 <afile> 探测空 buffer 而报 E495。
silent! autocmd! filetypedetect BufWinEnter

" LSP 诊断标记颜色
highlight LspErrorText ctermfg=Red guifg=#fb4934
highlight LspWarningText ctermfg=Yellow guifg=#fabd2f
highlight LspInformationText ctermfg=Blue guifg=#83a598
highlight LspHintText ctermfg=Green guifg=#8ec07c

" =============== LSP / 补全 ===============
let g:myvim_lsp_engine = get(g:, 'myvim_lsp_engine', 'coc')

if g:myvim_lsp_engine ==# 'coc'
  " coc.nvim 使用本仓库自带 Node 和数据目录，便于离线/便携运行。
  if exists('g:my_vim_config_dir')
    let g:coc_node_path = simplify(g:my_vim_config_dir . '/tools/node/node.exe')
  endif
  if exists('g:myvim_data_dir')
    let g:coc_data_home = simplify(g:myvim_data_dir . '/coc-data')
  endif
  let g:coc_disable_startup_warning = 1
  let g:coc_disable_mappings_check = 1
  let g:coc_snippet_next = '<tab>'
  let g:coc_snippet_prev = '<s-tab>'
  let g:coc_global_extensions = get(g:, 'coc_global_extensions', [])
  for s:coc_ext in ['coc-clangd@0.29.3', 'coc-markdownlint@1.11.0', 'coc-snippets@3.0.14', 'coc-word@1.2.2']
    if index(g:coc_global_extensions, s:coc_ext) < 0
      call add(g:coc_global_extensions, s:coc_ext)
    endif
  endfor
  unlet! s:coc_ext
  let g:coc_user_config = get(g:, 'coc_user_config', {})
  let g:coc_user_config['suggest.autoTrigger'] = 'always'
  let g:coc_user_config['suggest.minTriggerInputLength'] = 1
  let g:coc_user_config['suggest.triggerAfterInsertEnter'] = v:true
  let g:coc_user_config['suggest.timeout'] = 5000
  let g:coc_user_config['lua.checkForUpdates'] = 'disabled'
  let g:coc_user_config['markdownlint.onOpen'] = v:true
  let g:coc_user_config['markdownlint.onSave'] = v:true
  let g:coc_user_config['markdownlint.onChange'] = v:true
  let g:coc_user_config['snippets.snipmate.enable'] = v:true
  let g:coc_user_config['snippets.ultisnips.enable'] = v:false
  let g:coc_user_config['snippets.loadFromExtensions'] = v:true
  let g:coc_user_config['snippets.autoTrigger'] = v:true
  let g:coc_user_config['snippets.priority'] = 95
  let g:coc_user_config['coc.source.word.enable'] = v:true
  let g:coc_user_config['coc.source.word.priority'] = 20
  let g:coc_user_config['coc.source.word.filetypes'] = ['markdown', 'text', 'gitcommit']
  if exists('g:my_vim_config_dir')
    let g:coc_user_config['python.pythonPath'] = simplify(g:my_vim_config_dir . '/tools/python38/python.exe')
    let g:coc_user_config['clangd.path'] = simplify(g:my_vim_config_dir . '/tools/llvm/bin/clangd.exe')
    let g:coc_user_config['clangd.checkUpdates'] = v:false
    let g:coc_user_config['snippets.userSnippetsDirectory'] = simplify(g:my_vim_config_dir . '/snippets')
    let g:coc_user_config['snippets.textmateSnippetsRoots'] = [simplify(g:my_vim_config_dir . '/snippets/vscode')]
    let s:remark_server = simplify(g:my_vim_config_dir . '/tools/node/node_modules/remark-language-server/index.js')
    if filereadable(s:remark_server)
      let g:coc_user_config['languageserver'] = get(g:coc_user_config, 'languageserver', {})
      let g:coc_user_config['languageserver']['remark'] = {
            \ 'command': g:coc_node_path,
            \ 'args': [s:remark_server, '--stdio'],
            \ 'filetypes': ['markdown'],
            \ 'rootPatterns': ['.remarkrc', '.remarkrc.json', '.remarkrc.js', 'package.json', '.git'],
            \ 'settings': {'remark': {'requireConfig': v:false}},
            \ }
    endif
    unlet! s:remark_server
  endif

  function! CocShowDocumentation() abort
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      execute 'normal! K'
    endif
  endfunction
else
" =============== LSP: vim-lsp（Win7 兼容，C++ + Python）===============
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_preview_float = 1
let g:lsp_signature_help_enabled = 1
let g:lsp_document_code_action_signs_enabled = 1

function! s:clangd_cmd(server_info) abort
  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:cli = l:repo !=# '' ? simplify(l:repo . '/tools/llvm/bin/clangd') : 'clangd'
  return executable(l:cli) ? [l:cli] : ['clangd']
endfunction

function! s:pylsp_cmd(server_info) abort
  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:py = l:repo !=# '' ? simplify(l:repo . '/tools/python38/python.exe') : ''
  if l:py !=# '' && executable(l:py)
    return [l:py, '-m', 'pylsp']
  endif
  if executable('pylsp')
    return ['pylsp']
  endif
  return ['python', '-m', 'pylsp']
endfunction

" 前端三件套 LSP 配置（Node.js 12 兼容版 - Win7）
" 使用与 Node 12 兼容的旧版本语言服务器
function! s:html_langserver_cmd(server_info) abort
  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:node = l:repo !=# '' ? simplify(l:repo . '/tools/node/node.exe') : 'node'
  " Node 12 兼容: vscode-html-languageserver-bin@1.4.0 - htmlServerMain.js
  let l:server = l:repo !=# '' ? simplify(l:repo . '/tools/node/node_modules/vscode-html-languageserver-bin/htmlServerMain.js') : ''
  if !empty(l:server) && filereadable(l:server)
    return [l:node, l:server, '--stdio']
  endif
  if executable('vscode-html-languageserver')
    return ['vscode-html-languageserver', '--stdio']
  endif
  return []
endfunction

function! s:css_langserver_cmd(server_info) abort
  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:node = l:repo !=# '' ? simplify(l:repo . '/tools/node/node.exe') : 'node'
  " Node 12 兼容: vscode-css-languageserver-bin@1.4.0 - cssServerMain.js
  let l:server = l:repo !=# '' ? simplify(l:repo . '/tools/node/node_modules/vscode-css-languageserver-bin/cssServerMain.js') : ''
  if !empty(l:server) && filereadable(l:server)
    return [l:node, l:server, '--stdio']
  endif
  if executable('vscode-css-languageserver')
    return ['vscode-css-languageserver', '--stdio']
  endif
  return []
endfunction

function! s:typescript_langserver_cmd(server_info) abort
  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:node = l:repo !=# '' ? simplify(l:repo . '/tools/node/node.exe') : 'node'
  " Node 12 兼容: typescript-language-server@0.5.1
  let l:server = l:repo !=# '' ? simplify(l:repo . '/tools/node/node_modules/typescript-language-server/lib/cli.js') : ''
  if !empty(l:server) && filereadable(l:server)
    return [l:node, l:server, '--stdio']
  endif
  if executable('typescript-language-server')
    return ['typescript-language-server', '--stdio']
  endif
  return []
endfunction

function! s:cmake_langserver_cmd(server_info) abort
  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:py = l:repo !=# '' ? simplify(l:repo . '/tools/python38/python.exe') : ''
  if l:py !=# '' && executable(l:py)
    return [l:py, '-m', 'cmake_language_server']
  endif
  if executable('cmake-language-server')
    return ['cmake-language-server']
  endif
  return ['python', '-m', 'cmake_language_server']
endfunction

" =============== Asyncomplete（异步补全）===============
let g:asyncomplete_min_chars = 2
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
" 手动触发：Ctrl+Space；自动触发：输入 2 字符后；Tab/S-Tab 选择，Enter 确认

" =============== LSP: vim-lsp（Win7 兼容，C++ + Python + 前端三件套）===============
augroup myvim_vim_lsp
  autocmd!
  " C/C++
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': function('s:clangd_cmd'),
    \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })
  " Python
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'pylsp',
    \ 'cmd': function('s:pylsp_cmd'),
    \ 'allowlist': ['python'],
    \ })
  " HTML
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'html-languageserver',
    \ 'cmd': function('s:html_langserver_cmd'),
    \ 'allowlist': ['html', 'htm'],
    \ 'workspace_config': {'html': {'suggest': {}}},
    \ })
  " CSS/SCSS/LESS
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'css-languageserver',
    \ 'cmd': function('s:css_langserver_cmd'),
    \ 'allowlist': ['css', 'scss', 'sass', 'less'],
    \ 'workspace_config': {'css': {'lint': {}}},
    \ })
  " JavaScript/TypeScript
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'typescript-language-server',
    \ 'cmd': function('s:typescript_langserver_cmd'),
    \ 'allowlist': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
    \ 'workspace_config': {'javascript': {'suggest': {}}, 'typescript': {'suggest': {}}},
    \ })
  " CMake
  autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'cmake-language-server',
    \ 'cmd': function('s:cmake_langserver_cmd'),
    \ 'allowlist': ['cmake'],
    \ 'initialization_options': {
    \   'buildDirectory': 'build'
    \ }
    \ })
  " 设置 omnifunc
  autocmd FileType c,cpp,objc,objcpp,python,html,htm,css,scss,sass,less,javascript,javascriptreact,typescript,typescriptreact,cmake setlocal omnifunc=lsp#complete
augroup end
endif

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


" =============== UndoTree ===============
" 无需特殊配置

" =============== Tagbar 传统大纲（需要 ctags）===============
" 检测 ctags 路径
if executable('ctags')
  let g:tagbar_ctags_bin = 'ctags'
elseif filereadable(expand('~/my-vim/tools/ctags/ctags.exe'))
  let g:tagbar_ctags_bin = expand('~/my-vim/tools/ctags/ctags.exe')
else
  " ctags 未安装，Tagbar 将无法使用
  let g:tagbar_enabled = 0
endif

let g:tagbar_width = 35
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_show_linenumbers = 0
let g:tagbar_autoshowtag = 1
" 自定义图标
let g:tagbar_iconchars = ['▸', '◾']
" 快捷键
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" =============== Vista.vim 现代化大纲（推荐 - 使用 LSP）===============
if get(g:, 'myvim_lsp_engine', 'coc') ==# 'coc'
  let g:vista_default_executive = 'coc'
  let g:vista_executive_for = {
    \ 'c': 'coc',
    \ 'cpp': 'coc',
    \ 'python': 'coc',
    \ 'javascript': 'coc',
    \ 'typescript': 'coc',
    \ 'html': 'coc',
    \ 'css': 'coc',
    \ }
else
  let g:vista_default_executive = 'vim_lsp'
  let g:vista_executive_for = {
    \ 'c': 'vim_lsp',
    \ 'cpp': 'vim_lsp',
    \ 'python': 'vim_lsp',
    \ 'javascript': 'vim_lsp',
    \ 'typescript': 'vim_lsp',
    \ 'html': 'vim_lsp',
    \ 'css': 'vim_lsp',
    \ }
endif
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 40
let g:vista_echo_cursor = 1
let g:vista_cursor_delay = 400
let g:vista_update_on_text_changed = 1
let g:vista_update_on_text_changed_delay = 500
let g:vista_ignore_kinds = []
let g:vista_sidebar_position = 'vertical botright'
" 自动预览功能
let g:vista_blink = [2, 100]
let g:vista_top_level_blink = [2, 100]
" 图标配置
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\   "class": "\uf0e8",
\   "method": "\uf6a6",
\   "namespace": "\uf0c1",
\   }
" 快捷键
nnoremap <silent> <Leader>v :Vista!!<CR>
nnoremap <silent> <Leader>vf :Vista finder<CR>
" 自动在特定文件类型打开（F8 已禁用，使用 Space+v 或 Space+vv）
" autocmd FileType c,cpp,python,javascript,typescript,vim nnoremap <buffer> <F8> :Vista!!<CR>

" =============== EasyAlign ===============
" 无需特殊配置

" =============== EasyMotion ===============
if exists('g:loaded_easymotion')
  " 禁用默认映射
  let g:EasyMotion_do_mapping = 0
  " 智能大小写（输入小写时忽略大小写，输入大写时精确匹配）
  let g:EasyMotion_smartcase = 1
  " 使用大写字母作为跳转标记（更容易看清）
  let g:EasyMotion_use_upper = 1
  " 跳转后将光标置于屏幕中央
  let g:EasyMotion_landing_highlight = 1
  " 使用更明显的高亮颜色
  let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
  " 搜索时跨窗口
  let g:EasyMotion_use_smartsign_us = 1
endif

" =============== FZF ===============
" fzf 安装在 data/fzf（junegunn/fzf 的 dir 选项），二进制在 data/fzf/bin/fzf.exe
" 预览窗口需 bash；若无 Git Bash，预览不可用，但文件搜索等基础功能正常
if get(g:, 'myvim_use_fzf', 1) && (has('win32') || has('win64'))
  let g:fzf_preview_window = 'right:50%'
  let g:fzf_layout = { 'down': '40%' }
  " 优先使用项目内的 bash（便携 Git 的 bash），否则 fzf.vim 会找 C:\Program Files\Git\bin\bash.exe
  if exists('g:my_vim_config_dir')
    let s:fzf_bash = simplify(g:my_vim_config_dir . '/tools/git/bin/bash.exe')
    if executable(s:fzf_bash)
      let g:fzf_preview_bash = s:fzf_bash
    endif
  endif
  " ripgrep 作为文件列表源（tools/ripgrep 或 PATH）
  if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  endif
endif

function! s:MyVimUseFzfCommand(name) abort
  return get(g:, 'myvim_use_fzf', 1) && exists(':' . a:name) == 2
endfunction

function! s:MyVimFiles() abort
  if s:MyVimUseFzfCommand('Files')
    Files
  else
    edit .
  endif
endfunction

function! s:MyVimGrep(...) abort
  let l:query = a:0 ? a:1 : input('Search: ')
  if empty(l:query)
    return
  endif
  if s:MyVimUseFzfCommand('Rg')
    execute 'Rg ' . l:query
  else
    execute 'vimgrep /' . escape(l:query, '/\') . '/gj **/*'
    copen
  endif
endfunction

function! s:MyVimBuffers() abort
  if s:MyVimUseFzfCommand('Buffers')
    Buffers
  else
    ls
  endif
endfunction

function! s:MyVimHistory() abort
  if s:MyVimUseFzfCommand('History')
    History
  else
    oldfiles
  endif
endfunction

function! s:MyVimCommandHistory() abort
  if s:MyVimUseFzfCommand('History')
    History:
  else
    history :
  endif
endfunction

function! s:MyVimMarks() abort
  if s:MyVimUseFzfCommand('Marks')
    Marks
  else
    marks
  endif
endfunction

function! s:MyVimWindows() abort
  if s:MyVimUseFzfCommand('Windows')
    Windows
  else
    echo '窗口列表: 使用 <C-w>w 切换窗口'
  endif
endfunction

function! s:MyVimHelptags() abort
  if s:MyVimUseFzfCommand('Helptags')
    Helptags
  else
    help
  endif
endfunction

command! MyVimFiles call s:MyVimFiles()
command! -nargs=? MyVimGrep call s:MyVimGrep(<q-args>)
command! MyVimBuffers call s:MyVimBuffers()
command! MyVimHistory call s:MyVimHistory()
command! MyVimCommandHistory call s:MyVimCommandHistory()
command! MyVimMarks call s:MyVimMarks()
command! MyVimWindows call s:MyVimWindows()
command! MyVimHelptags call s:MyVimHelptags()

" =============== GitGutter（已禁用，需要 git）===============
" 使用默认配置

" =============== Vimspector ===============
" Python 路径：优先便携 tools/python38，否则用环境变量 VIMSPECTOR_PYTHON，最后用 PATH 的 python
if !exists('g:vimspector_configuration_variables')
  let g:vimspector_configuration_variables = {}
endif
let s:py = ''
if exists('g:myvim_data_dir')
  let s:tools_py = simplify(g:myvim_data_dir . '/../tools/python38/python.exe')
  if filereadable(s:tools_py)
    let s:py = s:tools_py
  endif
endif
if s:py == '' && $VIMSPECTOR_PYTHON != ''
  let s:py = $VIMSPECTOR_PYTHON
endif
if s:py != ''
  let g:vimspector_configuration_variables['PythonPath'] = s:py
endif
unlet s:py

" C/C++ 调试器路径：优先使用仓库内置 MinGW GDB / LLVM LLDB。
if exists('g:my_vim_config_dir')
  let s:gdb = simplify(g:my_vim_config_dir . '/tools/mingw64/bin/gdb.exe')
  if executable(s:gdb)
    let g:vimspector_configuration_variables['GdbPath'] = s:gdb
  endif

  let s:lldb_dap = simplify(g:my_vim_config_dir . '/tools/llvm/bin/lldb-dap.exe')
  if executable(s:lldb_dap)
    let g:vimspector_configuration_variables['LldbDapPath'] = s:lldb_dap
  endif

  let g:vimspector_configuration_variables['CppProgram'] = simplify(getcwd() . '/a.out')
endif
unlet! s:gdb s:lldb_dap

" 便携/离线：将 Vimspector gadgets/配置固定到仓库 data/ 下
if exists('g:myvim_data_dir')
      let g:vimspector_base_dir = simplify(g:myvim_data_dir . '/vimspector')
      if !isdirectory(g:vimspector_base_dir)
            call mkdir(g:vimspector_base_dir, 'p')
      endif
endif

command! MyVimDebugInstall VimspectorInstall debugpy vscode-cpptools CodeLLDB

function! s:MyVimDebugBuildCurrent() abort
  let l:src = expand('%:p')
  if empty(l:src) || !filereadable(l:src)
    echohl ErrorMsg
    echo '调试构建失败: 当前缓冲区不是已保存的 C/C++ 文件'
    echohl None
    return ''
  endif

  let l:ext = tolower(expand('%:e'))
  let l:is_cpp = index(['cc', 'cpp', 'cxx', 'c++'], l:ext) >= 0
  let l:is_c = l:ext ==# 'c'
  if !l:is_c && !l:is_cpp
    echohl ErrorMsg
    echo '调试构建失败: 仅支持 C/C++ 文件'
    echohl None
    return ''
  endif

  if &modified
    silent write
  endif

  let l:repo = get(g:, 'my_vim_config_dir', '')
  let l:compiler = ''
  if l:repo !=# ''
    let l:compiler = simplify(l:repo . (l:is_cpp ? '/tools/mingw64/bin/g++.exe' : '/tools/mingw64/bin/gcc.exe'))
  endif
  if empty(l:compiler) || !executable(l:compiler)
    let l:compiler = l:is_cpp ? 'g++' : 'gcc'
  endif

  let l:outdir = simplify(getcwd() . '/.vim-debug')
  if !isdirectory(l:outdir)
    call mkdir(l:outdir, 'p')
  endif
  let l:out = simplify(l:outdir . '/' . expand('%:t:r') . '.exe')

  let l:cmd = shellescape(l:compiler)
        \ . ' -g -O0 -Wall '
        \ . (l:is_cpp ? '-std=c++17 ' : '-std=c11 ')
        \ . shellescape(l:src)
        \ . ' -o ' . shellescape(l:out)
  if &shell =~? 'powershell\|pwsh'
    let l:cmd = '& ' . l:cmd
  endif

  echo '正在构建调试目标: ' . l:out
  let l:output = system(l:cmd)
  if v:shell_error != 0
    echohl ErrorMsg
    echo '调试构建失败:'
    echo l:output
    echohl None
    return ''
  endif

  let g:vimspector_configuration_variables['CppProgram'] = l:out
  echo '调试目标: ' . l:out
  return l:out
endfunction

function! s:MyVimDebugCurrent() abort
  let l:ft = &filetype
  if l:ft ==# 'python'
    call vimspector#LaunchWithSettings({'configuration': 'Python - Launch Current File'})
    return
  endif

  if index(['c', 'cpp', 'cc', 'cxx'], l:ft) >= 0 || index(['c', 'cc', 'cpp', 'cxx', 'c++'], tolower(expand('%:e'))) >= 0
    let l:program = s:MyVimDebugBuildCurrent()
    if empty(l:program)
      return
    endif
    let l:config = tolower(expand('%:e')) ==# 'c' ? 'C - Launch' : 'C++ - Launch'
    call vimspector#LaunchWithSettings({'configuration': l:config})
    return
  endif

  echohl WarningMsg
  echo '当前文件类型没有自动调试配置，改用 Vimspector 默认选择。'
  echohl None
  call vimspector#Continue()
endfunction

command! MyVimDebugBuildCurrent call s:MyVimDebugBuildCurrent()
command! MyVimDebugCurrent call s:MyVimDebugCurrent()

function! s:MyVimDebugStatus() abort
  echo 'Vimspector base: ' . get(g:, 'vimspector_base_dir', '<default>')
  echo 'Python: ' . get(g:vimspector_configuration_variables, 'PythonPath', '<PATH python>')
  echo 'GDB: ' . get(g:vimspector_configuration_variables, 'GdbPath', '<PATH gdb>')
  echo 'LLDB DAP: ' . get(g:vimspector_configuration_variables, 'LldbDapPath', '<PATH lldb-dap>')
  echo 'C/C++ program: ' . get(g:vimspector_configuration_variables, 'CppProgram', '<workspace>/a.out')
  echo 'Install/update adapters: :MyVimDebugInstall'
endfunction
command! MyVimDebugStatus call s:MyVimDebugStatus()

" 使用自定义映射：保留 Leader 键，并显式启用常用 F* 调试键。
let g:vimspector_enable_mappings = ''

" UI 配置
let g:vimspector_sidebar_width = 60
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 75

" 常用 F* 调试键
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
nnoremap <leader>dd :MyVimDebugCurrent<CR>
nnoremap <leader>dm :MyVimDebugBuildCurrent<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>
nnoremap <leader>ds :call vimspector#Stop()<CR>
nnoremap <leader>dr :call vimspector#Restart()<CR>
nnoremap <leader>dp :call vimspector#Pause()<CR>
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dB :call vimspector#AddFunctionBreakpoint()<CR>
nnoremap <leader>dD :call vimspector#ClearBreakpoints()<CR>
nnoremap <leader>dn :call vimspector#StepOver()<CR>
nnoremap <leader>di :call vimspector#StepInto()<CR>
nnoremap <leader>do :call vimspector#StepOut()<CR>
nnoremap <leader>dO :call vimspector#StepOut()<CR>
nnoremap <leader>dt :call vimspector#RunToCursor()<CR>
nnoremap <leader>du :call vimspector#ToggleUI()<CR>
nnoremap <leader>dR :call vimspector#Reset()<CR>

" =============== CMake ===============
" 使用默认配置

" =============== Vim-Translator 离线翻译 ===============
" Python 路径配置（vim-translator 需要 Python）
if exists('g:my_vim_config_dir')
  let s:python3_path = g:my_vim_config_dir . '/tools/python38/python.exe'
  if filereadable(s:python3_path)
    " 设置 Python3 路径供 vim-translator 使用
    let g:python3_host_prog = s:python3_path
    let g:myvim_sdcv_python = s:python3_path
    " 将 Python 添加到 PATH
    let $PATH = g:my_vim_config_dir . '/tools/python38;' . $PATH
  endif
  
  " 设置词典目录
  let $STARDICT_DATA_DIR = g:my_vim_config_dir . '/tools/stardict/dic'
  let $PYTHONIOENCODING = 'utf-8'
  let g:myvim_sdcv_script = g:my_vim_config_dir . '/tools/sdcv/sdcv_python.py'
  " 将 sdcv 目录添加到 PATH（支持 sdcv.exe 或 sdcv.bat）
  let $PATH = g:my_vim_config_dir . '/tools/sdcv;' . $PATH
endif

" 离线翻译配置
let g:translator_default_engines = ['sdcv']  " 使用 sdcv 离线引擎
let g:translator_target_lang = 'zh'
let g:translator_source_lang = 'auto'

" 翻译窗口配置（优先使用 popup 悬浮窗口）
let g:translator_window_type = 'popup'
let g:translator_window_max_width = 0.6
let g:translator_window_max_height = 0.6
let g:translator_history_enable = v:true

" vim-translator 在线/外部引擎入口保留为大写，避免默认离线翻译触发插件异常。
nmap <Leader>tW <Plug>Translate
vmap <Leader>tW <Plug>TranslateV
nmap <silent> <Leader>tT <Plug>TranslateW
vmap <silent> <Leader>tT <Plug>TranslateWV
nmap <silent> <Leader>tR <Plug>TranslateR
vmap <silent> <Leader>tR <Plug>TranslateRV

" 如果 vim-translator 无法工作，使用备用翻译功能
" 直接调用本仓库离线词典脚本
function! MyVimVisualText() abort
  let l:save_reg = getreg('"')
  let l:save_type = getregtype('"')
  silent normal! gvy
  let l:text = getreg('"')
  call setreg('"', l:save_reg, l:save_type)
  return substitute(l:text, '\_s\+', ' ', 'g')
endfunction

function! s:MyVimDecodeSystemOutput(text) abort
  if has('win32') || has('win64')
    let l:decoded = iconv(a:text, 'cp936', &encoding)
    if !empty(l:decoded)
      return l:decoded
    endif
  endif
  return a:text
endfunction

function! SimpleTranslate(...) abort
  " 获取查询文本和翻译方向：auto / en_zh / zh_en
  let l:direction = 'auto'
  if a:0 >= 2
    let word = a:1
    let l:direction = a:2
  elseif a:0 == 1 && index(['auto', 'en_zh', 'zh_en'], a:1) >= 0
    let word = expand('<cword>')
    let l:direction = a:1
  else
    let word = a:0 ? a:1 : expand('<cword>')
  endif
  if empty(word)
    echohl ErrorMsg
    echo "错误: 没有找到要翻译的文本"
    echohl None
    return
  endif
  
  " 显示翻译中的提示
  echo "正在翻译: " . word . "..."
  redraw
  
  let l:py = get(g:, 'myvim_sdcv_python', 'python')
  let l:script = get(g:, 'myvim_sdcv_script', '')
  if empty(l:script) || !filereadable(l:script)
    echohl ErrorMsg
    echo "翻译失败: 未找到 sdcv_python.py"
    echohl None
    return
  endif

  " 调用本地 Python 词典脚本，避开 Windows/PowerShell 下 .bat 与编码问题。
  let l:args = l:direction ==# 'zh_en' ? ' --reverse ' : ' '
  let cmd = shellescape(l:py) . ' ' . shellescape(l:script) . l:args . shellescape(word)
  if &shell =~? 'powershell\|pwsh'
    let cmd = '& ' . cmd
  endif
  let result = s:MyVimDecodeSystemOutput(system(cmd))
  
  " 检查是否有错误
  if v:shell_error != 0
    echohl ErrorMsg
    echo "翻译失败: 离线词典脚本执行错误"
    echo "请检查: :MyVimTranslateStatus"
    echohl None
    return
  endif
  
  " 检查结果是否为空
  if empty(result) || result =~# '^未找到'
    echohl WarningMsg
    echo "未找到翻译: " . word
    echohl None
    return
  endif
  
  " 在悬浮窗口显示结果；旧版 Vim 不支持 popup 时回退到预览窗口。
  let l:lines = split(result, '\n')
  if exists('*popup_create')
    if exists('g:myvim_translate_popup') && g:myvim_translate_popup > 0
      silent! call popup_close(g:myvim_translate_popup)
    endif
    let g:myvim_translate_popup = popup_create(l:lines, {
          \ 'title': ' 离线翻译: ' . word . ' ',
          \ 'pos': 'botleft',
          \ 'line': 'cursor+1',
          \ 'col': 'cursor',
          \ 'minwidth': 40,
          \ 'maxwidth': float2nr(&columns * 0.6),
          \ 'maxheight': float2nr(&lines * 0.6),
          \ 'padding': [0, 1, 0, 1],
          \ 'border': [],
          \ 'wrap': v:true,
          \ 'close': 'click',
          \ 'filter': 'popup_filter_menu',
          \ })
    echohl MoreMsg
    echo "翻译完成: " . word
    echohl None
    return
  endif

  silent! pclose  " 关闭已有的预览窗口
  pedit __Translation__
  
  " 跳转到预览窗口并设置内容
  wincmd P
  if &previewwindow
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nobuflisted
    setlocal wrap
    setlocal linebreak
    setlocal filetype=text
    
    " 清空并写入结果
    silent %delete _
    call setline(1, l:lines)
    
    " 回到原窗口
    wincmd p
    
    echohl MoreMsg
    echo "翻译完成: " . word
    echohl None
  else
    echohl ErrorMsg
    echo "无法打开预览窗口"
    echohl None
  endif
endfunction

function! s:MyVimTranslateQuery(text, direction) abort
  let l:py = get(g:, 'myvim_sdcv_python', 'python')
  let l:script = get(g:, 'myvim_sdcv_script', '')
  if empty(l:script) || !filereadable(l:script)
    throw '未找到 sdcv_python.py'
  endif

  let l:args = a:direction ==# 'zh_en' ? ' --reverse ' : ' '
  let l:cmd = shellescape(l:py) . ' ' . shellescape(l:script) . l:args . shellescape(a:text)
  if &shell =~? 'powershell\|pwsh'
    let l:cmd = '& ' . l:cmd
  endif
  let l:result = s:MyVimDecodeSystemOutput(system(l:cmd))
  if v:shell_error != 0 || empty(l:result) || l:result =~# '^未找到'
    throw '未找到翻译: ' . a:text
  endif
  return l:result
endfunction

function! s:MyVimTranslateReplacement(result, direction) abort
  for l:line in split(a:result, '\n')
    let l:line = trim(l:line)
    if empty(l:line) || l:line =~# '^-->'
      continue
    endif

    " 中译英反查输出格式为: english<Tab>中文释义，替换时取英文候选。
    if a:direction ==# 'zh_en'
      return split(l:line, "\t")[0]
    endif

    " 英译中时跳过音标/词频行，尽量取第一条中文释义。
    if l:line =~# '[^ -~]' && l:line !~# '^\*' && l:line !~# '^[（(]'
      let l:line = substitute(l:line, '^\a\+\.\s*', '', '')
      return l:line
    endif
  endfor
  return ''
endfunction

function! s:MyVimTranslateDirection(text, direction) abort
  if a:direction !=# 'auto'
    return a:direction
  endif
  return a:text =~# '[^ -~]' ? 'zh_en' : 'en_zh'
endfunction

function! s:MyVimReplaceVisualSelection(text) abort
  let l:start = getpos("'<")
  let l:end = getpos("'>")
  let l:start_lnum = l:start[1]
  let l:end_lnum = l:end[1]
  let l:start_col = l:start[2]
  let l:end_col = l:end[2]

  if l:start_lnum <= 0 || l:end_lnum <= 0
    throw '没有可替换的选区'
  endif

  if l:start_lnum > l:end_lnum || (l:start_lnum == l:end_lnum && l:start_col > l:end_col)
    let [l:start_lnum, l:end_lnum] = [l:end_lnum, l:start_lnum]
    let [l:start_col, l:end_col] = [l:end_col, l:start_col]
  endif

  let l:before = strpart(getline(l:start_lnum), 0, l:start_col - 1)
  let l:after = strpart(getline(l:end_lnum), l:end_col)
  let l:replacement = split(a:text, "\n", 1)
  if empty(l:replacement)
    let l:replacement = ['']
  endif

  if len(l:replacement) == 1
    let l:new_lines = [l:before . l:replacement[0] . l:after]
  else
    let l:new_lines = [l:before . l:replacement[0]]
          \ + l:replacement[1:-2]
          \ + [l:replacement[-1] . l:after]
  endif

  call setline(l:start_lnum, l:new_lines[0])
  if l:end_lnum > l:start_lnum
    execute (l:start_lnum + 1) . ',' . l:end_lnum . 'delete _'
  endif
  if len(l:new_lines) > 1
    call append(l:start_lnum, l:new_lines[1:])
  endif
endfunction

function! SimpleTranslateReplace(...) abort
  let l:text = a:0 ? a:1 : MyVimVisualText()
  let l:direction = a:0 >= 2 ? a:2 : 'auto'
  if empty(l:text)
    echohl ErrorMsg
    echo '错误: 没有找到要替换的文本'
    echohl None
    return
  endif

  try
    let l:direction = s:MyVimTranslateDirection(l:text, l:direction)
    let l:result = s:MyVimTranslateQuery(l:text, l:direction)
    let l:replacement = s:MyVimTranslateReplacement(l:result, l:direction)
    if empty(l:replacement)
      throw '没有可用于替换的短翻译'
    endif
    call s:MyVimReplaceVisualSelection(l:replacement)
    echohl MoreMsg
    echo '已替换为: ' . l:replacement
    echohl None
  catch
    echohl ErrorMsg
    echo '替换失败: ' . v:exception
    echohl None
  endtry
endfunction

" 添加备用命令和快捷键
command! -nargs=0 SimpleTranslate call SimpleTranslate()
command! -nargs=1 TransWord call SimpleTranslate(<q-args>)
nnoremap <silent> <Leader>tw :call SimpleTranslate()<CR>
xnoremap <silent> <Leader>tw :<C-u>call SimpleTranslate(MyVimVisualText())<CR>
nnoremap <silent> <Leader>tt :call SimpleTranslate()<CR>
xnoremap <silent> <Leader>tt :<C-u>call SimpleTranslate(MyVimVisualText())<CR>
nnoremap <silent> <Leader>ts :call SimpleTranslate()<CR>
nnoremap <silent> <Leader>tZ :call SimpleTranslate('en_zh')<CR>
xnoremap <silent> <Leader>tZ :<C-u>call SimpleTranslate(MyVimVisualText(), 'en_zh')<CR>
nnoremap <silent> <Leader>tE :call SimpleTranslate('zh_en')<CR>
xnoremap <silent> <Leader>tE :<C-u>call SimpleTranslate(MyVimVisualText(), 'zh_en')<CR>
xnoremap <silent> <Leader>tr :<C-u>call SimpleTranslateReplace(MyVimVisualText(), 'auto')<CR>

function! s:MyVimTranslateStatus() abort
  echo 'Python: ' . get(g:, 'myvim_sdcv_python', '<PATH python>')
  echo 'Script: ' . get(g:, 'myvim_sdcv_script', '<missing>')
  echo 'Dict dir: ' . $STARDICT_DATA_DIR
  echo 'Python UTF-8: ' . $PYTHONIOENCODING
endfunction
command! MyVimTranslateStatus call s:MyVimTranslateStatus()

" =============== vim-dict（词典补全，不是翻译） ===============
" 把插件自带 dict 目录加入补全来源（安装插件后目录才会存在）。
" 用法：Insert 模式下 <C-x><C-k> 触发字典补全。
if exists('g:myvim_data_dir')
      let s:vim_dict_repo = myvim#path#join(g:myvim_data_dir, 'plugged', 'vim-dict', 'dict')
elseif exists('g:my_vim_config_dir')
      let s:vim_dict_repo = myvim#path#join(g:my_vim_config_dir, 'plugged', 'vim-dict', 'dict')
else
      let s:vim_dict_repo = ''
endif
if !empty(s:vim_dict_repo) && isdirectory(s:vim_dict_repo)
      let g:vim_dict_dict = get(g:, 'vim_dict_dict', []) + [s:vim_dict_repo]
endif

" =============== snipMate 代码片段 ===============
" 触发键：Tab 展开代码片段
" 自动处理与补全菜单的冲突
let g:snipMate = { 'snippet_version' : 1 }
let g:snipMate.always_choose_first = 0
let g:snipMate.description_in_completion = 1

" 代码片段搜索路径：snipMate 会在 runtimepath 的每个目录下查找 snippets/ 子目录
" 确保项目根目录在 runtimepath 中
if exists('g:my_vim_config_dir')
  let s:snippets_dir = simplify(g:my_vim_config_dir . '/snippets')
  if isdirectory(s:snippets_dir)
    " 确保项目根目录在 runtimepath 中
    let s:project_in_rtp = 0
    for s:path in split(&runtimepath, ',')
      if simplify(s:path) ==# g:my_vim_config_dir
        let s:project_in_rtp = 1
        break
      endif
    endfor
    if !s:project_in_rtp
      execute 'set runtimepath^=' . fnameescape(g:my_vim_config_dir)
    endif
  endif
endif

" 快捷键：编辑当前文件类型的代码片段
" 在 snippets/ 目录下创建或编辑 <filetype>.snippets 文件
nnoremap <leader>se :split<CR>:e ~/my-vim/snippets/<C-R>=&filetype<CR>.snippets<CR>

" snipMate 不需要 Python，直接使用 VimL

" 将 snipMate 代码片段集成到 asyncomplete 补全菜单
function! s:snipmate_completor(opt, ctx) abort
  let l:col = a:ctx['col']
  let l:typed = a:ctx['typed']
  
  let l:kw = matchstr(l:typed, '\v\w+$')
  let l:kwlen = len(l:kw)
  let l:startcol = l:col - l:kwlen
  
  " 获取当前文件类型的代码片段
  let l:snippets = snipMate#GetSnippets()
  let l:matches = []
  
  for [l:trigger, l:snippet] in items(l:snippets)
    if l:trigger =~# '^' . l:kw
      " 提取第一行作为描述
      let l:lines = split(l:snippet, "\n")
      let l:desc = get(l:lines, 0, '')
      call add(l:matches, {
        \ 'word': l:trigger,
        \ 'abbr': l:trigger,
        \ 'menu': '[snippet]',
        \ 'info': l:desc,
        \ 'kind': 's',
        \ })
    endif
  endfor
  
  call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol, l:matches)
endfunction

augroup asyncomplete_snipmate
  autocmd!
  autocmd User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'snipmate',
    \ 'allowlist': ['*'],
    \ 'completor': function('s:snipmate_completor'),
    \ })
augroup END

" =============== 数据库支持 (vim-dadbod) ===============
" 数据库 UI 快捷键
nnoremap <leader>Du :DBUIToggle<CR>
nnoremap <leader>Da :DBUIAddConnection<CR>
nnoremap <leader>Df :DBUIFindBuffer<CR>
nnoremap <leader>Dr :DBUIRenameBuffer<CR>
nnoremap <leader>Dl :DBUILastQueryInfo<CR>

" 数据库 UI 配置
let g:db_ui_use_nerdtree = 0
let g:db_ui_show_database_icon = 1
let g:db_ui_force_echo_notifications = 1
let g:db_ui_win_position = 'left'

" =============== Markdown 编辑增强 ===============
" vim-markdown 配置
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_level = 2
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'js=javascript', 'py=python']
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_auto_insert_bullets = 1

" vim-table-mode 表格编辑
let g:table_mode_corner='|'
let g:table_mode_auto_align = 1
" 快捷键：<Leader>tm 切换表格模式
" 在表格模式下，|| 自动创建表格

" bullets.vim 列表自动化
let g:bullets_enabled_file_types = ['markdown', 'text', 'gitcommit']
let g:bullets_enable_in_empty_buffers = 0
let g:bullets_set_mappings = 0  " 禁用自动映射，避免回车键冲突
let g:bullets_nested_checkboxes = 1
let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std-']
" 如需列表功能，可以用 o 键（在普通模式下）创建新列表项

" markdown-preview 实时预览
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle'
    \ }

function! s:html_preview_state_file() abort
  if exists('g:myvim_data_dir')
    let l:dir = simplify(g:myvim_data_dir . '/html-preview')
  elseif exists('g:my_vim_config_dir')
    let l:dir = simplify(g:my_vim_config_dir . '/data/html-preview')
  else
    let l:dir = simplify(fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/../data/html-preview')
  endif
  call mkdir(l:dir, 'p')
  return simplify(l:dir . '/state.json')
endfunction

function! s:html_preview_python() abort
  if exists('g:my_vim_config_dir')
    let l:pythonw = simplify(g:my_vim_config_dir . '/tools/python38/pythonw.exe')
    if executable(l:pythonw)
      return l:pythonw
    endif
    let l:python = simplify(g:my_vim_config_dir . '/tools/python38/python.exe')
    if executable(l:python)
      return l:python
    endif
  endif
  return executable('pythonw') ? 'pythonw' : 'python'
endfunction

function! s:html_preview_script() abort
  if exists('g:my_vim_config_dir')
    return simplify(g:my_vim_config_dir . '/scripts/windows/html_live_preview.py')
  endif
  return simplify(fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/../scripts/windows/html_live_preview.py')
endfunction

function! s:html_preview_read_state() abort
  let l:state_file = s:html_preview_state_file()
  if !filereadable(l:state_file)
    return {}
  endif
  let l:raw = join(readfile(l:state_file), "\n")
  if exists('*json_decode')
    try
      let l:state = json_decode(l:raw)
      if type(l:state) == type({})
        return l:state
      endif
    catch
    endtry
  endif
  return {}
endfunction

function! s:html_preview_wait_for_state(timeout_ms) abort
  let l:deadline = reltimefloat(reltime()) + (a:timeout_ms / 1000.0)
  while reltimefloat(reltime()) < l:deadline
    let l:state = s:html_preview_read_state()
    if !empty(l:state)
      return l:state
    endif
    sleep 50m
  endwhile
  return {}
endfunction

function! s:html_preview_stop() abort
  let l:state = s:html_preview_read_state()
  let l:state_file = s:html_preview_state_file()
  if empty(l:state) || !has_key(l:state, 'pid')
    if filereadable(l:state_file)
      call delete(l:state_file)
    endif
    echom 'HTML 预览未运行。'
    return
  endif
  if has('win32') || has('win64')
    call system('taskkill /PID ' . l:state.pid . ' /T /F >NUL 2>&1')
  else
    call system('kill ' . l:state.pid . ' >/dev/null 2>&1')
  endif
  if filereadable(l:state_file)
    call delete(l:state_file)
  endif
  echom 'HTML 预览已停止。'
endfunction

function! s:html_preview_start() abort
  let l:file = expand('%:p')
  if empty(l:file) || !filereadable(l:file)
    echohl WarningMsg
    echom 'HTML 预览需要先保存当前 HTML 文件。'
    echohl None
    return
  endif
  if index(['html', 'htm'], &filetype) < 0 && expand('%:e') !~? '^html\?$'
    echohl WarningMsg
    echom 'HTML 预览仅支持 .html / .htm 文件。'
    echohl None
    return
  endif
  let l:script = s:html_preview_script()
  if !filereadable(l:script)
    echohl ErrorMsg
    echom 'HTML 预览脚本缺失: ' . l:script
    echohl None
    return
  endif
  let l:python = s:html_preview_python()
  let l:state_file = s:html_preview_state_file()
  let l:existing_state = s:html_preview_read_state()
  if !empty(l:existing_state) && has_key(l:existing_state, 'pid')
    call s:html_preview_stop()
  endif
  call delete(l:state_file)
  let l:cmd = shellescape(l:python)
        \ . ' ' . shellescape(l:script)
        \ . ' --file ' . shellescape(l:file)
        \ . ' --state ' . shellescape(l:state_file)
  if has('win32') || has('win64')
    call system('cmd /c start "" /B ' . l:cmd)
  elseif exists('*job_start')
    call job_start([l:python, l:script, '--file', l:file, '--state', l:state_file], {'out_io': 'null', 'err_io': 'null'})
  else
    call system(l:cmd . ' >/dev/null 2>&1 &')
  endif
  let l:state = s:html_preview_wait_for_state(2000)
  if empty(l:state)
    echohl ErrorMsg
    echom 'HTML 预览启动失败，请检查 Python 环境。'
    echohl None
    return
  endif
  echom 'HTML 预览已启动: ' . get(l:state, 'url', '')
endfunction

function! s:html_preview_toggle() abort
  let l:state = s:html_preview_read_state()
  if !empty(l:state) && has_key(l:state, 'pid')
    call s:html_preview_stop()
  else
    call s:html_preview_start()
  endif
endfunction

command! HtmlPreviewStart call <SID>html_preview_start()
command! HtmlPreviewStop call <SID>html_preview_stop()
command! HtmlPreviewToggle call <SID>html_preview_toggle()

" Markdown 快捷键
augroup markdown_mappings
  autocmd!
  autocmd FileType markdown nnoremap <buffer> <leader>mp :MarkdownPreview<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>ms :MarkdownPreviewStop<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>mt :MarkdownPreviewToggle<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>tm :TableModeToggle<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>ta :TableModeRealign<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>mo :GenTocGFM<CR>
augroup END
let g:db_ui_winwidth = 30

" 数据库补全集成到 asyncomplete
if exists('*asyncomplete#register_source')
  autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#dadbod#get_source_options())
endif

" =============== 前端开发插件配置 ===============

" Emmet - HTML/CSS 快速编写（<leader>E 触发）
let g:user_emmet_leader_key='<leader>E'
let g:user_emmet_mode='inv'  " 在 insert, normal, visual 模式都可用
let g:user_emmet_install_global = 0
augroup EmmetSettings
  autocmd!
  autocmd FileType html,css,javascript,javascriptreact,typescript,typescriptreact EmmetInstall
augroup END

" vim-closetag - 自动闭合 HTML/XML 标签
let g:closetag_filenames = '*.html,*.htm,*.xml,*.jsx,*.tsx,*.vue,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,htm,xml,javascript.jsx,typescript.tsx,vue'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" MatchTagAlways - 高亮匹配的 HTML 标签
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'javascript.jsx': 1,
    \ 'typescript.tsx': 1,
    \ 'javascriptreact': 1,
    \ 'typescriptreact': 1,
    \ }

" =============== Startify 启动页 ===============
" 会话文件保存在当前配置目录下（跨平台兼容）
if exists('g:my_vim_config_dir')
      if exists('g:myvim_data_dir')
                  let g:startify_session_dir = myvim#path#join(g:myvim_data_dir, 'sessions')
      else
                  let g:startify_session_dir = myvim#path#join(g:my_vim_config_dir, 'sessions')
      endif
else
  " 回退到当前脚本目录
      let g:startify_session_dir = myvim#path#join(fnamemodify(resolve(expand('<sfile>')), ':p:h'), 'sessions')
endif
call myvim#path#ensure_dir(g:startify_session_dir)
let g:startify_lists = [
\ { 'type': 'files',     'header': ['   最近文件']            },
\ { 'type': 'dir',       'header': ['   当前目录 '. getcwd()] },
\ { 'type': 'sessions',  'header': ['   会话']                },
\ { 'type': 'bookmarks', 'header': ['   书签']                },
\ { 'type': 'commands',  'header': ['   命令']                },
\ ]

let g:startify_bookmarks = [
\ { 'v': exists('g:my_vim_config_dir') ? g:my_vim_config_dir . '/_vimrc' : '~/_vimrc' },
\ { 'p': exists('g:my_vim_config_dir') ? g:my_vim_config_dir . '/config/plugins.vim' : '~/.vim/plugins.vim' },
\ { 's': exists('g:my_vim_config_dir') ? g:my_vim_config_dir . '/config/settings.vim' : '~/.vim/settings.vim' },
\ { 'k': exists('g:my_vim_config_dir') ? g:my_vim_config_dir . '/config/keymaps.vim' : '~/.vim/keymaps.vim' },
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

" 启动时默认不自动加载会话，避免恢复上次分屏/侧栏布局。
" 如需自动加载，把它改回 1。
let g:startify_session_autoload = 0
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 3
let g:startify_session_delete_buffers = 1
let g:startify_change_to_dir = 1
let g:startify_enable_special = 0

augroup MyVimStartifySingleWindow
      autocmd!
      " Startify 显示后，如果出现多窗口（例如右侧空白分屏），则只保留启动页窗口。
      autocmd User Startified if winnr('$') > 1 | silent! only | endif
augroup END

" 启动时如果出现额外分屏（例如右侧空窗口），在 Startify 就绪后自动收拢为单窗口。
function! s:StartifySingleWindow() abort
      if winnr('$') <= 1
            return
      endif
      for l:win in range(1, winnr('$'))
            if getbufvar(winbufnr(l:win), '&filetype') ==# 'startify'
                  execute l:win . 'wincmd w'
                  silent! only
                  return
            endif
      endfor
endfunction

augroup MyVimStartifyWindow
      autocmd!
      autocmd User Startified call s:StartifySingleWindow()
augroup END

" =============== Which-Key ===============
" 使用 vim-which-key (Vim 兼容版本)
" 配置选项
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}
let g:which_key_fallback_to_native_key = 1
let g:which_key_position = 'botright'
let g:which_key_run_map_on_popup = 0  " 禁止自动弹出

" 限制弹出窗口的大小
let g:which_key_max_size = 0          " 0 = 自动，或设置具体数字限制显示项数
let g:which_key_vertical = 0          " 0 = 水平布局（底部）, 1 = 垂直布局（侧边）
let g:which_key_centered = 0          " 0 = 不居中, 1 = 居中显示

" 设置弹出窗口的最大高度（行数）
" 如果菜单项太多，会显示滚动提示
let g:which_key_floating_opts = { 'row': '+0', 'col': '+0', 'width': '-10', 'height': 10 }

" 创建 Leader 键字典
let g:which_key_map = {}

" 根级别的快捷键（只保留最常用的）
let g:which_key_map['e'] = ['NERDTreeToggle', '文件树']
let g:which_key_map['E'] = ['<leader>E', 'Emmet展开']
let g:which_key_map['='] = ['<C-w>=', '窗口均分']
let g:which_key_map[','] = ['MyVimBuffers', 'Buffer列表']

" 隐藏的快捷键（功能仍可用，只是不显示在菜单中）
let g:which_key_map['w'] = 'which_key_ignore'
let g:which_key_map['/'] = 'which_key_ignore'
let g:which_key_map['<space>'] = 'which_key_ignore'
let g:which_key_map['?'] = 'which_key_ignore'
let g:which_key_map['h'] = 'which_key_ignore'
let g:which_key_map['q'] = 'which_key_ignore'
let g:which_key_map['Q'] = 'which_key_ignore'
let g:which_key_map['x'] = 'which_key_ignore'
let g:which_key_map['-'] = 'which_key_ignore'
let g:which_key_map['|'] = 'which_key_ignore'
let g:which_key_map[':'] = 'which_key_ignore'
let g:which_key_map['qq'] = 'which_key_ignore'

" 文件操作
let g:which_key_map.f = {
      \ 'name' : '+文件' ,
      \ 'f' : ['MyVimFiles'         , '查找文件'],
      \ 'g' : ['MyVimGrep'          , '全文搜索'],
      \ 'b' : ['MyVimBuffers'       , 'Buffer列表'],
      \ 'h' : ['MyVimHelptags'      , '搜索帮助'],
      \ 'r' : ['MyVimHistory'       , '最近文件'],
      \ 'c' : ['MyVimCommandHistory', '命令历史'],
      \ 'm' : ['MyVimMarks'         , '标记列表'],
      \ 'w' : ['MyVimWindows'       , '窗口列表'],
      \ 'n' : ['enew'      , '新建文件'],
      \ 'e' : ['NERDTreeToggle', '文件树'],
      \ 't' : ['TagbarToggle', '传统大纲'],
      \ }

" NERDTree 子菜单
let g:which_key_map.n = {
      \ 'name' : '+文件树' ,
      \ 'f' : ['NERDTreeFind', '定位当前文件'],
      \ 'h' : ['nohlsearch', '清除高亮'],
      \ }

" 查看/大纲操作
let g:which_key_map.v = {
      \ 'name' : '+查看/大纲' ,
      \ 'v' : ['Vista!!', '切换大纲'],
      \ 'f' : ['Vista finder', '符号搜索'],
      \ 't' : ['TagbarToggle', '传统大纲'],
      \ }

" 快速跳转
let g:which_key_map.j = {
      \ 'name' : '+跳转' ,
      \ 's' : ['<Plug>(easymotion-overwin-f)'    , '单字符跳转'],
      \ '/' : ['<Plug>(easymotion-sn)'           , '搜索跳转'],
      \ 'l' : ['<Plug>(easymotion-lineforward)'  , '行内向右'],
      \ 'h' : ['<Plug>(easymotion-linebackward)' , '行内向左'],
      \ 'j' : ['<Plug>(easymotion-j)'            , '向下行跳转'],
      \ 'k' : ['<Plug>(easymotion-k)'            , '向上行跳转'],
      \ 'w' : ['<Plug>(easymotion-w)'            , '下一个词'],
      \ 'b' : ['<Plug>(easymotion-b)'            , '上一个词'],
      \ 'e' : ['<Plug>(easymotion-e)'            , '词尾'],
      \ 'f' : ['<Plug>(easymotion-bd-f)'         , '字符查找'],
      \ 't' : ['<Plug>(easymotion-bd-t)'         , '字符前查找'],
      \ '^' : ['<Plug>(easymotion-sol-bd-jk)'    , '行首'],
      \ '$' : ['<Plug>(easymotion-eol-bd-jk)'    , '行尾'],
      \ ';' : ['<Plug>(easymotion-repeat)'       , '重复跳转'],
      \ 'n' : ['<Plug>(easymotion-next)'         , '下一个匹配'],
      \ 'p' : ['<Plug>(easymotion-prev)'         , '上一个匹配'],
      \ ',' : ['<Plug>(easymotion-next)'         , '下一个匹配'],
      \ '.' : ['<Plug>(easymotion-prev)'         , '上一个匹配'],
      \ }

" 注意：<leader>w 已被用作保存文件，窗口操作使用 <leader>w 前缀（如 <leader>ww）
" 这里的 'w' 键是保存文件命令
" 窗口操作都在 keymaps.vim 中以 <leader>w + 字母的形式定义（<leader>ww, <leader>ws 等）

" Buffer 操作
let g:which_key_map.b = {
      \ 'name' : '+Buffer' ,
      \ 'b' : ['MyVimBuffers', 'Buffer列表'],
      \ 'd' : ['bdelete'   , '删除Buffer'],
      \ 'D' : ['bdelete!'  , '强制删除'],
      \ 'o' : ['bufdo bd'  , '删除其他'],
      \ }

" Tab 操作
let g:which_key_map.tab = {
      \ 'name' : '+标签页' ,
      \ 'tab' : ['tabnew'       , '新建标签页'],
      \ 'd'   : ['tabclose'    , '关闭标签页'],
      \ 'o'   : ['tabonly'     , '只保留当前'],
      \ ']'   : ['tabnext'     , '下一个标签'],
      \ '['   : ['tabprevious' , '上一个标签'],
      \ 'f'   : ['tabfirst'    , '第一个标签'],
      \ 'l'   : ['tablast'     , '最后一个标签'],
      \ }

" LSP 操作
let g:which_key_map.c = {
      \ 'name' : '+代码/LSP' ,
      \ 'a' : ['LspCodeAction'          , '代码操作'],
      \ 'c' : ['Commentary'             , '注释切换'],
      \ 'f' : ['LspDocumentFormat'      , '格式化'],
      \ 'd' : ['LspDocumentDiagnostics' , '诊断列表'],
      \ 's' : ['LspDocumentSymbol'      , '符号/大纲'],
      \ }

" 对齐
let g:which_key_map.a = {
      \ 'name' : '+对齐' ,
      \ 'a' : ['EasyAlign', '交互对齐'],
      \ }

" 主题
let g:which_key_map.T = {
      \ 'name' : '+主题' ,
      \ 'g' : ['ThemeGruvbox'     , 'Gruvbox 暗色'],
      \ 'l' : ['ThemeGruvboxLight', 'Gruvbox 亮色'],
      \ 'o' : ['ThemeOneDark'     , 'OneDark'],
      \ 'd' : ['ThemeDracula'     , 'Dracula'],
      \ 'n' : ['ThemeNord'        , 'Nord'],
      \ 'a' : ['ThemeAyu'         , 'Ayu 暗色'],
      \ 'A' : ['ThemeAyuLight'    , 'Ayu 亮色'],
      \ 'm' : ['ThemeAyuMirage'   , 'Ayu Mirage'],
      \ }

" Startify / 会话
let g:which_key_map.S = {
      \ 'name' : '+启动页/会话' ,
      \ 's' : ['Startify', '启动页'],
      \ 'S' : ['SSave!'  , '保存会话'],
      \ 'l' : ['SLoad'   , '加载会话'],
      \ 'd' : ['SDelete' , '删除会话'],
      \ 'c' : ['SClose'  , '关闭会话'],
      \ }

" 数据库
let g:which_key_map.D = {
      \ 'name' : '+数据库' ,
      \ 'u' : ['DBUIToggle'        , '数据库 UI'],
      \ 'a' : ['DBUIAddConnection' , '添加连接'],
      \ 'f' : ['DBUIFindBuffer'    , '查找查询 Buffer'],
      \ 'r' : ['DBUIRenameBuffer'  , '重命名查询 Buffer'],
      \ 'l' : ['DBUILastQueryInfo' , '上次查询信息'],
      \ }

" CMake 菜单（vim-cmake 在 Windows 的 Vim 下不可用，仅支持 Neovim）
if has('nvim') || !(has('win32') || has('win64'))
      let g:which_key_map.c.g = ['CMakeGenerate', 'CMake生成']
      let g:which_key_map.c.b = ['CMakeBuild', 'CMake构建']
      let g:which_key_map.c.r = ['CMakeRun', 'CMake运行']
      let g:which_key_map.c.t = ['CMakeSelectBuildType', '选择构建类型']
endif

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

" 调试（不使用 F* 键，改用 Leader+d 前缀）
let g:which_key_map.d = {
      \ 'name' : '+调试' ,
      \ 'd' : ['MyVimDebugCurrent'                   , '调试当前文件'],
      \ 'm' : ['MyVimDebugBuildCurrent'              , '构建当前C/C++调试目标'],
      \ 'c' : ['call vimspector#Continue()'            , '继续/启动 (F5)'],
      \ 's' : ['call vimspector#Stop()'                , '停止 (F3)'],
      \ 'r' : ['call vimspector#Restart()'             , '重启 (F4)'],
      \ 'p' : ['call vimspector#Pause()'               , '暂停 (F6)'],
      \ 'b' : ['call vimspector#ToggleBreakpoint()'    , '断点 (F9)'],
      \ 'B' : ['call vimspector#AddFunctionBreakpoint()', '函数断点 (F8)'],
      \ 'D' : ['call vimspector#ClearBreakpoints()'    , '清空断点'],
      \ 'n' : ['call vimspector#StepOver()'            , '单步跳过 (F10)'],
      \ 'i' : ['call vimspector#StepInto()'            , '单步进入 (F11)'],
      \ 'o' : ['call vimspector#StepOut()'             , '跳出 (F12)'],
      \ 't' : ['call vimspector#RunToCursor()'         , '运行到光标'],
      \ 'u' : ['call vimspector#ToggleUI()'            , '切换UI'],
      \ 'R' : ['call vimspector#Reset()'               , '重置Vimspector'],
      \ 'I' : ['MyVimDebugInstall'                     , '安装/更新适配器'],
      \ 'S' : ['MyVimDebugStatus'                      , '调试器状态'],
      \ }

" 工具菜单（将 <leader>u 和 <leader>uu 统一）
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
      \ 'f' : ['set foldenable!'  , '切换折叠'],
      \ }

" 翻译/表格菜单
let g:which_key_map.t = {
      \ 'name' : '+翻译/表格' ,
      \ 'w' : ['SimpleTranslate'  , '离线翻译-窗口'],
      \ 't' : ['SimpleTranslate'  , '离线翻译-光标词'],
      \ 's' : ['SimpleTranslate'  , '离线翻译'],
      \ 'S' : ['MyVimTranslateStatus', '翻译状态'],
      \ 'r' : ['SimpleTranslateReplace', '离线翻译并替换'],
      \ 'W' : ['Translate'        , 'vim-translator窗口'],
      \ 'T' : ['TranslateW'       , 'vim-translator词'],
      \ 'R' : ['TranslateR'       , 'vim-translator替换'],
      \ 'm' : ['TableModeToggle'  , '表格模式'],
      \ 'a' : ['TableModeRealign' , '表格对齐'],
      \ 'z' : ['Tableize'         , '选区转表格'],
      \ 'o' : ['GenTocGFM'        , '生成目录'],
      \ }

" Markdown 菜单
let g:which_key_map.m = {
      \ 'name' : '+Markdown' ,
      \ 'p' : ['MarkdownPreview'      , '预览'],
      \ 's' : ['MarkdownPreviewStop'  , '停止预览'],
      \ 't' : ['MarkdownPreviewToggle', '切换预览'],
      \ 'm' : ['TableModeToggle'      , '表格模式'],
      \ 'a' : ['TableModeRealign'     , '表格对齐'],
      \ 'o' : ['GenTocGFM'            , '生成目录'],
      \ }

" HTML 菜单
let g:which_key_map.h = {
  \ 'name' : '+HTML' ,
  \ 'p' : ['HtmlPreviewStart'  , '启动预览'],
  \ 's' : ['HtmlPreviewStop'   , '停止预览'],
  \ 't' : ['HtmlPreviewToggle' , '切换预览'],
  \ }

" 折叠菜单
let g:which_key_map.z = {
      \ 'name' : '+折叠' ,
      \ 'z' : ['normal! za'  , '切换折叠'],
      \ 'o' : ['normal! zo'  , '打开折叠'],
      \ 'c' : ['normal! zc'  , '关闭折叠'],
      \ 'a' : ['normal! zA'  , '递归切换'],
      \ 'O' : ['normal! zO'  , '递归打开'],
      \ 'C' : ['normal! zC'  , '递归关闭'],
      \ 'R' : ['normal! zR'  , '打开所有'],
      \ 'M' : ['normal! zM'  , '关闭所有'],
      \ 'r' : ['normal! zr'  , '减少折叠'],
      \ 'm' : ['normal! zm'  , '增加折叠'],
      \ 'j' : ['normal! zj'  , '下一个折叠'],
      \ 'k' : ['normal! zk'  , '上一个折叠'],
      \ }

" 重命名和代码动作（补充到 which-key）
let g:which_key_map.r = {
      \ 'name' : '+重构' ,
      \ 'n' : ['LspRename'  , '重命名符号'],
      \ }

" 缩进参考线
let g:which_key_map.i = {
      \ 'name' : '+缩进' ,
      \ 'g' : ['IndentGuidesToggle'  , '切换缩进线'],
      \ 'e' : ['IndentGuidesEnable'  , '启用缩进线'],
      \ 'd' : ['IndentGuidesDisable' , '禁用缩进线'],
      \ }

" 忽略列表：which-key 不显示这些映射（它们已经在分组中定义）
let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'  
let g:which_key_map.3 = 'which_key_ignore'
let g:which_key_map.4 = 'which_key_ignore'
let g:which_key_map.5 = 'which_key_ignore'
let g:which_key_map.6 = 'which_key_ignore'
let g:which_key_map.7 = 'which_key_ignore'
let g:which_key_map.8 = 'which_key_ignore'
let g:which_key_map.9 = 'which_key_ignore'
let g:which_key_map.0 = 'which_key_ignore'

" 隐藏 FZF 生成的临时命令映射
let g:which_key_map['<C-w>'] = 'which_key_ignore'

" 隐藏已定义的快捷键的重复项
" 由于我们在根级别定义了单字母快捷键，which-key 会自动捕获它们

" 注册 Which-Key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
