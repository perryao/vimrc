inoremap jk <Esc>
map <space>j <C-W>j
map <space>k <C-W>k
map <space>h <C-W>h
map <space>l <C-W>l
" Setup tab and shift-tab to cycle buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
set number
set clipboard=unnamed
set mouse=a
set nofoldenable
let g:jsx_ext_required = 0
let g:NERDTreeWinPos = "left"

" Disable auto comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let g:syntastic_javascript_checkers = []

function CheckJavaScriptLinter(filepath, linter)
    if exists('b:syntastic_checkers')
        return
    endif
    if filereadable(a:filepath)
        let b:syntastic_checkers = [a:linter]
        let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
    endif
endfunction

function SetupJavaScriptLinter()
    let l:current_folder = expand('%:p:h')
    let l:bin_folder = fnamemodify(syntastic#util#findFileInParent('package.json', l:current_folder), ':h')
    let l:bin_folder = l:bin_folder . '/node_modules/.bin/'
    call CheckJavaScriptLinter(l:bin_folder . 'standard', 'standard')
    call CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
endfunction

autocmd FileType javascript call SetupJavaScriptLinter()
