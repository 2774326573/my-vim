" Plugin management (vim-plug)
call plug#begin("~/.vim/plugged")

" 主题和外观 (Vim 兼容版本)
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

" Git 集成
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" 编辑增强
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'

" 文件浏览
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/tagbar'

" LSP/completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Debugging
Plug 'puremourning/vimspector'

" CMake
Plug 'cdelledonne/vim-cmake'

" Syntax
Plug 'sheerun/vim-polyglot'

" 其他实用工具
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vim-which-key'
Plug 'yianwillis/vimcdoc'
Plug 'voldikss/vim-translator'

call plug#end()
