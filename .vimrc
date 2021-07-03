 " -------------------- Install vim-plug first --------------------------
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" -----------------------------------------------------------------------
"
"НАСТРОЙКИ ВНЕШНЕГО ВИДА И БАЗОВЫЕ НАСТРОЙКИ РЕДАКТОРА------------------------
set nocompatible " отключить режим совместимости с классическим Vi
set scrolloff=3 " сколько строк внизу и вверху экрана показывать при скроллинге
set background=dark " установить цвет фона (темный)
set termguicolors   " активировать цвета для полной поддержки тёмной темы
syntax on " подсветка синтаксиса
set number " показывать номера строк
set relativenumber " относительная нумерация строк
set wrap " (no)wrap - динамический (не)перенос длинных строк
set linebreak " переносить целые слова
set showcmd " показывать незавершенные команды в статусбаре (автодополнение ввода)
set mps+=<:> " показывать совпадающие скобки для HTML-тегов
set showmatch " показывать первую парную скобку после ввода второй
set autoread " перечитывать изменённые файлы автоматически
set t_Co=256 " использовать больше цветов в терминале
set confirm " использовать диалоги вместо сообщений об ошибках
set clipboard=unnamed " во избежание лишней путаницы использовать системный буфер обмена вместо буфера Vim
set whichwrap=b,<,>,[,],l,h " перемещать курсор на следующую строку при нажатии на клавиши вправо-влево и пр.  set virtualedit=all " позволяет курсору выходить за пределы строки
set keymodel=startsel,stopsel "shift+стрелки - переходит в режим выделения
set hidden " не выгружать буфер когда переключаешься на другой
set mouse=a " включает поддержку мыши при работе в терминале (без GUI) (работает из коробки)
au BufWinLeave *.* silent mkview " при закрытии файла сохранить 'вид'
au BufWinEnter *.* silent loadview " при открытии - восстановить сохранённый
set backspace=indent,eol,start " backspace обрабатывает отступы, концы строк
set sessionoptions=curdir,buffers,tabpages " опции сессий - перейти в текущую директорию, использовать буферы и табы
set noswapfile " не использовать своп-файл (в него скидываются открытые буферы)
set browsedir=current
"set visualbell " вместо писка бипером мигать курсором при ошибках ввода
"set backup " включить сохранение резервных копий
"autocmd! bufwritepre * call BackupDir() " сделаем резервную копию перед записью буфера на диск
set title " показывать имя буфера в заголовке терминала
set history=128 " хранить больше истории команд
" При вставке фрагмента сохраняет отступ
set pastetoggle=
"подсвечивает все слова, которые совпадают со словом под курсором.
"autocmd CursorMoved * silent! exe printf("match Search /\\<%s\\>/", expand('<cword>'))
set spell spelllang=ru,en
"set spell spelllang=ru_ru " Проверка орфографии русс.яз
set spellfile=~/.vim/spell/ru.utf-8.add " папка для русского словаря 
" активация обертки для SQL>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nnoremap <leader>xc :r !mysql -uroot -psomepass -h somehost.com <<< `cat %` \| column -t<cr>
"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"" Подсвечивать табы и пробелы в конце строки-----------------------------
set list " включить подсветку
set listchars=tab:>-,trail:- " установить символы, которыми будет осуществляться подсветка
"Проблема красного на красном при spellchecking-е решается такой строкой в .vimrc
highlight SpellBad ctermfg=Black ctermbg=Red
"------------------------------------------------------------------------

"" Удалить пробелы в конце строк (frantsev)
function! RemoveTrailingSpaces()
   normal! mzHmy
   execute '%s:\s\+$::ge'
   normal! 'yzt`z
endfunction
"------------------------------------------------------------------------

"типо выравниватель по табу выделенных строк
set shiftround
"------------------------------------------------------------------------

"НАСТРОЙКИ ПОИСКА ТЕКСТА В ОТКРЫТЫХ ФАЙЛА
set ignorecase " ics - поиск без учёта регистра символов
set smartcase " - если искомое выражения содержит символы в верхнем регистре - ищет с учётом регистра, иначе - без учёта
set nohlsearch " (не)подсветка результатов поиска (после того, как поиск закончен и закрыт)
set incsearch " поиск фрагмента по мере его набора
" поиск выделенного текста (начинать искать фрагмент при его выделении)
vnoremap <silent>* <ESC>:call VisualSearch()<CR>/<C-R>/<CR>
vnoremap <silent># <ESC>:call VisualSearch()<CR>?<C-R>/<CR>
"---------------------------------------------------------------------------

