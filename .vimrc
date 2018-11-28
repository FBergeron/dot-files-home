:colorscheme jellybeans
:set showmatch
:set backspace=2
:set autowrite
:set dir=~/.vimswp
:set nocompatible
:set gdefault
:set digraph
:set encoding=utf-8
":set fileencodings=ucs-bom,utf-8,latin1
:set confirm
:behave xterm
:set ignorecase
:set backupdir=~/.vimbak 
:set backupext=.bak
:set backup
:syntax on
:set guifont="Droid Sans Mono 10"
:set smarttab
:set smartindent
:set autoindent
:set shiftwidth=4
:set softtabstop=4
:set expandtab 
:set tabstop=4
:set ruler
:set magic
:set ignorecase smartcase
:set visualbell
:filetype plugin on
:auto BufWrite *.* :retab
":auto BufRead *.* compiler ant
:augroup xmlprog
    :au!
    :autocmd BufRead *.xml compiler ant
:augroup END
:augroup jspprog
    :au!
    :autocmd BufRead *.jsp compiler ant
    :autocmd BufRead *.jsp map <C-T> O<Home><c:out value=""/><Left><Left><Left>
    :autocmd BufRead *.jsp imap <C-T> O<Home><c:out value=""/><Left><Left><Left>
:augroup END
:augroup javaprog
    :au!
"    :autocmd BufRead *.java map <F11> :!start cmd /c "jalopy %"<CR><CR>
"    :autocmd BufRead *.java compiler ant
"    :let b:jcommenter_class_author='Kalle Bjorklid (bjorklid@st.jyu.fi)' 
"    :let b:jcommenter_file_author='Kalle Björklid (bjorklid@st.jyu.fi)' 
"    ":source $VIM/vim62/macros/jcommenter.vim 
"    ":autocmd BufRead *.java map <F2> :call JCommentWriter()<CR>
    :autocmd BufRead *.java map <F5> :!ctags -R src<CR>
    :autocmd BufRead *.java map <C-T> O<Home>System.out.println( "" );<Left><Left><Left><Left>
    :autocmd BufRead *.java imap <C-T> O<Home>System.out.println( "" );<Left><Left><Left><Left>
    :autocmd BufRead *.java set tags=./tags,tags,c:/jdk/src/tags
    " To build the tag index file: !ctags -R src
:augroup END
:augroup javascriptprog
    :au!
    :autocmd BufRead *.js map <C-T> O<Home>alert( "" )<Left><Left><Left>
    :autocmd BufRead *.js imap <C-T> O<Home>alert( "" )<Left><Left><Left>
:augroup END
:augroup rubyprog
    :au!
    :autocmd BufRead *.rb map <C-T> O<Home>puts( "" )<Left><Left><Left>
    :autocmd BufRead *.rb imap <C-T> O<Home>puts( "" )<Left><Left><Left>
:augroup END
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
:augroup calprog
    :au!
    :autocmd BufNewFile,BufRead *.cal setf cal
:augroup END
:autocmd BufWritePre *.c,*.cpp,*.java,*.pl,*.py :%s/\s\+$//e
":augroup XMLFiles
"    :au!
"    :autocmd BufRead *.xml map = ":silent 1,$!tidy -xml -indent -quiet 2>/dev/null"
":augroup END
:map <F12> \be
:map <S-F12> \bs
:imap <F12> 
:imap <S-F12>  
:map <C-A> ggVG
:imap <C-A> ggVG
:map <C-s> ?\<<CR>v/\><CR><Left>"sx/\<<CR>"sP<Right>v/\><CR><Left>"sx?,<CR>"sP<Right>
:imap <C-s> ?\<<CR>v/\><CR><Left>"sx/\<<CR>"sP<Right>v/\><CR><Left>"sx?,<CR>"sP<Right>
:set columns=132
" Toggles paste mode
:set pt=<F8> 
:iab alerT alert
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

:cd /home/fred/VimSessions
