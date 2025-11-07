" =============== 快捷键映射 ===============

" 快捷键帮助
nnoremap <leader>? :echo "Leader键帮助: <Space>w=保存 <Space>q=退出 <Space>e=文件树 <Space>ff=查找 <Space>fg=搜索"<CR>
nnoremap <leader>h :echo "查看完整帮助: cat ~/vimfiles/速查卡.md"<CR>

" =============== 基础操作 ===============
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>qq :qa<CR>

" 清除搜索高亮
nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <leader>nh :nohlsearch<CR>

" =============== 文件操作 (FZF) ===============
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>fc :History:<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fn :enew<CR>

" LazyVim 风格快捷方式
nnoremap <leader><space> :Buffers<CR>
nnoremap <leader>/ :Rg<CR>
nnoremap <leader>, :Buffers<CR>
nnoremap <leader>: :History:<CR>

" =============== NERDTree ===============
if exists('g:loaded_nerdtree')
  nnoremap <leader>e :NERDTreeToggle<CR>
  nnoremap <leader>nf :NERDTreeFind<CR>
  nnoremap <leader>fe :NERDTreeToggle<CR>
endif

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
nnoremap <leader>bb :Buffers<CR>
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
  nmap s <Plug>(easymotion-overwin-f2)
  nmap <leader>s <Plug>(easymotion-overwin-f)
  nmap <leader>/ <Plug>(easymotion-sn)
endif

" =============== EasyAlign ===============
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" =============== LSP / Coc.nvim ===============
" 导航
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> K :call CocActionAsync("doHover")<CR>

" 代码操作
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>cl <Plug>(coc-codeaction-line)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nnoremap <leader>cf :call CocActionAsync("format")<CR>
xnoremap <leader>cf <Plug>(coc-format-selected)

" 诊断
nmap [d <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-diagnostic-next)
nnoremap <leader>cd :CocList diagnostics<CR>
nnoremap <leader>cs :CocList symbols<CR>
nnoremap <leader>co :CocList outline<CR>
nnoremap <leader>cc :CocList commands<CR>

" 补全
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<TAB>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <C-space> coc#refresh()

" =============== Git 操作 ===============
" Fugitive
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gP :Git pull<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gA :Git add .<CR>

" GitGutter
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)

" =============== 调试 (Vimspector) ===============
nnoremap <leader>du :VimspectorToggleUI<CR>
nnoremap <leader>dr :VimspectorReset<CR>

" =============== CMake ===============
nnoremap <leader>cg :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild<CR>
nnoremap <leader>cr :CMakeRun<CR>
nnoremap <leader>ct :CMakeSelectBuildType<CR>

" =============== 实用工具 ===============
" UndoTree
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>uu :UndotreeToggle<CR>

" 选项切换
nnoremap <leader>uw :set wrap!<CR>
nnoremap <leader>ur :set relativenumber!<CR>
nnoremap <leader>un :set number!<CR>
nnoremap <leader>us :set spell!<CR>
nnoremap <leader>ul :set list!<CR>
nnoremap <leader>uc :set cursorline!<CR>
nnoremap <leader>ux :set cursorcolumn!<CR>