"НАСТРОЙКИ СВОРАЧИВАНИЯ БЛОКОВ ТЕКСТА (фолдинг)----------------------------
set foldenable " включить фолдинг
set foldmethod=syntax " определять блоки на основе синтаксиса файла
set foldmethod=indent " определять блоки на основе отступов
set foldcolumn=3 " показать полосу для управления сворачиванием
set foldlevel=2 " Первый уровень вложенности открыт, остальные закрыты
set foldopen=all " автоматическое открытие сверток при заходе в них
set tags=tags\ $VIMRUNTIME/systags " искать теги в текущй директории и в указанной (теги генерируются ctags)

 

"НАСТРОЙКИ ОТСТУПА----------------------------------------------------------
set shiftwidth=4 " размер отступов (нажатие на << или >>)
set tabstop=4 " ширина табуляции
set softtabstop=4 " ширина 'мягкого' таба
set autoindent " ai - включить автоотступы (копируется отступ предыдущей строки)
"set cindent " ci - отступы в стиле С
set expandtab " преобразовать табуляцию в пробелы
set smartindent " Умные отступы (например, автоотступ после {)
" Для указанных типов файлов отключает замену табов пробелами и меняет ширину отступа
" au FileType crontab,fstab,make set noexpandtab tabstop=8 shiftwidth=8
"--------------------------------------------------------------------------------------


"ВКЛЮЧЕНИЕ АВТОДОПЛНЕНИЯ ВВОДА (omnifunct) Ctrl+x, Ctrl+o
autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType tt2html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
" Опции автодополнения - включаем только меню с доступными вариантами
" автодополнения (также, например, для omni completion может бы
" окно предварительного просмотра).
"set completeopt=menu
"----------------------------------------------------------------------------


"НАСТРОЙКИ ПЕРЕКЛЮЧЕНИЯ РАСКЛАДОК КЛАВИАТУРЫ
"" Взято у konishchevdmitry
set keymap=russian-jcukenwin " настраеваем переключение раскладок клавиатуры по <C-^>
set iminsert=0 " раскладка по умолчанию - английская
set imsearch=0 " аналогично для строки поиска и ввода команд
highlight lCursor guifg=NONE guibg=Cyan
" По идее эта команда должна понимать раскладку клавы - и это работает!!!!
" set langmap=!\\"№\\;%?*ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;!@#$%&*`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<> 

imap <F3> 
cmap <F3> 
"--------------------------------------------------------------------------------


"""" НАСТРОЙКИ ГОРЯЧИХ КЛАВИШ """"

" F2 - сохранить файл
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

" замена <C-y>, на hh
imap hh <C-y>,

" Автоматически перечитывать конфигурацию VIM после сохранения
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" скопировать в системный буфер обмена выделенный текст
vmap <С-F5>  "+y
" выделить все и скопировать в системный буфер обмена
map <S-F5> :%y+<cr> 

nmap L $
nmap H 0
vmap L $
vmap H 0

"из режима редактирования переводит в нормальный режим ----- 
inoremap jj <Esc>   

