" =============== 插件（vim-plug） ===============
call plug#begin("~/vimfiles/plugged")

Plug "catppuccin/vim", { "as": "catppuccin" }
Plug "itchyny/lightline.vim"
Plug "ryanoasis/vim-devicons"
Plug "airblade/vim-gitgutter"
Plug "tpope/vim-commentary"
Plug "tpope/vim-surround"
Plug "tpope/vim-repeat"
Plug "jiangmiao/auto-pairs"

Plug "junegunn/fzf", { "dir": "~/.fzf", "do": "./install --all" }
Plug "junegunn/fzf.vim"

" LSP/补全
Plug "neoclide/coc.nvim", {"branch": "release"}

" 调试
Plug "puremourning/vimspector"

" CMake
Plug "cdelledonne/vim-cmake"

" 语法集
Plug "sheerun/vim-polyglot"

call plug#end()
