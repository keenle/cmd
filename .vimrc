" TODO:
" 1. Cleanup comments
" 2. Add missing comments
" 3. Bindings to toggle Fern
" 4. Fix vim-plug installation script: Do not proceed with plugins config
"    until plugins are actually installed.
" 5. Cheat sheets for:
"    1. Spellchecking 
"    2. Window management
"    3. Vim WiKi
"    4. Fern
let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.vimrc"

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" First install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged' " - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" File manager(s)
Plug 'lambdalisue/fern.vim'                     " File tree viewer
Plug 'lambdalisue/nerdfont.vim'                 "
Plug 'lambdalisue/fern-renderer-nerdfont.vim'   " 
Plug 'lambdalisue/glyph-palette.vim'            "
Plug 'lambdalisue/fern-hijack.vim'              " Use Fern as default file manager
"Plug 'vifm/vifm.vim'                            " File namager

Plug 'itchyny/lightline.vim'                    " Statusbar
Plug 'vimwiki/vimwiki'                          " Vim WiKi
Plug 'tpope/vim-markdown'                       " Markdown highlighting. Primarily to highligh blocks of code.
" Git
Plug 'tpope/vim-fugitive'                       " Git plugin
Plug 'junegunn/gv.vim'                          " Git log :GV :GV! :GV?
Plug 'airblade/vim-gitgutter'                   " Git vertical status bar at left with changes
Plug 'lambdalisue/fern-git-status.vim'          " Git status for a file in Fern 
" Colors
Plug 'arcticicestudio/nord-vim'                 " Color schema Nord: https://www.nordtheme.com/docs/ports/vim/installation/
"Plug 'skammer/vim-css-color'                    " Detect HEX colors and change background behind them

" Initialize plugin system
call plug#end()

set encoding=utf-8
filetype plugin indent on                       " enable plugin and indent
syntax on
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨ " make control characters visible
"set list                                        " show special characters
set showbreak=↪\ 
set nu rnu                                      " line numbers and relative numbering
set colorcolumn=120                             " vertical bar at 120 charaters
highlight ColorColumn ctermbg=darkgray          " Show vertical line at 120 chars mark
set laststatus=2                                " more info in statusbar
set nocompatible                                " turn off vi compatibility
set backspace=start,eol,indent                  " turn off vi compatibility (continued)
"set hidden                                      " let vim switch between buffers while changes in the current buffer are not saved
set splitbelow
set splitright

" Spellchecking
set spelllang=en_us

" Colors
" TODO: Following line defines a user hightlight group that later can be activated with:
" `:match ExtraWhitespace /\s\+$/` - to use red background for all trailing whitespaces
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
colorscheme nord                                " color scheme
set background=dark

" Tabs
set nowrap
set expandtab                                   " use spaces instead of tabs
set shiftwidth=4                                " number of spaces to use for indent
set tabstop=4
set softtabstop=4                               " number of spaces to use for <Tab> in insert mode
set smarttab                                    " <Tab> in insert mode indents with spaces
set autoindent                                  " indent new lines as previous line

" Search
set ignorecase                                  " case insensitive search and completion
set hlsearch                                    " hightlight search results
set scrolloff=8                                 " number of lines before the end of the screen to scroll
set incsearch                                   " search incrementally

" Convenience with commands
set showcmd                                     " show partial command status
set wildmenu                                    " show option in bottom menu when <Tab> pressed
set wildmode=longest,full                       " show full list

" ====================
" PLUGIN CONFIGURATION
" ====================

" {{ lambdalisue/fern.vim }}

let g:fern#renderer = "nerdfont"

" {{ lambdalisue/glyph-palette.vim }}

augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  "autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" {{ itchyny/lightline.vim }}

" Git status
function! LightlineGitGutter()
    if &buftype ==# '' && exists('*GitGutterGetHunkSummary')
        let [a, m, r] = GitGutterGetHunkSummary()
        if a + m + r > 0
            return printf('+%d ~%d -%d', a, m, r)
        end
    end
    return ''
endfunction

" Shorten file name
function! LightlineShortName()
    if &filetype ==# 'fugitive' || expand('%') =~? '^fugitive:'
        return FugitiveStatusline()
    elseif &filetype ==# 'qf'
        return exists('w:quickfix_title') ? w:quickfix_title : 'quickfix'
    else
        let shortname = expand('%:~:.')
        return shortname != '' ? shortname : expand('%:~')
    end
endfunction

" Lightline configuration
let g:lightline = {
            \   'colorscheme': 'nord',
            \   'active': {
            \       'left': [['mode', 'paste'], ['shortname', 'modified'], ['fugitive', 'gitgutter' ]],
            \       'right': [['lineinfo'], ['percent'], ['filetype', 'spell', 'readonly']],
            \   },
            \   'inactive': {
            \       'left': [['shortname', 'modified']],
            \       'right': [['lineinfo' ], [ 'percent']],
            \   },
            \   'component_function': {
            \       'shortname': 'LightlineShortName',
            \       'fugitive': 'FugitiveHead',
            \       'gitgutter': 'LightlineGitGutter',
            \   }
            \ }

" {{ tpope/vim-markdown }}

let g:markdown_fenced_languages = ['html', 'css', 'python', 'bash', 'javascript']
let g:markdown_syntax_conceal = 0
"let g:markdown_minlines = 100

" Keybindings
nmap <silent> <C-L> <C-L>:nohlsearch<CR>:match<CR>:diffupdate<CR>
nmap <F2> :w<CR>
nmap <F7> :setlocal spell!<CR>
nmap <F8> :set list!<CR>
nmap <C-f> :Fern . -drawer -toggle<CR>
