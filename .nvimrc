
"显示行号
set number

"语法高亮
syntax on

"光标行显示下划线 
set cursorline

"搜索结果高亮显示
se hlsearch

"关掉高亮的搜索结果：(<LEADER>默认为\（反斜杠))
noremap <LEADER><CR> :nohlsearch<CR>

"动态显示搜索结果
set incsearch

"搜索结果智能大小写（搜索大写只能搜索大写，搜索小写，大小写都显示）
set smartcase

"在底部显示当前所处的模式(貌似和某个插件冲突了,没显示出效果)
set showmode

"在窗口下方展示当前执行的命令
set showcmd

"在以下所有模式下不使用鼠标
"n 普通模式
"v 可视模式
"i 插入模式
"c 命令行模式
"h 在帮助文件里，以上所有的模式
"a 以上所有的模式
set mouse-=a

"terminal color从默认的8色改成256色
set t_Co=256


"括号自动匹配高亮
set showmatch

"同一行内如果超过了屏幕界限屏幕换行但行数不变
set wrap

"可以从下一行初删除到上一行末尾
set backspace=2

"设置<tab>为四个空格
set ts=4

"把<tab>改成空格(按照上面的改成4个空格(符合python需要))
set expandtab

"文件类型自动缩进
filetype indent on

"自动缩进
set autoindent

"ESC快捷键为jk
imap jk <Esc>
imap JK <Esc>

"中文符号改成英文符号
imap （ (
imap ） )
imap ： :
imap “ "
imap " "
imap ， ,

"对markdown的特殊照顾
"<Ctrl><f> 自动寻找占位符<++>并删除(c4l表示剪切4个字符串)
autocmd Filetype markdown inoremap <C-f> <Esc>/<++><CR>:nohlsearch<CR>c4l

"<,><n> 新分割线:
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>

"<,><b> 加粗文本快捷键
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi

"<,><s> 删除线文本快捷键:
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi

"<,><i> 斜体快捷键:
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i

"<,><d> markdown函数快捷键:
autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i

"<,><c>代码块快捷键:
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA

"autocmd Filetype markdown inoremap ,h ====<Spacd><++><Esc>F=hi

"<,><p> 图片链接快捷键:
autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a

"<,><a> 文字链接快捷键:
autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a

"<,><1-5> 标题级数快捷键
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,5 #####<Space><Enter><++><Esc>kA

"<
autocmd Filetype markdown inoremap 》》 > 
autocmd Filetype markdown inoremap 《《 < 
autocmd Filetype markdown inoremap ×× * 
autocmd Filetype markdown inoremap 、、 \
autocmd Filetype markdown inoremap ￥￥ $


"按<F5>保存文件，并执行所识别出来的文件类型
map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python %"
elseif &filetype == 'html'
            exec "!firefox % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

"############################vim-plug管理的插件################################
call plug#begin('~/.config/nvim/plugged')

"vim-arduino
Plug 'stevearc/vim-arduino'
nnoremap <buffer> <leader>av :ArduinoVerify<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>as :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

"vim-markdown-preview
Plug 'iamcco/markdown-preview.vim'
Plug 'iamcco/mathjax-support-for-mkdp'
"设置浏览markdown的工具
let g:mkdp_path_to_chrome = "/usr/bin/chromium"
"<F8>键触发预览
nmap <silent> <F8> <Plug>MarkdownPreview      
"让所有文件都可以用markdownpreview预览
let g:mkdp_command_for_global = 1


"vim-table-mode (markdown表格自动对齐)
Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner = '|'
let g:table_mode_border=0
let g:table_mode_fillchar=' '
"表格自动对齐
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
    \ <SID>isAtStartOfLine('\|\|') ?
    \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
\ <SID>isAtStartOfLine('__') ?
\ '<c-o>:silent! TableModeDisable<cr>' : '__'

"NERDTREE(<Ctrl><n>触发,在vim中查找文件并可以进入)
Plug 'preservim/nerdtree' 
let g:plug_window = 'noautocmd vertical topleft new'
nmap <C-n> :NERDTreeToggle<CR>

"Ultisnips
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = ',t'
let g:UltiSnipsJumpForwardTrigger = ',t' 
let g:UltiSnipsJumpBackwardTrigger = 's,t' 
let g:UltiSnipsSnippetDirectories=["~/.vim/plugged/ultisnips/Ultisnips/"]
let g:UltiSnipsEditSplit="vertical"

"coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"coc.nvim自动安装以下已经说过但是还没安装的coc插件
let g:coc_global_extensions = [
                \ 'coc-json',
                \ 'coc-vimlsp',
                \ 'coc-eslint',
                \ 'coc-python',]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"快速找到上一个(<[><e>)或下一个(<]><e>)代码报错的位置
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

"<g><d/y/i/r>跳到函数定义的位置
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"<leader><r><n>把所被选中的变量全都重命名
nmap <leader>rn <Plug>(coc-rename)

"vim-surround
Plug 'tpope/vim-surround'

"wildfire.vim
Plug 'gcmt/wildfire.vim'

"fcitx.vim(<ESC>退出自动切换英文输入法,进入inser mode自动切换中文输入法)
Plug 'lilydjwg/fcitx.vim'

call plug#end()

"#####################vim-plug插件部署完成#########################

"vim寄存器剪切板和系统的剪切板共用
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
