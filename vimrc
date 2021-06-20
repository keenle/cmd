set nocompatible
" The following line causes trouble with syntax
" set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME

" 4. Fix vim-plug installation script: Do not proceed with plugins config
"    until plugins are actually installed.

" PLUGINS {{{

" let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
" if empty(glob(data_dir . '/autoload/plug.vim'))
"     silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' "     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC " endif

" First install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged' " - Avoid using standard Vim directory names like 'plugin' " Make sure you use single quotes
call plug#begin('~/.vim/plugged')

" File manager(s)
"Plug 'vimfm/vimfm.vim'                          " Vifm file manager in Vim
Plug 'lambdalisue/fern.vim'                     " File tree viewer
Plug 'lambdalisue/nerdfont.vim'                 "
Plug 'lambdalisue/fern-renderer-nerdfont.vim'   " 
Plug 'lambdalisue/glyph-palette.vim'            "
"Plug 'lambdalisue/fern-hijack.vim'              " Use Fern as default file manager
Plug 'vifm/vifm.vim'                            " File manager

" Search
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

" Terminal
Plug 'tpope/vim-eunuch'                         " Run *nix shell commans in Vim

Plug 'itchyny/lightline.vim'                    " Statusbar

" Writing
Plug 'vimwiki/vimwiki'                          " Vim WiKi
"Plug 'tpope/vim-markdown'                       " Markdown highlighting. Primarily to highligh blocks of code.
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'   " tabular is prereq. Markdown syntax and folding
Plug 'chrisbra/unicode.vim'                     " Unicode and digraphs characters handling

" Tasks
" Plug 'tbabej/taskwiki'                          " Integration with Taskwarrior

