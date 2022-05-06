" ------------------------------------------------------------
" Global config
" ------------------------------------------------------------

set showmatch
set backspace=2
set autowrite
set dir=~/.vimswp
set gdefault
set digraph
set encoding=utf-8
":set fileencodings=ucs-bom,utf-8,latin1
set confirm
behave xterm
set ignorecase
set backupdir=~/.vimbak
set backupext=.bak
set backup
"set guifont="Droid Sans Mono 10"
set smarttab
set smartindent
set autoindent
set shiftwidth=4
set softtabstop=4
set expandtab
set tabstop=4
set ruler
set magic
set ignorecase smartcase
set visualbell
auto BufWrite *.* :retab
":auto BufRead *.* compiler ant
augroup xmlprog
    au!
    autocmd BufRead *.xml compiler ant
augroup END
augroup jspprog
    au!
    autocmd BufRead *.jsp compiler ant
    autocmd BufRead *.jsp map <C-T> O<Home><c:out value=""/><Left><Left><Left>
    autocmd BufRead *.jsp imap <C-T> O<Home><c:out value=""/><Left><Left><Left>
augroup END
augroup javaprog
    :au!
"    autocmd BufRead *.java map <F11> :!start cmd /c "jalopy %"<CR><CR>
"    autocmd BufRead *.java compiler ant
"    let b:jcommenter_class_author='Kalle Bjorklid (bjorklid@st.jyu.fi)'
"    let b:jcommenter_file_author='Kalle Björklid (bjorklid@st.jyu.fi)'
"    "source $VIM/vim62/macros/jcommenter.vim
"    "autocmd BufRead *.java map <F2> :call JCommentWriter()<CR>
    autocmd BufRead *.java map <F5> :!ctags -R src<CR>
    autocmd BufRead *.java map <C-T> O<Home>System.out.println( "" );<Left><Left><Left><Left>
    autocmd BufRead *.java imap <C-T> O<Home>System.out.println( "" );<Left><Left><Left><Left>
    autocmd BufRead *.java set tags=./tags,tags,c:/jdk/src/tags
    " To build the tag index file: !ctags -R src
augroup END
augroup javascriptprog
    au!
    autocmd BufRead *.js map <C-T> O<Home>alert( "" )<Left><Left><Left>
    autocmd BufRead *.js imap <C-T> O<Home>alert( "" )<Left><Left><Left>
augroup END
augroup rubyprog
    au!
    autocmd BufRead *.rb map <C-T> O<Home>puts( "" )<Left><Left><Left>
    autocmd BufRead *.rb imap <C-T> O<Home>puts( "" )<Left><Left><Left>
augroup END
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END
augroup calprog
    au!
    autocmd BufNewFile,BufRead *.cal setf cal
augroup END
autocmd BufWritePre *.c,*.cpp,*.java,*.pl,*.py :%s/\s\+$//e
":augroup XMLFiles
"    :au!
"    :autocmd BufRead *.xml map = ":silent 1,$!tidy -xml -indent -quiet 2>/dev/null"
":augroup END
map <F12> \be
map <S-F12> \bs
imap <F12> 
imap <S-F12> 
map <C-A> ggVG
imap <C-A> ggVG
map <C-s> ?\<<CR>v/\><CR><Left>"sx/\<<CR>"sP<Right>v/\><CR><Left>"sx?,<CR>"sP<Right>
imap <C-s> ?\<<CR>v/\><CR><Left>"sx/\<<CR>"sP<Right>v/\><CR><Left>"sx?,<CR>"sP<Right>
set columns=132
" Toggles paste mode
set pt=<F8>
iab alerT alert
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper ("backward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("forward")<cr>

" ------------------------------------------------------------
" dein: https://github.com/Shougo/dein.vim
" ------------------------------------------------------------

set nocompatible " be iMproved, required
filetype off

set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
    call dein#begin('~/.local/share/dein')

    call dein#add('~/.local/share/dein/repos/github.com/Shougo/dein.vim')

    " Completion
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    " AsyncRun
    call dein#add('skywind3000/asyncrun.vim')

    " Nerdtree
    call dein#add('scrooloose/nerdtree')
    call dein#add('Xuyuanp/nerdtree-git-plugin')

    " Comments
    call dein#add('preservim/nerdcommenter')

    " Git
    call dein#add('tpope/vim-fugitive')

    " Auto-Pairs
    call dein#add('jiangmiao/auto-pairs')

    " Parenthesising
    call dein#add('tpope/vim-surround')

    " Look
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('arcticicestudio/nord-vim')

    " Typescript
    call dein#add('leafgarland/typescript-vim')

    " Javascript
    call dein#add('pangloss/vim-javascript')

    " xterm-color-table: provides command :XtermColorTable
    call dein#add('guns/xterm-color-table.vim')

    call dein#end()
    call dein#save_state()
endif

" call dein#install() if there are any plugins not installed yet
if dein#check_install()
    call dein#install()
    normal UpdateRemotePlugins
endif

filetype plugin indent on
syntax enable


" ------------------------------------------------------------
" AsyncRun
" ------------------------------------------------------------

let g:asyncrun_rootmarks = ['features']
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])


" ------------------------------------------------------------
" Nerdtree
" ------------------------------------------------------------
" https://github.com/scrooloose/nerdtree
" Good advice on https://medium.com/@victormours/a-better-nerdtree-setup-3d3921abc0b9

nmap t          :NERDTreeToggle<CR>

" Quit on Open
let NERDTreeQuitOnOpen = 1

" Directory arrows
let NERDTreeDirArrows = 1

" Disable 'Press ? for Help'
" let NERDTreeMinimalUI = 1

" Open nerdtree if vim is loaded without a file name
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open nerdtree if vim is loaded with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Default arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Symbols for nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" set theme
let g:airline_theme = 'nord'
colorscheme nord

" darvs-patch colorscheme
highlight LineNr ctermfg=08
highlight ErrorMsg ctermfg=15 ctermbg=88 guifg=#00FF00 guibg=#BF616A


" ------------------------------------------------------------
" airline
" ------------------------------------------------------------

set laststatus=2
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Fix a problem where the space is not wide enough
let g:airline_symbols.space = "\ua0"

if $NERD != 'on'
    " unicode symbols
    " let g:airline_left_sep = '▶'
    " let g:airline_right_sep = '◀'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    "" let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.whitespace = 'Ξ'
    let g:airline_symbols.linenr = '#'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.readonly = 'ro'
endif

if $TERM =~ 'linux'
    let g:airline_symbols.branch = ''
endif


" ------------------------------------------------------------
" NERDCommenter
" ------------------------------------------------------------

" unmap c in visual mode because it breaks everything
" by _c_hanging text (deleting and switching to insert mode)

vmap c <Nop>
vmap <leader><Space> <Plug>NERDCommenterToggle


