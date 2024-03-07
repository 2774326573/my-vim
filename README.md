
<!-- vim-markdown-toc Marked -->

* [my-vim快捷键映射](#my-vim快捷键映射)
    * [basic(基础)快捷键](#basic(基础)快捷键)
    * [plugs-config(插件)快捷键映射](#plugs-config(插件)快捷键映射)

<!-- vim-markdown-toc -->
# my-vim快捷键映射

## basic(基础)快捷键

\<leader> = " "  
jk == \<ESC>  
\<silent> 为静默映射，不显示输出命令,并没有快捷键

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | \<leader>e | 编辑vimrc配置文件|
| nnoremap   | \<leader>vc| 编辑插件配置文件|
| nnoremap   | \<leader>vp| 编辑插件安装文件|
| nnoremap   | \<leader>h| 查看vimplus的帮助文件|
| nnoremap   | \<leader>H| 打开当前光标所在单词的vim帮助文档|
| nnoremap   | \<leader>s| 重新加载vimrc文件|
| nnoremap   | \<leader>\<leader>i| 安装插件|
| nnoremap   | \<leader>\<leader>u| 更新插件|
| nnoremap   | \<leader>\<leader>c| 删除插件|
| nnoremap   | \<leader>j| 分屏窗口向下移动|
| nnoremap   | \<leader>k| 分屏窗口向上移动|
| nnoremap   | \<leader>h| 分屏窗口向左移动|
| nnoremap   | \<leader>l| 分屏窗口向右移动|
| map   | \<leader>w| 保存并写入文件|
| map   | \<leader>q| 保存写入文件,并退出|
| map   | \<leader>tq| 强制退出|
| vmap    | \<C-c> | 复制当前所选中到系统剪切板|
| nnoremap   | \<C-v>| 将系统剪切板内容粘贴到vim|

## plugs-config(插件)快捷键映射

<font color=red>cpp-mode</font>

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | \<leader>y| 复制函数或变量代码|
| nnoremap   | \<leader>p| 粘贴复制的函数或变量代码|
| nnoremap   | \<leader>U| 转到函数实现|
| nnoremap   | \<silent>\<leader>a| c++头文件和实现文件切换|
| nnoremap   | \<leader>\<leader>fp| 格式化函数参数，用于函数列表过多的情况|
| nnoremap   | \<leader>\<leader>if| 格式化if|
| nnoremap   | \<leader>\<leader>t dd| 生成try-catch代码块|
| nnoremap   | \<leader>\<leader>t d| 生成try-catch代码块|

change-colorscheme(变化主题）

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | \<silent> \<F9>| 上一个的主题|
| inoremap   | \<silent> \<F9> \<esc>| 上一个的主题|
| nnoremap   | \<silent> \<F10>| 下一个的主题|
| inoremap   | \<silent> \<F10> \<esc>| 下一个的主题|
| nnoremap   | \<silent> \<F11>| 随机的主题|
| inoremap   | \<silent> \<F11> \<esc>| 随机的主题|
| nnoremap   | \<silent> \<F12>| 显示的主题信息|
| inoremap   | \<silent> \<F11> \<esc>| 显示主题信息|

vim-buffer(缓存区)

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | \<silent> \<C-p>| 上一个的buffer|
| nnoremap   | \<silent> \<C-n>| 下一个的buffer|
| nnoremap   | \<silent> \<leader>d| 关闭buffer|
| nnoremap   | \<silent> \<leader>D| :BufOnly|

vim-edit(vim—文本编辑器)

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | Y| 复制文本|
| nnoremap   | D| 删除文本|
| nnoremap   | C| ChangeText|
| nnoremap   | \<leader>r| ReplaceTo<space>|

nerdtree(文件树管理器)

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | \<silent> \<leader>m| 打开文件树|

YCM(代码自动补全)

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   |  \<leader>u| 查找光标下的的标识符并跳转到其声明|
| nnoremap   |  \<leader>o| 查找当前头文件并跳转|
| nnoremap   |  \<leader>o| 修复错误或警告|
| nmap   |  \<F5>| 检测错误或警告并提示|

tagbar(标签栏)

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| nnoremap   | \<silent> \<leader>t| 函数声明及变量定义标签栏|

incsearch.vim(搜索)

| 模式    | 快捷键    | 备注    |
|:-------------- | :-------------: | :-------------- |
| map   | \/| 向前搜索|
| map   | \?| 向后搜索|
| map   | \g/| 停留搜索|



 

