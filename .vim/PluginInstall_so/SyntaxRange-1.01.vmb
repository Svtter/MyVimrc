" Vimball Archiver by Charles E. Campbell
UseVimball
finish
autoload/SyntaxRange.vim	[[[1
120
" SyntaxRange.vim: Define a different filetype syntax on regions of a buffer.
"
" DEPENDENCIES:
"
" Source:
"   http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
"
" Copyright: (C) 2012-2013 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.002	23-Apr-2013	Avoid "E108: No such variable: b:current_syntax"
"				when the (misbehaving) included syntax doesn't
"				set it. Reported by o2genum at
"				http://stackoverflow.com/a/16162412/813602.
"   1.00.001	05-Jul-2012	file creation
let s:save_cpo = &cpo
set cpo&vim

function! SyntaxRange#Include( startPattern, endPattern, filetype, ... )
"******************************************************************************
"* PURPOSE:
"   Define a syntax region from a:startPattern to a:endPattern that includes the
"   syntax for a:filetype. For the common case, this automatically ensures that
"   a contained match does not extend beyond a:endPattern (though contained
"   syntax items with |:syn-extend| break that), and that the patterns are also
"   matched inside all existing (also contained) syntax items.
"* ASSUMPTIONS / PRECONDITIONS:
"   None.
"* EFFECTS / POSTCONDITIONS:
"   Defines a syntax region synInclude{filetype} for the current buffer.
"* INPUTS:
"   a:startPattern  Regular expression that specifies the beginning of the
"		    region |:syn-start|.
"   a:endPattern    Regular expression that specifies the end of the region
"		    |:syn-end|.
"   a:filetype      The filetype syntax to use in the region.
"   a:matchGroup    Optional highlight group for the a:startPattern and
"		    a:endPattern matches themselves |:syn-matchgroup|.
"* RETURN VALUES:
"   None.
"******************************************************************************
    call SyntaxRange#IncludeEx(
    \   printf('%s keepend start="%s" end="%s" containedin=ALL',
    \       (a:0 ? 'matchgroup=' . a:1 : ''),
    \       a:startPattern,
    \       a:endPattern
    \   ),
    \   a:filetype
    \)
endfunction
function! SyntaxRange#IncludeEx( regionDefinition, filetype )
"******************************************************************************
"* PURPOSE:
"   Define a syntax region from a:regionDefinition that includes the syntax for
"   a:filetype. Use this extended function when you have multiple start- or end
"   patterns, skip patterns, want to specify match offsets, control the
"   containment, etc.
"* ASSUMPTIONS / PRECONDITIONS:
"   None.
"* EFFECTS / POSTCONDITIONS:
"   Defines a syntax region synInclude{filetype} for the current buffer.
"* INPUTS:
"   a:regionDefinition  |:syn-region| definition with at least |:syn-start| and
"			|:syn-end|.
"   a:filetype      The filetype syntax to use in the region.
"* RETURN VALUES:
"   None.
"******************************************************************************
    let l:syntaxGroup = 'synInclude' . toupper(a:filetype[0]) . tolower(a:filetype[1:])

    if exists('b:current_syntax')
	let l:current_syntax = b:current_syntax
	" Remove current syntax definition, as some syntax files (e.g. cpp.vim)
	" do nothing if b:current_syntax is defined.
	unlet b:current_syntax
    endif

    execute printf('syntax include @%s syntax/%s.vim', l:syntaxGroup, a:filetype)

    if exists('l:current_syntax')
	let b:current_syntax = l:current_syntax
    else
	unlet! b:current_syntax
    endif

    execute printf('syntax region %s %s contains=@%s',
    \   l:syntaxGroup,
    \   a:regionDefinition,
    \   l:syntaxGroup
    \)
endfunction


function! SyntaxRange#SyntaxIgnore( startLine, endLine )
    if a:startLine == a:endLine
	execute printf('syntax match synIgnoreLine /\%%%dl/', a:startLine)
    elseif a:startLine < a:endLine && a:endLine == line('$')
	execute printf('syntax match synIgnoreLine /\%%>%dl/', (a:startLine - 1))
    else
	execute printf('syntax match synIgnoreLine /\%%>%dl\%%<%dl/', (a:startLine - 1), (a:endLine + 1))
    endif
endfunction

function! SyntaxRange#SyntaxInclude( startLine, endLine, filetype )
    call SyntaxRange#Include(
    \   printf('\%%%dl', a:startLine),
    \   (a:startLine < a:endLine && a:endLine == line('$') ?
    \       '\%$' :
    \       printf('\%%%dl', (a:endLine + 1))
    \   ),
    \   a:filetype
    \)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
plugin/SyntaxRange.vim	[[[1
29
" SyntaxRange.vim: Define a different filetype syntax on regions of a buffer.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"   - SyntaxRange.vim autoload script
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.002	13-Aug-2012	Add syntax completion to :SyntaxInclude.
"	001	05-Jul-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_SyntaxRange') || (v:version < 700)
    finish
endif
let g:loaded_SyntaxRange = 1

command! -bar -range                           SyntaxIgnore  call SyntaxRange#SyntaxIgnore(<line1>, <line2>)
if v:version < 703
command! -bar -range -nargs=1                  SyntaxInclude call SyntaxRange#SyntaxInclude(<line1>, <line2>, <q-args>)
else
command! -bar -range -nargs=1 -complete=syntax SyntaxInclude call SyntaxRange#SyntaxInclude(<line1>, <line2>, <q-args>)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
doc/SyntaxRange.txt	[[[1
135
*SyntaxRange.txt*       Define a different filetype syntax on regions of a buffer.

			SYNTAX RANGE    by Ingo Karkat
							     *SyntaxRange.vim*
description			|SyntaxRange-description|
usage				|SyntaxRange-usage|
installation			|SyntaxRange-installation|
integration			|SyntaxRange-integration|
limitations			|SyntaxRange-limitations|
known problems			|SyntaxRange-known-problems|
todo				|SyntaxRange-todo|
history				|SyntaxRange-history|

==============================================================================
DESCRIPTION					     *SyntaxRange-description*

This plugin provides commands and functions to set up regions in the current
buffer that either use a syntax different from the buffer's 'filetype', or
completely ignore the syntax.

SOURCE									     *

The code to include a different syntax in a region is based on
    http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file

==============================================================================
USAGE							   *SyntaxRange-usage*

For quick, ad-hoc manipulation of the syntax withing a range of lines, the
following commands are provided:
							       *:SyntaxIgnore*
:[range]SyntaxIgnore	Ignore the buffer's filetype syntax for the current
			line / lines in [range]. (Top-level keywords will
			still be highlighted.)
			This can be a useful fix when some text fragments
			confuse the syntax highlighting. (For example, when
			buffer syntax set to an inlined here-document is
			negatively affected by the foreign code surrounding
			the here-document.)
							      *:SyntaxInclude*
:[range]SyntaxInclude {filetype}
			Use the {filetype} syntax for the current line / lines
			in [range].

			Line numbers in [range] are fixed; i.e. they do not
			adapt to inserted / deleted lines. But when in a
			range, the last line ($) is interpreted as "end of
			file".


For finer control and use in custom mappings or syntax tweaks, the following
functions can be used. You'll find the details directly in the
.vim/autoload/SyntaxRange.vim implementation file.

SyntaxRange#Include( startPattern, endPattern, filetype, ... )
			Use the {filetype} syntax for the region defined by
			{startPattern} and {endPattern}.
SyntaxRange#IncludeEx( regionDefinition, filetype )
			Use the {filetype} syntax for the region defined by
			{regionDefinition}.

EXAMPLE							 *SyntaxRange-example*

To highlight the text between the markers
    @begin=c@ ~
    int i = 42; ~
    @end=c@ ~
with C syntax, and make the markers themselves fade into the background: >
    :call SyntaxRange#Include('@begin=c@', '@end=c@', 'c', 'NonText')


To highlight inline patches inside emails: >
    :call SyntaxRange#IncludeEx('start="^changeset\|^Index: \|^diff \|^--- .*\%( ----\)\@<!$" skip="^[-+@ 	]" end="^$"', 'diff')
To install this automatically for the "mail" filetype, put above line into a
script in ~/.vim/after/syntax/mail/SyntaxInclude.vim

==============================================================================
INSTALLATION					    *SyntaxRange-installation*

This script is packaged as a |vimball|. If you have the "gunzip" decompressor
in your PATH, simply edit the *.vmb.gz package in Vim; otherwise, decompress
the archive first, e.g. using WinZip. Inside Vim, install by sourcing the
vimball or via the |:UseVimball| command. >
    vim SyntaxRange*.vmb.gz
    :so %
To uninstall, use the |:RmVimball| command.

DEPENDENCIES					    *SyntaxRange-dependencies*

- Requires Vim 7.0 or higher.

==============================================================================
INTEGRATION					     *SyntaxRange-integration*

To automatically include a syntax in a certain {filetype}, you can put the
command into a script in >
    ~/.vim/after/syntax/{filetype}/SyntaxInclude.vim
If you want to include a syntax in several (or even all) syntaxes, you can put
this into your |vimrc|: >
    :autocmd Syntax * call SyntaxRange#Include(...)
<
==============================================================================
LIMITATIONS					     *SyntaxRange-limitations*

- The original filetype's syntax may interfere with the syntax range, and vice
  versa. To define the range with high priority, the commands inject it with
  "containedin=ALL".

KNOWN PROBLEMS					  *SyntaxRange-known-problems*

TODO							    *SyntaxRange-todo*

IDEAS							   *SyntaxRange-ideas*

==============================================================================
HISTORY							 *SyntaxRange-history*

1.01    21-Nov-2013
Avoid "E108: No such variable: b:current_syntax" when the (misbehaving)
included syntax doesn't set it. Reported by o2genum at
http://stackoverflow.com/a/16162412/813602.

1.00	13-Aug-2012
First published version.

0.01	05-Jul-2012
Started development.

==============================================================================
Copyright: (C) 2012-2013 Ingo Karkat
The VIM LICENSE applies to this plugin; see |copyright|.

Maintainer:	Ingo Karkat <ingo@karkat.de>
==============================================================================
 vim:tw=78:ts=8:ft=help:norl:
