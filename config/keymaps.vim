" =============== 快捷键映射 ===============

" 快捷键帮助
nnoremap <leader>? :echo "Leader键帮助: <Space>w=保存 <Space>q=退出 <Space>e=文件树 <Space>ff=查找 <Space>fg=搜索"<CR>

" 可视/选择模式下单击空格不执行默认右移，等待后续组合键。
xnoremap <silent> <Space> <Nop>
snoremap <silent> <Space> <Nop>

" =============== 基础操作 ===============
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>qq :qa<CR>

" 清除搜索高亮
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <leader>nh :nohlsearch<CR>

" =============== 文件操作 ===============
nnoremap <leader>ff :MyVimFiles<CR>
nnoremap <leader>fg :MyVimGrep<CR>
nnoremap <leader>fb :MyVimBuffers<CR>
nnoremap <leader>fh :MyVimHelptags<CR>
nnoremap <leader>fr :MyVimHistory<CR>
nnoremap <leader>fc :MyVimCommandHistory<CR>
nnoremap <leader>fm :MyVimMarks<CR>
nnoremap <leader>fw :MyVimWindows<CR>
nnoremap <leader>fn :enew<CR>

" LazyVim 风格快捷方式
nnoremap <leader><space> :MyVimBuffers<CR>
nnoremap <leader>/ :MyVimGrep<CR>
nnoremap <leader>, :MyVimBuffers<CR>
nnoremap <leader>: :MyVimCommandHistory<CR>

" =============== NERDTree ===============
" if exists('g:loaded_nerdtree')
  nnoremap <leader>e :NERDTreeToggle<CR>
  nnoremap <leader>nf :NERDTreeFind<CR>
  nnoremap <leader>fe :NERDTreeToggle<CR>
" endif

" =============== 窗口管理 ===============
" 窗口导航
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 窗口操作 (LazyVim 风格)
nnoremap <leader>ww <C-w>w
nnoremap <leader>wd <C-w>c
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wo <C-w>o
nnoremap <leader>- :split<CR>
nnoremap <leader>| :vsplit<CR>

" 窗口大小调整
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <leader>= <C-w>=

" =============== Buffer 管理 ===============
nnoremap <leader>bb :MyVimBuffers<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bD :bdelete!<CR>
nnoremap <leader>bo :bufdo bd<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>

