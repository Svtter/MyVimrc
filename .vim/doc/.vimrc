version 6.0
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <Plug>(neocomplcache_start_omni_complete) 
inoremap <silent> <Plug>(neocomplcache_start_auto_complete_no_select) 
inoremap <silent> <Plug>(neocomplcache_start_auto_complete) =neocomplcache#mappings#popup_post()
inoremap <silent> <expr> <Plug>(neocomplcache_start_unite_quick_match) unite#sources#neocomplcache#start_quick_match()
inoremap <silent> <expr> <Plug>(neocomplcache_start_unite_complete) unite#sources#neocomplcache#start_complete()
inoremap <silent> <S-Tab> =BackwardsSnippet()
inoremap <silent> <Plug>NERDCommenterInsert  <BS>:call NERDComment('i', "insert")
inoremap <silent> <SNR>22_AutoPairsReturn =AutoPairsReturn()
imap <C-F10> :call Link()
imap <C-F9> :call Compile()
imap <F9> :call Run()
map! <S-Insert> <MiddleMouse>
noremap  h
snoremap <silent> 	 i<Right>=TriggerSnippet()
noremap <NL> j
noremap  k
noremap  l
nmap o <Plug>ZoomWin
snoremap  b<BS>
nmap d :cs find d =expand("<cword>")
nmap i :cs find i ^=expand("<cfile>")$
nmap f :cs find f =expand("<cfile>")
nmap e :cs find e =expand("<cword>")
nmap t :cs find t =expand("<cword>")
nmap c :cs find c =expand("<cword>")
nmap g :cs find g =expand("<cword>")
nmap s :cs find s =expand("<cword>")
nnoremap   @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')
vnoremap <silent> # y?=substitute(escape(@", '.*\\/[]'), "\n", '\\n', 'g')
nmap # <Plug>MarkSearchPrev
snoremap % b<BS>%
snoremap ' b<BS>'
vnoremap <silent> * y/=substitute(escape(@", '.*\\/[]'), "\n", '\\n', 'g')
nmap * <Plug>MarkSearchNext
xmap S <Plug>VSurround
snoremap U b<BS>U
snoremap \ b<BS>\
nmap \ca <Plug>NERDCommenterAltDelims
xmap \cu <Plug>NERDCommenterUncomment
nmap \cu <Plug>NERDCommenterUncomment
xmap \cb <Plug>NERDCommenterAlignBoth
nmap \cb <Plug>NERDCommenterAlignBoth
xmap \cl <Plug>NERDCommenterAlignLeft
nmap \cl <Plug>NERDCommenterAlignLeft
nmap \cA <Plug>NERDCommenterAppend
xmap \cy <Plug>NERDCommenterYank
nmap \cy <Plug>NERDCommenterYank
xmap \cs <Plug>NERDCommenterSexy
nmap \cs <Plug>NERDCommenterSexy
xmap \ci <Plug>NERDCommenterInvert
nmap \ci <Plug>NERDCommenterInvert
nmap \c$ <Plug>NERDCommenterToEOL
xmap \cn <Plug>NERDCommenterNested
nmap \cn <Plug>NERDCommenterNested
xmap \cm <Plug>NERDCommenterMinimal
nmap \cm <Plug>NERDCommenterMinimal
xmap \c  <Plug>NERDCommenterToggle
nmap \c  <Plug>NERDCommenterToggle
xmap \cc <Plug>NERDCommenterComment
nmap \cc <Plug>NERDCommenterComment
nmap \? <Plug>MarkSearchAnyPrev
nmap \/ <Plug>MarkSearchAnyNext
nmap \# <Plug>MarkSearchCurrentPrev
nmap \* <Plug>MarkSearchCurrentNext
nmap \n <Plug>MarkClear
xmap \r <Plug>MarkRegex
nmap \r <Plug>MarkRegex
xmap \m <Plug>MarkSet
nmap \m <Plug>MarkSet
map \sc :call ConfigSymbs()  
map \sy :call SyncSource()   
map \rwp <Plug>RestoreWinPosn
map \swp <Plug>SaveWinPosn
vmap <silent> \tt :call AlignMaps#Vis("tt")
nmap \tt <Plug>AM_tt
vmap <silent> \tsq :call AlignMaps#Vis("tsq")
nmap \tsq <Plug>AM_tsq
vmap <silent> \tsp :call AlignMaps#Vis("tsp")
nmap \tsp <Plug>AM_tsp
vmap <silent> \tml :call AlignMaps#Vis("tml")
nmap \tml <Plug>AM_tml
vmap <silent> \tab :call AlignMaps#Vis("tab")
nmap \tab <Plug>AM_tab
vmap <silent> \m= :call AlignMaps#Vis("m=")
nmap \m= <Plug>AM_m=
vmap <silent> \tW@ :call AlignMaps#Vis("tW@")
nmap \tW@ <Plug>AM_tW@
vmap <silent> \t@ :call AlignMaps#Vis("t@")
nmap \t@ <Plug>AM_t@
vmap <silent> \t~ :call AlignMaps#Vis("t~")
nmap \t~ <Plug>AM_t~
vmap <silent> \t? :call AlignMaps#Vis("t?")
nmap \t? <Plug>AM_t?
vmap <silent> \w= :call AlignMaps#Vis("w=")
nmap \w= <Plug>AM_w=
vmap <silent> \ts= :call AlignMaps#Vis("ts=")
nmap \ts= <Plug>AM_ts=
vmap <silent> \ts< :call AlignMaps#Vis("ts<")
nmap \ts< <Plug>AM_ts<
vmap <silent> \ts; :call AlignMaps#Vis("ts;")
nmap \ts; <Plug>AM_ts;
vmap <silent> \ts: :call AlignMaps#Vis("ts:")
nmap \ts: <Plug>AM_ts:
vmap <silent> \ts, :call AlignMaps#Vis("ts,")
nmap \ts, <Plug>AM_ts,
vmap <silent> \t= :call AlignMaps#Vis("t=")
nmap \t= <Plug>AM_t=
vmap <silent> \t< :call AlignMaps#Vis("t<")
nmap \t< <Plug>AM_t<
vmap <silent> \t; :call AlignMaps#Vis("t;")
nmap \t; <Plug>AM_t;
vmap <silent> \t: :call AlignMaps#Vis("t:")
nmap \t: <Plug>AM_t:
vmap <silent> \t, :call AlignMaps#Vis("t,")
nmap \t, <Plug>AM_t,
vmap <silent> \t# :call AlignMaps#Vis("t#")
nmap \t# <Plug>AM_t#
vmap <silent> \t| :call AlignMaps#Vis("t|")
nmap \t| <Plug>AM_t|
vmap <silent> \T~ :call AlignMaps#Vis("T~")
nmap \T~ <Plug>AM_T~
vmap <silent> \Tsp :call AlignMaps#Vis("Tsp")
nmap \Tsp <Plug>AM_Tsp
vmap <silent> \Tab :call AlignMaps#Vis("Tab")
nmap \Tab <Plug>AM_Tab
vmap <silent> \TW@ :call AlignMaps#Vis("TW@")
nmap \TW@ <Plug>AM_TW@
vmap <silent> \T@ :call AlignMaps#Vis("T@")
nmap \T@ <Plug>AM_T@
vmap <silent> \T? :call AlignMaps#Vis("T?")
nmap \T? <Plug>AM_T?
vmap <silent> \T= :call AlignMaps#Vis("T=")
nmap \T= <Plug>AM_T=
vmap <silent> \T< :call AlignMaps#Vis("T<")
nmap \T< <Plug>AM_T<
vmap <silent> \T; :call AlignMaps#Vis("T;")
nmap \T; <Plug>AM_T;
vmap <silent> \T: :call AlignMaps#Vis("T:")
nmap \T: <Plug>AM_T:
vmap <silent> \Ts, :call AlignMaps#Vis("Ts,")
nmap \Ts, <Plug>AM_Ts,
vmap <silent> \T, :call AlignMaps#Vis("T,")
nmap \T, <Plug>AM_T,
vmap <silent> \T# :call AlignMaps#Vis("T#")
nmap \T# <Plug>AM_T#
vmap <silent> \T| :call AlignMaps#Vis("T|")
nmap \T| <Plug>AM_T|
map \Htd <Plug>AM_Htd
vmap <silent> \anum :call AlignMaps#Vis("anum")
nmap \anum <Plug>AM_anum
vmap <silent> \aenum :call AlignMaps#Vis("aenum")
nmap \aenum <Plug>AM_aenum
vmap <silent> \aunum :call AlignMaps#Vis("aunum")
nmap \aunum <Plug>AM_aunum
vmap <silent> \afnc :call AlignMaps#Vis("afnc")
nmap \afnc <Plug>AM_afnc
vmap <silent> \adef :call AlignMaps#Vis("adef")
nmap \adef <Plug>AM_adef
vmap <silent> \adec :call AlignMaps#Vis("adec")
nmap \adec <Plug>AM_adec
vmap <silent> \ascom :call AlignMaps#Vis("ascom")
nmap \ascom <Plug>AM_ascom
vmap <silent> \aocom :call AlignMaps#Vis("aocom")
nmap \aocom <Plug>AM_aocom
vmap <silent> \adcom :call AlignMaps#Vis("adcom")
nmap \adcom <Plug>AM_adcom
vmap <silent> \acom :call AlignMaps#Vis("acom")
nmap \acom <Plug>AM_acom
vmap <silent> \abox :call AlignMaps#Vis("abox")
nmap \abox <Plug>AM_abox
vmap <silent> \a( :call AlignMaps#Vis("a(")
nmap \a( <Plug>AM_a(
vmap <silent> \a= :call AlignMaps#Vis("a=")
nmap \a= <Plug>AM_a=
vmap <silent> \a< :call AlignMaps#Vis("a<")
nmap \a< <Plug>AM_a<
vmap <silent> \a, :call AlignMaps#Vis("a,")
nmap \a, <Plug>AM_a,
vmap <silent> \a? :call AlignMaps#Vis("a?")
nmap \a? <Plug>AM_a?
nmap \ihn :IHN
nmap \is :IHS:A
nmap \ih :IHS
nmap \il :IndentLinesToggle
snoremap ^ b<BS>^
snoremap ` b<BS>`
nmap cs <Plug>Csurround
nmap cM :%s/\r$//g:noh
nmap cS :%s/\s\+$//g:noh
nmap ds <Plug>Dsurround
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
nmap tl :TagbarClose:Tlist
nmap tb :TlistClose:TagbarToggle
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap <silent> <Plug>ZoomWin :set lz|sil call ZoomWin#ZoomWin()|set nolz
nnoremap <silent> <Plug>SurroundRepeat .
xnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call NERDComment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("n", "Comment")
nmap <C-k9> <Plug>MarkSearchGroup9Prev
nnoremap <silent> <Plug>MarkSearchGroup9Prev :call mark#SearchGroupMark(9, v:count1, 1, 1)
nmap <k9> <Plug>MarkSearchGroup9Next
nnoremap <silent> <Plug>MarkSearchGroup9Next :call mark#SearchGroupMark(9, v:count1, 0, 1)
nmap <C-k8> <Plug>MarkSearchGroup8Prev
nnoremap <silent> <Plug>MarkSearchGroup8Prev :call mark#SearchGroupMark(8, v:count1, 1, 1)
nmap <k8> <Plug>MarkSearchGroup8Next
nnoremap <silent> <Plug>MarkSearchGroup8Next :call mark#SearchGroupMark(8, v:count1, 0, 1)
nmap <C-k7> <Plug>MarkSearchGroup7Prev
nnoremap <silent> <Plug>MarkSearchGroup7Prev :call mark#SearchGroupMark(7, v:count1, 1, 1)
nmap <k7> <Plug>MarkSearchGroup7Next
nnoremap <silent> <Plug>MarkSearchGroup7Next :call mark#SearchGroupMark(7, v:count1, 0, 1)
nmap <C-k6> <Plug>MarkSearchGroup6Prev
nnoremap <silent> <Plug>MarkSearchGroup6Prev :call mark#SearchGroupMark(6, v:count1, 1, 1)
nmap <k6> <Plug>MarkSearchGroup6Next
nnoremap <silent> <Plug>MarkSearchGroup6Next :call mark#SearchGroupMark(6, v:count1, 0, 1)
nmap <C-k5> <Plug>MarkSearchGroup5Prev
nnoremap <silent> <Plug>MarkSearchGroup5Prev :call mark#SearchGroupMark(5, v:count1, 1, 1)
nmap <k5> <Plug>MarkSearchGroup5Next
nnoremap <silent> <Plug>MarkSearchGroup5Next :call mark#SearchGroupMark(5, v:count1, 0, 1)
nmap <C-k4> <Plug>MarkSearchGroup4Prev
nnoremap <silent> <Plug>MarkSearchGroup4Prev :call mark#SearchGroupMark(4, v:count1, 1, 1)
nmap <k4> <Plug>MarkSearchGroup4Next
nnoremap <silent> <Plug>MarkSearchGroup4Next :call mark#SearchGroupMark(4, v:count1, 0, 1)
nmap <C-k3> <Plug>MarkSearchGroup3Prev
nnoremap <silent> <Plug>MarkSearchGroup3Prev :call mark#SearchGroupMark(3, v:count1, 1, 1)
nmap <k3> <Plug>MarkSearchGroup3Next
nnoremap <silent> <Plug>MarkSearchGroup3Next :call mark#SearchGroupMark(3, v:count1, 0, 1)
nmap <C-k2> <Plug>MarkSearchGroup2Prev
nnoremap <silent> <Plug>MarkSearchGroup2Prev :call mark#SearchGroupMark(2, v:count1, 1, 1)
nmap <k2> <Plug>MarkSearchGroup2Next
nnoremap <silent> <Plug>MarkSearchGroup2Next :call mark#SearchGroupMark(2, v:count1, 0, 1)
nmap <C-k1> <Plug>MarkSearchGroup1Prev
nnoremap <silent> <Plug>MarkSearchGroup1Prev :call mark#SearchGroupMark(1, v:count1, 1, 1)
nmap <k1> <Plug>MarkSearchGroup1Next
nnoremap <silent> <Plug>MarkSearchGroup1Next :call mark#SearchGroupMark(1, v:count1, 0, 1)
nnoremap <silent> <Plug>MarkSearchGroupPrev :call mark#SearchGroupMark(v:count, 1, 1, 1)
nnoremap <silent> <Plug>MarkSearchGroupNext :call mark#SearchGroupMark(v:count, 1, 0, 1)
nnoremap <silent> <Plug>MarkSearchOrAnyPrev :if !mark#SearchNext(1,'mark#SearchAnyMark')|execute 'normal! #zv'|endif
nnoremap <silent> <Plug>MarkSearchOrAnyNext :if !mark#SearchNext(0,'mark#SearchAnyMark')|execute 'normal! *zv'|endif
nnoremap <silent> <Plug>MarkSearchOrCurPrev :if !mark#SearchNext(1,'mark#SearchCurrentMark')|execute 'normal! #zv'|endif
nnoremap <silent> <Plug>MarkSearchOrCurNext :if !mark#SearchNext(0,'mark#SearchCurrentMark')|execute 'normal! *zv'|endif
nnoremap <silent> <Plug>MarkSearchPrev :if !mark#SearchNext(1)|execute 'normal! #zv'|endif
nnoremap <silent> <Plug>MarkSearchNext :if !mark#SearchNext(0)|execute 'normal! *zv'|endif
nnoremap <silent> <Plug>MarkSearchAnyPrev :call mark#SearchAnyMark(1)
nnoremap <silent> <Plug>MarkSearchAnyNext :call mark#SearchAnyMark(0)
nnoremap <silent> <Plug>MarkSearchCurrentPrev :call mark#SearchCurrentMark(1)
nnoremap <silent> <Plug>MarkSearchCurrentNext :call mark#SearchCurrentMark(0)
nnoremap <silent> <Plug>MarkToggle :call mark#Toggle()
nnoremap <silent> <Plug>MarkAllClear :call mark#ClearAll()
nnoremap <silent> <Plug>MarkClear :if !mark#DoMark(v:count, (v:count ? '' : mark#CurrentMark()[0]))[0]|execute "normal! \<C-\>\<C-n>\<Esc>"|endif
vnoremap <silent> <Plug>MarkRegex :if !mark#MarkRegex(v:count, mark#GetVisualSelectionAsRegexp())|execute "normal! \<C-\>\<C-n>\<Esc>"|endif
nnoremap <silent> <Plug>MarkRegex :if !mark#MarkRegex(v:count, '')|execute "normal! \<C-\>\<C-n>\<Esc>"|endif
vnoremap <silent> <Plug>MarkSet :if !mark#DoMark(v:count, mark#GetVisualSelectionAsLiteralPattern())[0]|execute "normal! \<C-\>\<C-n>\<Esc>"|endif
nnoremap <silent> <Plug>MarkSet :if !mark#MarkCurrentWord(v:count)|execute "normal! \<C-\>\<C-n>\<Esc>"|endif
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nmap <SNR>18_WE <Plug>AlignMapsWrapperEnd
map <SNR>18_WS <Plug>AlignMapsWrapperStart
nmap <F3> :SrcExplToggle                "打开/闭浏览窗口
nmap <F2> :NERDTreeToggle
map <C-F10> :call Link()
map <C-F9> :call Compile()
map <F9> :call Run()
map <silent> <C-F11> :if &guioptions =~# 'm' |set guioptions-=m |set guioptions-=T |set guioptions-=r |set guioptions-=L |else |set guioptions+=m |set guioptions+=T |set guioptions+=r |set guioptions+=L |endif
map <S-Insert> <MiddleMouse>
imap S <Plug>ISurround
imap s <Plug>Isurround
imap  <Left>
inoremap <silent> 	 =TriggerSnippet()
imap <NL> <Down>
imap  <Up>
imap  <Right>
inoremap <silent> 	 =ShowAvailableSnips()
imap  <Plug>Isurround
inoremap <expr>  omni#cpp#maycomplete#Complete()
inoremap <expr> . omni#cpp#maycomplete#Dot()
inoremap <expr> : omni#cpp#maycomplete#Scope()
inoremap <expr> > omni#cpp#maycomplete#Arrow()
imap \ihn :IHN
imap \is :IHS:A
imap \ih :IHS
let &cpo=s:cpo_save
unlet s:cpo_save
set autochdir
set autoread
set background=dark
set backspace=indent,eol,start
set cmdheight=2
set completefunc=neocomplcache#complete#manual_complete
set completeopt=menuone
set cscopequickfix=s-,c-,d-,i-,t-,e-
set cscopetag
set cscopeverbose
set expandtab
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set fileformats=unix,dos,mac
set foldlevelstart=99
set guifont=YaHei\ Consolas\ Hybrid\ 10
set guioptions=aegit
set helplang=cn
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set omnifunc=omni#cpp#complete#Main
set printoptions=paper:a4
set ruler
set runtimepath=~/.vim/bundle/vundle,~/.vim/bundle/a.vim,~/.vim/bundle/Align,~/.vim/bundle/auto-pairs,~/.vim/bundle/bufexplorer.zip,~/.vim/bundle/ccvext.vim,~/.vim/bundle/cSyntaxAfter,~/.vim/bundle/indentLine,~/.vim/bundle/Mark--Karkat,~/.vim/bundle/neocomplcache.vim,~/.vim/bundle/nerdcommenter,~/.vim/bundle/nerdtree,~/.vim/bundle/OmniCppComplete,~/.vim/bundle/vim-powerline,~/.vim/bundle/repeat.vim,~/.vim/bundle/snipmate.vim,~/.vim/bundle/SrcExpl,~/.vim/bundle/std_c.zip,~/.vim/bundle/vim-surround,~/.vim/bundle/syntastic,~/.vim/bundle/tagbar,~/.vim/bundle/taglist.vim,~/.vim/bundle/TxtBrowser,~/.vim/bundle/ZoomWin,~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after,~/.vim/bundle/vundle/,~/.vim/bundle/vundle/after,~/.vim/bundle/a.vim/after,~/.vim/bundle/Align/after,~/.vim/bundle/auto-pairs/after,~/.vim/bundle/bufexplorer.zip/after,~/.vim/bundle/ccvext.vim/after,~/.vim/bundle/cSyntaxAfter/after,~/.vim/bundle/indentLine/after,~/.vim/bundle/Mark--Karkat/after,~/.vim/bundle/neocomplcache.vim/after,~/.vim/bundle/nerdcommenter/after,~/.vim/bundle/nerdtree/after,~/.vim/bundle/OmniCppComplete/after,~/.vim/bundle/vim-powerline/after,~/.vim/bundle/repeat.vim/after,~/.vim/bundle/snipmate.vim/after,~/.vim/bundle/SrcExpl/after,~/.vim/bundle/std_c.zip/after,~/.vim/bundle/vim-surround/after,~/.vim/bundle/syntastic/after,~/.vim/bundle/tagbar/after,~/.vim/bundle/taglist.vim/after,~/.vim/bundle/TxtBrowser/after,~/.vim/bundle/ZoomWin/after
set shiftwidth=4
set shortmess=atI
set smartcase
set smartindent
set smarttab
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=4
set tags=tags;
set termencoding=utf-8
set updatetime=100
set window=35
" vim: set ft=vim :
