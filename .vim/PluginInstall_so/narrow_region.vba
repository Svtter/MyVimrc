" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
doc/narrow_region.txt	[[[1
88

*narrow_region.txt*  Create a narrowed view of the buffer. Vim version 7.x  

Author       : A.Politz cbyvgmn@su-gevre.qr (g??)
Last change  : 2007-10-06
Copyright    : This script is freeware. Use it at your own risk.

==============================================================================
	     
NARROW REGION							*narrow-region*

This is the narrow-region© plugin. It really just glues some (mostly fold- )
options together and throws in some mappings.

==============================================================================

:[range]NarrowRegion
		This command does the following, with [range] defaulting to
		the current line :
		- store current folds, foldstates and foldoptions
		- delete all folds
		- setl foldopen=undo
		- setl foldclose=all
		- setl foldminlines=0
		- setl foldmethod=manual
		- fold all lines outside of range
		- setup the nice extras, see below

		It's safe to execute this command more than once, without
		using the next command first. It won't restore it's own
		settings.
		This always works on a 'per-buffer' basis.

:UnNarrowRegion
		Undo everything done above.

==============================================================================

OPTIONS							*narrow-region-options*

The global 'g:narrow_region_options' tells the plugin, what mappings,
etc. it should activate. Every char in this variable stands for one option.
This currently includes the following  : >

	':'	-	If this is included, pressing ':' as the first key on
			the commandline, will insert the range of the region.
	'c'	-	This will make ':g', ':s' and ':v' always have the
			range prepended.
	'h'	-	This one will hide the folded lines. In other words,
			it will link the hlgroup 'Folded' to 'Ignore'.

The default is ':', which is the least intrusive.The mappings and
abbreviations are <buffer> local. See also |:folddoopen| and |:folddoclosed|.

==============================================================================

LIMITATIONS AND ISSUES					*narrow-region-issues*

You can not easily widen a region, because vim automagically extends a range,
which ends in a closed fold to the end of the fold. You have 2 choices, either
'unnarrow` the region first or open the folds before you execute such a
command. On the other side, this can be and advantage : For example execute
'NarrowRegion', without a range, on a closed fold and everything else will be
hidden.
Searching is limited to the region, but you will notice, that vim moves the
cursor onto the closed folds, if they contain a match. Not really a
disadvantage!
		
==============================================================================

DISABLE						    *narrow-region-disable*
						*narrow-region-uninstall* 
To disable the plugin, drop a >
	let loaded_narrow_region = 1
in your vimrc.  To uninstall it, remove the files
	plugin/narrow_region.vim ~
	autoload/narrow_region.vim ~
	doc/narrow_region.txt ~
and update the helptags with  ... |:helptags|.

==============================================================================

HISTORY							*narrow-region-history* 

v1	*	Initial release.
		
==============================================================================
vim:tw=78:ts=8:ft=help:sts=0
plugin/narrow_region.vim	[[[1
18
" Vim plugin -- narrrow region
" Version      : 1.0
" Last change  : 2007-10-06
" Maintainer   : A.Politz <cbyvgmn@su-gevre.qr> ( g?? )

if exists('g:loaded_narrow_region')
  finish
endif

let g:loaded_narrow_region = 1

if version < 700
  echohl Error | echo "NarrowRegion: Vim 7.x required, your version is ".(version/100).".".(version%100) | echohl None
  finish
endif

com -range NarrowRegion <line1>,<line2>call narrow_region#Narrow()
com UnNarrowRegion call narrow_region#UnNarrow()
autoload/narrow_region.vim	[[[1
103
" Vim plugin -- narrrow region
" Version      : 1.0
" Last change  : 2007-10-06
" Maintainer   : A.Politz <cbyvgmn@su-gevre.qr> ( g?? )

func! narrow_region#Narrow() range
  if !exists('b:narrow_region')
    let b:narrow_region = { 'opts' : {}  }
    let b:narrow_region.opts.fdm = &l:fdm
    let b:narrow_region.opts.fen = &l:fen
    let b:narrow_region.opts.fml = &l:fml
    let b:narrow_region.opts.fcl = &fcl
    let b:narrow_region.opts.fdo = &fdo
    let b:narrow_region.foldstates = filter(map(range(1,line('$')),'foldclosed(v:val)'),'v:val > 0')
    setl fdm=manual
    setl fen
    setl fml=0
    setl fcl=all
    setl fdo=undo
  else
    call s:UnsetPlugOpts()
  endif

  let b:narrow_region.firstline = a:firstline
  let b:narrow_region.lastline = a:lastline

  normal! zE
  if a:firstline > 1 
    exec "1,".(a:firstline-1)."fold"
  endif
  if a:lastline < line('$')
    exec (a:lastline+1).",$fold"
  endif
  call s:SetPlugOpts()
endfun

func! narrow_region#UnNarrow()
  if !exists('b:narrow_region')
    return 0
  endif
  for [ o, v] in items(b:narrow_region.opts)
    exec "let &l:".o."='".v."'"
  endfor
  normal! zR
  let lnum = 0
  for l in b:narrow_region.foldstates
    if l > lnum
      silent! exec l."foldclose"
      let lnum = l 
    endif
  endfor
  call s:UnsetPlugOpts()

  unlet b:narrow_region
  return 1
endfun

func! s:SetPlugOpts( )
  if exists('g:narrow_region_options')
    let opts = g:narrow_region_options
  else
    let opts = ':'
  endif
  let range = (b:narrow_region.firstline).','.(b:narrow_region.lastline)
  for o in split(opts,'\ze')
    if o == ':'
      exec 'cnoremap <expr><buffer> : getcmdpos() == 1 ? "'.range.'":":"' 
    elseif o == 'c'
      exec 'cabbr <buffer> g '.range.'g'
      exec 'cabbr <buffer> s '.range.'s'
      exec 'cabbr <buffer> v '.range.'v'
    elseif o == 'h'
      hi! link Folded Ignore
    else
      echohl Error
      echo "Warning : Unknown option '".o."', removing it."
      if exists('g:narrow_region_options')
	let g:narrow_region_options = substitute(g:narrow_region_options,o,'','g')
      endif
      let opts = substitute(opts,o,'','g')
    endif
  endfor
  let b:narrow_region.plugopts = opts
endfun

func! s:UnsetPlugOpts()
  for o in split(b:narrow_region.plugopts,'\ze')
    if o == ':'
      cunmap <buffer> :
    elseif o == 'c'
      cunabbrev <buffer> g
      cunabbrev <buffer> v
      cunabbrev <buffer> s
    elseif o == 'h'
      hi! link Folded Folded
    endif
  endfor
endfun

func! BufIsNarrowed( ... )
  let bnr = a:0 ? a:1 : bufnr('%')
  return !empty(getbufvar(bnr,'narrow_region'))
endfun
