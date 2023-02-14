set nocompatible
set runtimepath+=~/.vim/bundle/swift.vim
syntax on
set number
set backspace=indent,eol,start

" MARK: Plugins
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'wojtekmach/vim-rename'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'sheerun/vim-polyglot'
Plugin 'keith/swift.vim'

" Plugin 'vim-syntastic/syntastic'
" Plugin 'scrooloose/syntastic'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'rdnetto/YCM-Generator'
" --- RUST ---
" Plugin 'rust-lang/rust.vim'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'preservim/tagbar'
" Plugin 'rust-lang/rustfmt'

call vundle#end()
filetype plugin indent on    " required

" MARK: Theming
set background=dark
colorscheme gruvbox

let g:ycm_confirm_extra_conf = 0
autocmd Filetype cpp setlocal tabstop=4
autocmd Filetype c setlocal tabstop=4
autocmd Filetype h setlocal tabstop=4
autocmd FileType swift setlocal tabstop=4

" MARK: Keybaord Mappings
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Terminal Plugin Keyboard Mapping
tnoremap <C-Left> <C-W>:tabprevious<CR>
tnoremap <C-Right> <C-W>:tabnext<CR>

" MARK: Layout/Formatting
set splitbelow
set splitright

" MARK: Custom Functions
function TabTerminal()
  :execute "tabe"
  :execute "term"
  :execute "normal \<C-W>\<C-W>"
  :execute "q"	
endfunction

" MARK: Custom commands
command TTerm execute TabTerminal() 
cnoreabbrev tterm TTerm

" MARK: Syntastic Settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']