" авто-закрытие фигурных скобок
inoremap {<CR>      {}<Left><CR><CR><Up><TAB>

" закрытие парного тега, добавление между тегами строки
imap gg  <CR><UP><END><CR>

" move vertically by visual line with j and k
nnoremap j gj
nnoremap k gk
""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""" Pluginstall >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.vim/plugged')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'othree/html5.vim' " должен улучшать работу с html5 - отступы не работают
Plug 'ap/vim-css-color' " подсвечивает цвета в ЦСС сроках - да)
Plug 'hail2u/vim-css3-syntax' " по идее должен облегчать работу с ЦСС..но нет(((
Plug 'mattn/emmet-vim' " клёвый ускоритель работы с тегами
Plug 'alvan/vim-closetag' " автозакрытие парных тегов
Plug 'tpope/vim-surround' " Клевый плагин для окружения скобками, кавычками и прочим
Plug 'vim-airline/vim-airline-themes' " поддержка тем для airline
"Plug 'terryma/vim-multiple-cursors'   " одновременное редакитроваие слов
Plug 'mhinz/vim-startify' " стартовый экран vim
Plug 'thaerkh/vim-indentguides' " Табы подсвечивает черточкам
Plug 'scrooloose/syntastic' " Асинхронная подсветка ошибок кода
Plug 'joereynolds/SQHell.vim' " плагин обёртка для SQL
Plug 'mechatroner/rainbow_csv' " подсветка синтаксиса для обычных файлов с данными
Plug 'sukima/xmledit' " Для редаки=тирования XML
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""colorschemes "
Plug 'seesleestak/duo-mini'
Plug 'sainnhe/vim-color-forest-night'
Plug 'sainnhe/sonokai'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'sainnhe/edge'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'pineapplegiant/spaceduck'
Plug 'ghifarit53/tokyonight-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'sainnhe/gruvbox-material'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Плагины для питона"""""""""""""""""""""""""""""""""""""
" Plug 'tpope/vim-commentary' " что-то для комментариев
" Plug 'numirias/semshi' " подсветка кода питона 
" Plug 'Vimjas/vim-python-pep8-indent' " типод ля правильных отступов
" Plug 'w0rp/ale' " для асинхронной проверки на ошибки в коде
" Plug 'neoclide/coc.nvim' " типо автодополнение кода но херня
" Plug 'dense-analysis/ale'
" Plug 'jpalardy/vim-slime', { 'for': 'python' } " Открывает питон в новом окне
" конец плагинов для питона""""""""""""""""""""""""""

call plug#end()
"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" ДОПНАСТРОЙКА ПЛАГИНОВ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
" Открывает NERDtree по Ctrl+t---------------------------
" nmap <F8> :TagbarToggle<CR> "вроде бы и так работает
map <C-t> :NERDTreeToggle<CR>
"--------------------------------------------------------
"--------Настройки Airline--------------------
let g:airline_powerline_fonts=0
let g:airline#enable#fugitive=1
let g:airline#enable#syntastic=1
let g:airline#enable#bufferline=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extension#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:%{kite#statusline()}
"""let g:airline_theme= 'hybrid' 
"let g:airline_theme= 'onedark'
let g:airline_theme= 'distinguished' 
"let g:airline_theme= 'fruit_punch'
"let g:airline_theme= 'alduin'
"let g:airline_theme= 'atomic'
"let g:airline_theme= 'base16_ashes'
"let g:airline_theme= 'base16_oceanicnext'
"let g:airline_theme= 'biogoo'
"let g:airline_theme = "tokyonight"

"-----------------------------------------
" Немножечко настройка тем--------------------
"let g:edge_style = 'neon'
"let g:edge_disable_italic_comment = 1
"colorscheme edge
"--------------------------------------------
" the configuration options should be placed before `colorscheme sonokai`
"let g:sonokai_style = 'maia'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1
"colorscheme sonokai
"--------------------------------------------
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"colorscheme OceanicNext
"-------------------------------------------
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight

"-------------------------------------------
"colorscheme duo-mini
"colorscheme forest-night
"colorscheme hybrid_material
"colorscheme nord
"colorscheme dracula
colorscheme gruvbox-material
"colorscheme spaceduck
"colorscheme palenight

"---------------------------------------------
" Фикс неподсветки кода для плагина vim-css3-syntax
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END
""""""""""""""""""""""""""""""""""""""""
""""""""""" Закладки на стартовом экране
let g:startify_bookmarks = ['~/.vimrc', '~/www/статьи кск/news.html']
"-------------------------------------------------------------------
 " Хоткеи для mutliple-cursor
"let g:multi_cursor_use_default_mapping=1
" Default multicursor mapping
"let g:multi_cursor_start_word_key      = '<C-n>' 
"let g:multi_cursor_select_all_word_key = '<A-n>' 
"let g:multi_cursor_start_key           = 'g<C-n>'
"let g:multi_cursor_select_all_key      = 'g<A-n>'
"let g:multi_cursor_next_key            = '<C-n>'
"let g:multi_cursor_prev_key            = '<C-p>'
"let g:multi_cursor_skip_key            = '<C-x>'
"let g:multi_cursor_quit_key            = '<Esc>'

"----------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '|'
hi IndentGuidesEven ctermbg=darkgrey

"------------------------------------------------------
"Recommended settings syntastic ---->>>>>>>>>>>>>>>>>>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"--------------------------------<<<<<<<<<<<<<<<<<<<<<
" ALE autocomletion with omni-completion""""""""""""""
" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
"let g:ale_completion_enabled = 1

"set omnifunc=ale#completion#OmniFunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:slime_target = "vimterminal" " Помощь плагину vim-slime
"let g:slime_vimterminal_cmd = "python"
" --------------------------------------------------
" донастройка hellsql
let g:sqh_connections = {
    \ 'default': {
    \   'user': 'root',
    \   'password': 'testing345',
    \   'host': 'localhost'
    \},
    \ 'live': {
    \   'user': 'root',
    \   'password': 'jerw5Y^$Hdfj',
    \   'host': '46.121.44.392'
    \}
\}
"---------------------------------------------------------------
" Конец донастройки плагинов<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
