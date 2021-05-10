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
"Plug 'vifm/vifm.vim'                            " File manager

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

" Command line
Plug 'tpope/vim-eunuch'                         " Run *nix shell commans in Vim

Plug 'itchyny/lightline.vim'                    " Statusbar

" WiKi
Plug 'vimwiki/vimwiki'                          " Vim WiKi

" Writing
Plug 'tpope/vim-markdown'                       " Markdown highlighting. Primarily to highligh blocks of code.

" Codding
Plug 'tpope/vim-commentary'                     " Comment stuff out. E.g. `gcc`, `gcap`, `3gcc`.
Plug 'tpope/vim-surround'                       " Surround with parantheses, brackets, quotes, tags, and more. E.g. `ysiw]`, `ysiw[`, `yss)`, `yss(`, `ds(`, `ds)`, `ysiw<b>`.
Plug 'tpope/vim-characterize'                   " Character decimal, octal, and hex representation. E.g. `ga`.
"Plug 'tpope/vim-repeat'                         " Propper repeat of the last <em>command</em>. TODO: Does not work for vim-surround.
Plug 'glts/vim-magnum' | Plug 'glts/vim-radical' " Magnum is prereq. for radical. `gA` - show number under cursor as dec, hex, oct, bin.
Plug 'tpope/vim-speeddating'                    " <C-A>/<C-X> to increment/decrement dates.

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

" Text, Tabs and Spaces
set encoding=utf-8
syntax on
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨ " make control characters visible
"set list                                        " show special characters
set showbreak=↪\ 
set nowrap
set expandtab                                   " use spaces instead of tabs
set shiftwidth=4                                " number of spaces to use for indent
set tabstop=4
set softtabstop=4                               " number of spaces to use for <Tab> in insert mode
set smarttab                                    " <Tab> in insert mode indents with spaces
set autoindent                                  " indent new lines as previous line
filetype plugin indent on                       " enable plugin and indent
set nu rnu                                      " line numbers and relative numbering
set colorcolumn=120                             " vertical bar at 120 charaters
highlight ColorColumn ctermbg=darkgray          " Show vertical line at 120 chars mark
set laststatus=2                                " more info in statusbar
set nocompatible                                " turn off vi compatibility
set backspace=start,eol,indent                  " (continued: turn off vi compatibility)
"set hidden                                      " let vim switch between buffers while changes in the current buffer are not saved
set splitbelow
set splitright
set timeoutlen=1000 ttimeoutlen=0               " eliminating delays on <Esc> in vim. More https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set esckeys                                     " (continued: eliminating delays...)

" Spellchecking
set spelllang=en_us

" Colors
" TODO: Following line defines a user hightlight group that later can be activated with:
" `:match ExtraWhitespace /\s\+$/` - to use red background for all trailing whitespaces
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
colorscheme nord                                " color scheme
set background=dark

" Search
set ignorecase                                  " case insensitive search and completion
set smartcase                                   " when search has uppercase then match case
set hlsearch                                    " highlight search results
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

" Custom commands
command! ConfigEdit execute ":e $MYVIMRC"
command! ConfigReload execute "source ~/.vimrc"