" =============== Tab 管理 ===============
nnoremap <leader><tab><tab> :tabnew<CR>
nnoremap <leader><tab>d :tabclose<CR>
nnoremap <leader><tab>o :tabonly<CR>
nnoremap <leader><tab>] :tabnext<CR>
nnoremap <leader><tab>[ :tabprevious<CR>
nnoremap <leader><tab>f :tabfirst<CR>
nnoremap <leader><tab>l :tablast<CR>

" =============== 编辑增强 ===============
" 缩进
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv

" 粘贴
vnoremap p "_dP
xnoremap p "_dP

" 移动行
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" =============== 快速移动 ===============
" 上下可见行移动
nnoremap j gj
nnoremap k gk

" 快速移动 5 行
nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k

" 行首行尾
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" =============== EasyMotion ===============
if exists('g:loaded_easymotion')
  " 取消 EasyMotion 默认的 <Space><Space> 前缀，避免误触提示。
  silent! nunmap <Space><Space>
  silent! xunmap <Space><Space>
  silent! sunmap <Space><Space>
  nnoremap <silent> <Space><Space> <Nop>
  xnoremap <silent> <Space><Space> <Nop>
  snoremap <silent> <Space><Space> <Nop>

  " 单字符跳转（所有窗口）
  nmap s <Plug>(easymotion-overwin-f2)
  " 单字符搜索（当前窗口）
  nmap <leader>s <Plug>(easymotion-overwin-f)
  nmap <leader>js <Plug>(easymotion-overwin-f)
  " 多字符搜索
  nmap <leader>/ <Plug>(easymotion-sn)
  nmap <leader>j/ <Plug>(easymotion-sn)
  
  " 行内跳转（快速移动到行内任意位置）
  nmap <leader>jl <Plug>(easymotion-lineforward)
  nmap <leader>jh <Plug>(easymotion-linebackward)
  nmap <leader>jj <Plug>(easymotion-j)
  nmap <leader>jk <Plug>(easymotion-k)
  
  " 跳转到行首
  nmap <leader>j^ <Plug>(easymotion-sol-bd-jk)
  nmap <leader>j$ <Plug>(easymotion-eol-bd-jk)
  
  " 单词跳转
  nmap <leader>jw <Plug>(easymotion-w)
  nmap <leader>jb <Plug>(easymotion-b)
  nmap <leader>je <Plug>(easymotion-e)
  
  " 双向跳转（向前向后都高亮）
  nmap <leader>jf <Plug>(easymotion-bd-f)
  nmap <leader>jt <Plug>(easymotion-bd-t)
  
  " 重复上次跳转
  nmap <leader>j; <Plug>(easymotion-repeat)
  nmap <leader>j, <Plug>(easymotion-next)
  nmap <leader>j. <Plug>(easymotion-prev)
  nmap <leader>jn <Plug>(easymotion-next)
  nmap <leader>jp <Plug>(easymotion-prev)
endif

" =============== EasyAlign ===============
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nnoremap <leader>aa :EasyAlign<CR>
xnoremap <leader>aa :EasyAlign<CR>

" =============== 注释 (vim-commentary) ===============
nnoremap <leader>cc :Commentary<CR>
xnoremap <leader>cc :Commentary<CR>

" =============== LSP / 补全 ===============
if get(g:, 'myvim_lsp_engine', 'coc') ==# 'coc'
  function! s:coc_check_back_space() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~# '\s'
  endfunction

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gD <Plug>(coc-declaration)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gy <Plug>(coc-type-definition)
  nnoremap <silent> K :call CocShowDocumentation()<CR>
  nmap <leader>rn <Plug>(coc-rename)
  nmap <leader>ca <Plug>(coc-codeaction-cursor)
  nnoremap <leader>cf :call CocActionAsync('format')<CR>
  nmap [d <Plug>(coc-diagnostic-prev)
  nmap ]d <Plug>(coc-diagnostic-next)
  nnoremap <leader>cd :CocDiagnostics<CR>
  nnoremap <leader>cs :CocList outline<CR>
  nnoremap <leader>sS :CocCommand snippets.openSnippetFiles<CR>

  inoremap <silent><expr> <C-Space> coc#refresh()
  inoremap <silent><expr> <C-@> coc#refresh()
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<CR>" :
        \ <SID>coc_check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <silent><expr> <S-TAB>
        \ coc#pum#visible() ? coc#pum#prev(1) :
        \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev', [])\<CR>" :
        \ "\<C-h>"
  imap <C-j> <Plug>(coc-snippets-expand-jump)
  smap <C-j> <Plug>(coc-snippets-expand-jump)
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
else
  nmap <silent> gd <plug>(lsp-definition)
  nmap <silent> gD <plug>(lsp-definition)
  nmap <silent> gr <plug>(lsp-references)
  nmap <silent> gi <plug>(lsp-implementation)
  nmap <silent> gy <plug>(lsp-type-definition)
  nmap <silent> K <plug>(lsp-hover)
  nmap <leader>rn <plug>(lsp-rename)
  nmap <leader>ca <plug>(lsp-code-action)
  nnoremap <leader>cf :LspDocumentFormat<CR>
  nmap [d <plug>(lsp-previous-diagnostic)
  nmap ]d <plug>(lsp-next-diagnostic)
  nnoremap <leader>cd :LspDocumentDiagnostics<CR>
  nnoremap <leader>cs :LspDocumentSymbol<CR>

  " Ctrl+Space: 手动触发补全
  imap <C-Space> <Plug>(asyncomplete_force_refresh)
  imap <C-@> <Plug>(asyncomplete_force_refresh)

  " Enter: 确认补全并插入，或正常换行
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
endif

" Tab/Shift+Tab: 由 snipMate 处理（它会自动检测 pumvisible）
" snipMate 的默认行为：
"   - pumvisible() 时：<C-n> 选择下一项
"   - 否则：展开代码片段或跳转到下一个占位符
" 如果需要在补全菜单中用 Tab 确认，使用 Enter 键即可

" =============== Git 操作（需要 git 命令，已禁用）===============
" Fugitive
" nnoremap <leader>gg :Git<CR>
" nnoremap <leader>gd :Git diff<CR>
" nnoremap <leader>gb :Git blame<CR>
" nnoremap <leader>gl :Git log<CR>
" nnoremap <leader>gp :Git push<CR>
" nnoremap <leader>gP :Git pull<CR>
" nnoremap <leader>gc :Git commit<CR>
" nnoremap <leader>ga :Git add %<CR>
" nnoremap <leader>gA :Git add .<CR>

" GitGutter
" nmap [h <Plug>(GitGutterPrevHunk)
" nmap ]h <Plug>(GitGutterNextHunk)
" nmap <leader>hs <Plug>(GitGutterStageHunk)
" nmap <leader>hu <Plug>(GitGutterUndoHunk)
" nmap <leader>hp <Plug>(GitGutterPreviewHunk)

" =============== HTML 实时预览 ===============
nnoremap <leader>hp :HtmlPreviewStart<CR>
nnoremap <leader>hs :HtmlPreviewStop<CR>
nnoremap <leader>ht :HtmlPreviewToggle<CR>

" =============== 调试 (Vimspector) ===============
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
nnoremap <leader>dS :MyVimDebugStatus<CR>
nnoremap <leader>dI :MyVimDebugInstall<CR>

" =============== CMake ===============
nnoremap <leader>cg :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild<CR>
nnoremap <leader>cr :CMakeRun<CR>
nnoremap <leader>ct :CMakeSelectBuildType<CR>

" =============== 主题 ===============
nnoremap <leader>Tg :ThemeGruvbox<CR>
nnoremap <leader>Tl :ThemeGruvboxLight<CR>
nnoremap <leader>To :ThemeOneDark<CR>
nnoremap <leader>Td :ThemeDracula<CR>
nnoremap <leader>Tn :ThemeNord<CR>
nnoremap <leader>Ta :ThemeAyu<CR>
nnoremap <leader>TA :ThemeAyuLight<CR>
nnoremap <leader>Tm :ThemeAyuMirage<CR>

" =============== Startify / 会话 ===============
nnoremap <leader>Ss :Startify<CR>
nnoremap <leader>SS :SSave!<CR>
nnoremap <leader>Sl :SLoad<CR>
nnoremap <leader>Sd :SDelete<CR>
nnoremap <leader>Sc :SClose<CR>

" =============== 数据库 (vim-dadbod-ui) ===============
nnoremap <leader>Du :DBUIToggle<CR>
nnoremap <leader>Da :DBUIAddConnection<CR>
nnoremap <leader>Df :DBUIFindBuffer<CR>
nnoremap <leader>Dr :DBUIRenameBuffer<CR>
nnoremap <leader>Dl :DBUILastQueryInfo<CR>

" =============== Markdown / 表格 ===============
nnoremap <leader>mp :MarkdownPreview<CR>
nnoremap <leader>ms :MarkdownPreviewStop<CR>
nnoremap <leader>mt :MarkdownPreviewToggle<CR>
nnoremap <leader>mo :GenTocGFM<CR>
nnoremap <leader>tm :TableModeToggle<CR>
nnoremap <leader>ta :TableModeRealign<CR>
xnoremap <leader>tz :Tableize<CR>

" =============== 翻译 ===============
nnoremap <silent> <leader>tw :call SimpleTranslate()<CR>
vnoremap <silent> <leader>tw :<C-u>call SimpleTranslate(MyVimVisualText())<CR>
nnoremap <silent> <leader>tt :call SimpleTranslate()<CR>
vnoremap <silent> <leader>tt :<C-u>call SimpleTranslate(MyVimVisualText())<CR>
nnoremap <silent> <leader>tZ :call SimpleTranslate('en_zh')<CR>
vnoremap <silent> <leader>tZ :<C-u>call SimpleTranslate(MyVimVisualText(), 'en_zh')<CR>
nnoremap <silent> <leader>tE :call SimpleTranslate('zh_en')<CR>
vnoremap <silent> <leader>tE :<C-u>call SimpleTranslate(MyVimVisualText(), 'zh_en')<CR>
nnoremap <silent> <leader>tr :TransReplace<CR>
vnoremap <silent> <leader>tr :<C-u>call SimpleTranslateReplace(MyVimVisualText(), 'auto')<CR>
nnoremap <silent> <leader>tre :TransReplace zh_en<CR>
vnoremap <silent> <leader>tre :<C-u>call SimpleTranslateReplace(MyVimVisualText(), 'zh_en')<CR>
nnoremap <silent> <leader>trz :TransReplace en_zh<CR>
vnoremap <silent> <leader>trz :<C-u>call SimpleTranslateReplace(MyVimVisualText(), 'en_zh')<CR>

" =============== 实用工具 ===============
" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>uu :UndotreeToggle<CR>
nnoremap <leader>se :split<CR>:e ~/my-vim/snippets/<C-R>=&filetype<CR>.snippets<CR>

" 代码折叠
nnoremap <space>zz za
nnoremap <space>zm zM
nnoremap <space>zr zR
nnoremap <space>zo zo
nnoremap <space>zc zc

" 选项切换
nnoremap <leader>uw :set wrap!<CR>
nnoremap <leader>ur :set relativenumber!<CR>
nnoremap <leader>un :set number!<CR>
nnoremap <leader>us :set spell!<CR>
nnoremap <leader>ul :set list!<CR>
nnoremap <leader>uc :set cursorline!<CR>
nnoremap <leader>ux :set cursorcolumn!<CR>
nnoremap <leader>uf :set foldenable!<CR>