" Codding
Plug 'tpope/vim-commentary'                     " Comment stuff out. E.g. `gcc`, `gcap`, `3gcc`.
Plug 'tpope/vim-surround'                       " Surround with parantheses, brackets, quotes, tags, and more. E.g. `ysiw]`, `ysiw[`, `yss)`, `yss(`, `ds(`, `ds)`, `ysiw<b>`.
" Plug 'wellle/targets.vim'                       " more edit targets. E.g. [ or ,
" Plug 'jiangmiao/auto-pairs'                     " auto close (, {, " etc.
Plug 'tpope/vim-characterize'                   " Character decimal, octal, and hex representation. E.g. `ga`.
"Plug 'tpope/vim-repeat'                         " Proper repeat of the last <em>command</em>. TODO: Does not work for vim-surround.
Plug 'glts/vim-magnum' | Plug 'glts/vim-radical' " Magnum is prereq. for radical. `gA` - show number under cursor as dec, hex, oct, bin.
Plug 'tpope/vim-speeddating'                    " <C-A>/<C-X> to increment/decrement dates.
" TODO: Syntax
" Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " Syntax highlighting. Update parsers on update.
" Plug 'nvim-treesitter/nvim-playground'
" Plug 'uiiaoo/java-syntax.vim'                   " Better java syntax highlighting
" TODO: Snippets
" Plug 'honza/vim-snippets'
" TODO: CoC
" Plug 'neoclide/coc.nvim`
" TODO: Debugger
" Plug 'puremourning/vimspector'
" TODO: Tags
" Plug 'ludovicchabant/vim-gutentags'

" Git
Plug 'tpope/vim-fugitive'                       " Git plugin
Plug 'junegunn/gv.vim'                          " Git log :GV :GV! :GV?
Plug 'airblade/vim-gitgutter'                   " Git vertical status bar at left with changes
Plug 'lambdalisue/fern-git-status.vim'          " Git status for a file in Fern 

" Colors
Plug 'arcticicestudio/nord-vim'                 " Color schema Nord: https://www.nordtheme.com/docs/ports/vim/installation/
"Plug 'skammer/vim-css-color'                    " Detect HEX colors and change background behind them
Plug 'ap/vim-css-color'                         " Detect and show colors of her color. E.g. #FACE00

call plug#end()

" }}} PLUGINS

" BASIC SETUP {{{

" Text, Tabs and Spaces
set encoding=utf-8
syntax on
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:·,extends:⟩,precedes:⟨ " make control characters visible
"set list                                        " show special characters;
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
set colorcolumn=80                             " vertical bar at 80 characters
highlight ColorColumn ctermbg=darkgray          " Show vertical line at 120 chars mark
set laststatus=2                                " more info in status bar
set nocompatible                                " turn off vi compatibility
set backspace=start,eol,indent                  " (continued: turn off vi compatibility)
"set hidden                                      " let vim switch between buffers while changes in the current buffer are not saved
set splitbelow
set splitright
set timeoutlen=1000 ttimeoutlen=0               " eliminating delays on <Esc> in vim. More https://www.johnhawthorn.com/2012/09/vi-escape-delays/
if !has('nvim')
    set esckeys                                     " (continued: eliminating delays...)
endif
set lazyredraw                                  " no redraw during macro
set fillchars=vert:│,fold:-                     " Full vertical line as a separator

" Turn off the bell
set visualbell t_vb=                            " no visual bell and flash

" Spellchecking
set spelllang=en_us

" Search
set ignorecase                                  " case insensitive search and completion
set smartcase                                   " when search has uppercase then match case
set hlsearch                                    " highlight search results
set scrolloff=8                                 " number of lines before the end of the screen to scroll
set incsearch                                   " search incrementally

" Convenience with commands
set showcmd                                     " show partial command status in status bar
set wildmenu                                    " show option in bottom menu when <Tab> pressed
set wildmode=longest,full                       " show full list
" TODO: Undo history. Comine with mbbill/undotree plugin.
" set undofile                                    " keep undo history between file reopens

" }}} BASIC SETUP

" PLUGIN CONFIGURATION {{{
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   ignore_install = { "javascript" }, -- List of parsers to ignore installing
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = { "c", "rust" },  -- list of language that will be disabled
"   },
" }
" EOF

colorscheme nord                                " color scheme
"set background=dark                            " adjusts color scheme for dark mode; conflicts with nord

" {{ lambdalisue/fern.vim }}

let g:fern#renderer = "nerdfont"
let g:fern#default_hidden = 1

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

"let g:markdown_fenced_languages = ['html', 'css', 'python', 'bash', 'javascript']
"let g:markdown_syntax_conceal = 0
""let g:markdown_minlines = 100

" vimwiki/vimwiki
let g:vimwiki_list = [
            \{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/vimwiki/math', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/vimwiki/programing', 'syntax': 'markdown', 'ext': '.md'},
            \{'path': '~/vimwiki/linux', 'syntax': 'markdown', 'ext': '.md'}]
" links with full file name; [text](file.md) instead of [text](file)
let g:vimwiki_markdown_link_ext = 1
                     
" plasticboy/vim-markdown
let g:vim_markdown_fenced_languages = [
            \'c++=cpp', 
            \'viml=vim', 
            \'bash=sh', 
            \'ini=dosini',
            \'html=xml',
            \'xml',
            \'css',
            \'python=py',
            \'javascript=js']
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1                    " Github/Gitlab compatibility
let g:vim_markdown_autowrite = 1                                    " auto-save changes before navigating links
let g:vim_markdown_follow_achor = 1
let g:vim_markdown_emphasis_multiline = 1

" vifm/vifm.vim
" Vifm DOES NOT properly replace netrw in Vim. Details here https://github.com/vifm/vifm.vim/issues/44
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1
" let g:vifm_replace_netrw = 1

" }}}

" Keybindings
nmap <silent> <C-L> <C-L>:nohlsearch<CR>:match<CR>:diffupdate<CR>   " clean search selection
nmap <F2> :w<CR>                                                    " save buffer
nmap <F7> :setlocal spell!<CR>                                      " toggle spell check
nmap <F8> :set list!<CR>                                            " show control characters
nmap <C-f> :Fern . -drawer -toggle<CR>                              " show Fern file explorer drawer

" Edit Vim config commands
command! ConfigEdit execute ":e $MYVIMRC"
command! ConfigReload execute "source ~/.vimrc"
