let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" First install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
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

Plug 'itchyny/lightline.vim'            " Statusbar
Plug 'vifm/vifm.vim'                    " File namager
Plug 'vimwiki/vimwiki'                  " Vim WiKi
Plug 'tpope/vim-fugitive'               " Git plugin
Plug 'junegunn/gv.vim'                  " Git log :GV :GV! :GV?
Plug 'arcticicestudio/nord-vim'         " Color schema Nord: https://www.nordtheme.com/docs/ports/vim/installation/
Plug 'airblade/vim-gitgutter'           " Git vertical status bar at left with changes
"Plug 'skammer/vim-css-color'            " Detect HEX colors and change background behind them

" Initialize plugin system
call plug#end()

" TODO: Following line defines a user hightlight group that later can be activated with:
" `:match ExtraWhitespace /\s\+$/` - to use red background for all trailing whitespaces
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" Color scheme
colorscheme nord
" TODO: this set background seems unnecessary
"set background=dark

" Turn off vi compatibility
set nocompatible

" Status bar config
set laststatus=2

" Basic editor setup
" Syntax
syntax on
" Internal necoding
set encoding=utf-8
" Line numbers
set nu rnu
" Vertical color bar a 120 characters
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray                              " Show vertical line at 120 chars mark
" Make control characters visible
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨
" Always show special characters
set list
set showbreak=↪\ 
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#FF0000

" Basic commands setup
" Show partial commands in status
set showcmd
" No soft word wrapping
set nowrap
" Soft wrap lines at whitespaces set linebreak
" Case insensitive search and completion
set ignorecase
" Use spaces instead of tabs
set expandtab
" Number of spaces to use for indent
set shiftwidth=4
" Number of spaces to use for Tab in insert mode
set softtabstop=4
" Tab in insert mode indents with spaces
set smarttab
" Indent new lines as previous line
set autoindent
" Hightlight search results
set hlsearch
set scrolloff=8                     " number of lines before the end of the screen to scroll
set incsearch                       " search incrementally

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

" Keybindings
nmap <silent> <C-L> <C-L>:nohlsearch<CR>:match<CR>:diffupdate<CR>

