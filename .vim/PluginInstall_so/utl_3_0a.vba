" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
if exists ("utl_rc_vim") | if filereadable(utl_rc_vim) | let fl=readfile(utl_rc_vim, "b") | call writefile(fl, fnamemodify(utl_rc_vim,":p:h").'/utl_old_rc.vim', "b") | else | echo 'not readable' | endif | endif | UseVimball
call utl_lib#Postinstall()  | finish
doc/utl_usr.txt
2194
*utl_usr.txt* Plugin for executing URLs in plain text files
*utl* *utl-plugin* 
Version Utl v3.0a ALPHA, for Vim version 7, 2008-07-31


		       Utl.vim User Manual

			 By Stefan Bittner
			stb@bf-consulting.de

	Contents:

		1. Intro........................|utl-intro|
		2. Getting started..............|utl-start|
		3. Tutorial.....................|utl-tutorial|
		4. Smart Samples................|utl-smartSamples|
		5. Usage Patterns...............|utl-usagePatterns|
		6. Tips, details, pittfalls.....|utl-tipsDetails|
		7. Configuration and Options....|utl-config|
		8. Changes since Utl v2.0.......|utl-changes|
		9. Todo.........................|utl-todo|
	       10. Credits......................|utl-credits|


See http://vim.sf.net/script.php?script_id=293 for getting and installing
Utl.vim.

See |utl-changes| for things that have changed in this version.

Any comments, bug reports, patches, fixes and suggestions are welcome.

Happy linking,
Stefan Bittner <url:mailto:stb@bf-consulting.de>


==============================================================================
1. Intro						*utl-intro*

What is Utl.vim?

It brings the benefits of URL-based hyperlinking to plain text, extending the
URL syntax for plain text needs, in accordance with the RFC 2396 (towards
current RFC 3986) URL specification.

Keywords: Hypertext, URL, URI, email, footnotes, Wiki.

Usages:
- Open any URLs found in text with appropriate handler
- Open files of any media type from within Vim (.pdf, .jpg, etc)
- Small helper utilities via embedded Vimscript
- Project management
- Organizing ideas
- Commenting source code
- Personal Wiki
- Editing HTML

Characteristics:
- Well documented and helpful verbose mode
- Is easy to get started
- Stays out of the way, no side effects
- Extensible

Now lets dive into the live examples.


=============================================================================
2. Getting started				*utl-start* *utl-getStarted*

Utl.vim's basic command to open an URL is :Utl . That's all you need!

Live Examples now!!!

Position the cursor on the next line:
    <url:#r=here>
Then type the comamnd  :Utl . This should take you ...
    id=here.

You just executed your first link!
`#r=abc' refers to a position in the document, that looks like `id=abc'. (If
you know HTML: that's analogues to a <A HREF="#abc"> which refers to
ID="abc".) The `r' in the expression stands for `reference'.

Executing  :Utl  on <url:#tn=some text> takes you to ...
						        some text.

The special syntax `tn=' just means that the target of the link is defined by
searching the denoted string 'some text' in forward direction (tn stands for
Text Next). You can omit the `tn=' prefix and just write <url:#some text>
because the tn= is the default prefix.

Executing  :Utl  on <url:../plugin/utl.vim> takes you to the file utl.vim.

Please come back here again after having executed the link!

Executing  :Utl  on <url:../plugin/utl.vim#tn=thanks for> takes you to a
specific position in the file utl.vim. This example can be seen as the
combination of the two previous examples: URL + #xxx

The #xxx suffix is called a fragment expression in URL lingo.

Executing  :Utl  on <url:http://www.vim.org> will invoke your web browser with
that URL. Just try it, if you are lucky Utl.vim already knows how to open web
pages, else Utl.vim will assist you to set up your favorite browser.

You can leave away the <url:...> embedding. Try for example:

    http://www.vim.org

or even

    www.vim.org

An advantage of embedding-less links is that normally you will find URLs in
given documents in this form. Furthermore the <url:...> embedding can be a bit
clunky. The disadvantage is that there is no safe parsing for "naked" URLs and
as one consequence of this, no syntax highlighting.

The above utl.vim link without embedding reads:
    ../plugin/utl.vim
For some file in the same directory as the current file you would have:
    ./someFile.txt
or, a file without a suffix:
    otherFile
or
    WikiWord
This means that you can use Utl.vim to turn Vim into your personal Wiki.
There a specialized Vim plugins (vimwiki, potwiki.vim), but people
told me the linking (and document creation) feature already does a good part
of the job.

Utl.vim supports links that could be called reference style links or just
footnotes. Position the cursor on the [10] in the next line and execute :Utl :

    The software can be downloaded from [10]
    .
    .
    [10] http://www.vim.org/download.php

One often encounters such references in given text. So Utl.vim does not invent
a new syntax but just supports what is there. (The same is actually true for
the for the URL based links.)

From now on I will use those [] -footnotes :-) 

You can also type an URL in the command line:

    :Utl openLink ../plugin/utl.vim	# Open file that is in same directory
					# as current file
or in short form

    :Utl ol ../plugin/utl.vim	    # same as above

Other 
    :Utl ol www.google.com	    # Open web page from within vim. Sometimes faster
				    # faster than from desktop.

If you feel it's now time for a "hello world" test, just go ahead and write
your own links. There is no meta data and no tags file needed. Its nothing
but plain text.

Before you seriously start using Utl.vim it is recommended to continue with
reading the next chapter, 3, Tutorial. If you are in doubt if Utl is valuable
for you, have a look at chapter 5, Examples of use, |utl-examples| first.


==============================================================================
3. Tutorial						*utl-tutorial*


3.1 Forth and back					*utl-tutforthback*

From the previous chapter you already know how to follow links by executing
:Utl  for links under the cursor.

The following link, as you know, takes you to another file:

    <url:../plugin/utl.vim>

Try this now! ... No, Wait! To come back here again, just use the regular
vim command CTRL-O. That's the BACK-Button in the "Vim browser" - and it might
need to be typed more than once.
Now do it! 

Hope you are back again.


3.2 Relative and absolute URLs				*utl-tutrelabs*

The following URLs are all equivalent:

    <url:utl_usr.txt>
    <url:./utl_usr.txt>
    <url:../doc/utl_usr.txt>

These are all so called relative URLs. This means that the path given in the
URL is relative to the path of the document containing the URL. NOte that this
is different to Vim's :e command where file names are relative to the current
working directory (see |:pwd|). Whenever possible you should use relative
URLs. But sometimes you need absolute URLs, just as you sometimes need
absolute path names with Vim's :e command. Here is an absolute URL:

    <url:file:///home/stb/.vim/plugin/utl.vim>

An absolute URL always has a so called scheme (also called protocol) in
front, e.g. file: , http:, mailto: . (And, if there is a protocol in front it
always is an absolute URL.) What also makes sense is to write the above URL
without the protocol:

    <url:/home/stb/.vim/plugin/utl.vim>	    # equivalent to above

This is a relative URL (because there is no protocol) ... containing an
absolute path. The contrary does not make sense: An absolute URL with a
relative path:

    <url:file:../plugin/utl.vim>    # WRONG!!! Absolute URL with relative path
				    #	       is an invalid URL.

When you try to execute this URL, the current implementation of Utl.vim opens
a file  utl.vim  in the current working directory - not a good behavior
for an URL.


3.3 Running Utl.vim in verbose mode			*utl-tutverbosemode*

Utl.vim supports a verbose mode:

    :let utl_opt_verbose=1	# Switched on
    :let utl_opt_verbose=0	# Switched off (default)

Verbose mode can be very useful to figure out what's going on. For instance
for the previous section you can see the different processing between absolute
and relative URLs and how the latter are turned into absolute URLs by
constructing a base URL. Try for example to execute:

    <url:../plugin/utl.vim>

with verbose mode switched on. Don't forget to use this feature when things
get more complicated!


3.4 Drive letters and network shares			*utl-tutdrivesshares*

Under Windows you can specify drive letters like this:

    <url:file://d:/path/to/foo.txt> or, which is the same,
    <url://d:/path/to/foo.txt>

This is in conformance with URL specifications. Note that you always should
use forward slashes, no matter on what OS you are; URLs are universal and thus
independent of the OS.

Utl supports notation for network file access, e.g. Shares under
Windows, NFS under Unix.

Windows Example: Utl converts <url://127.0.0.1/ADMIN$/System32/EULA.txt>
internally into the UNC path \\127.0.0.1\ADMIN$\System32\EULA.txt, which is
directly passed/edited to/by Vim, since SMB shares are transparent under
Windows.

Unix Example: Utl converts <url://server/sharefolder/path> internally
into  server:/sharefolder/path . (Don't really know if this makes
sense :-)

Windows Examples:
<url://89.11.11.11/testinput/cfg/sid_7_configuration_list.txt>
<url://56.240.74.41/c$/install_pers/setup.log>

Utl does neither care if authentication is needed on the server resource nor
does it offer direct means for authentication [20].


3.5 Fragments						*utl-tutfrags*

--- Intro						*utl-tutfragsintro*

Now lets add fragments to URLs.
The next link again references the same file as in the above examples, but is
extended by a fragment expression. That way a specific position in the target
file can be jumped to. Try to execute the link:

    <url:../plugin/utl.vim#tn=thanks for>

and come back again with CTRL-O. The next link specifies the same file, but
the fragment expression is different:

    <url:../plugin/utl.vim#r=foot1>

Execute it and come back again! It took you to about the same position as the
previous link, but by other means. The fragment `#r=foot1' means, that the
file utl.vim is searched for the ID reference `foot1'. What follows r=
should be a simple string (an identifier to be exact).

The #tn fragment has one big advantage over #r= fragments. It allows to
refer to specific positions in the target document without the need to
modify that target document, either because you don't want it or because you
don't have write access. The advantage of the ID reference fragment is that
the link is more robust.

#tn= and #r= are the most important fragment specifiers in Utl.vim. As
already said, the #tn= prefix is the default prefix, i.e. you can leave it
away. Thus the link above will normally be written shorter:

    <url:../plugin/utl.vim#thanks for>

This is also called a naked fragment identifier because there is no `key='
prefix. 

The found string will _not_ get the current search string (I don't know why).
This means it will not be highlighted and you cannot search the next
occurrence with Vims  n  command. But the string is one up in the search
history, so you can recall it from there.


--- Line fragment and bottom up addressing		*utl-tutfragsline*

Another fragment identifier is #line. It positions to the given line,
e.g. 

    <url:utl_usr.txt#line=10>	(or #line=+10)

This is useful for documents that won't change much. Negative numbers
can be given as well:

    <url:utl_usr.txt#line=-10>

This counts the lines from bottom of the buffer upwards, -1 specifies
the last line. For the #tn identifier there is also a "bottom-up" possibility,
the #tp identifier. Try and compare these two:

    <url:utl_usr.txt#tp=vim>
    <url:utl_usr.txt#tn=vim>


--- Relative addressing					*utl-tutfragsrel*

So far all fragment addressing was relative from top or bottom of the buffer.
It can also be relative to the current cursor position in two cases:

a) Same-document references				*utl-tutfragsdref*

These are URLs that only consists of a fragment. Examples:

    <url:#line=3>
    <url:#line=-3>
    <url:#tn=fragment>
    <url:#tp=relative>

Same document references are often useful, for instance to turn phrases like
"see above" into hotlinks. NOte that for an #r= -reference, see
<#tp=ID Reference>, there is no relative addressing because only one id=
target per file is assumed.

b) Non file oriented resources and the Vimhelp scheme	*utl-tutfragsnonfile*

The best example is the Vimhelp scheme, e.g. <url:vimhelp::ls> (which is
hereby introduced). When you execute this URL the Vim help for the  :ls
command is displayed. Although the help will normally be presented as a text
file in Vim (namely doc/windows.txt) the file is not really the resource, the
help item itself is the resource. It's often useful to use the Vimhelp URL and
sometimes especially useful to combine it with a fragment. Example:

    Readonly buffers are marked with `=', see <url:vimhelp::ls#readonly>

The utl.vim source code gives more realistic examples, see for instance
<url:../plugin/utl.vim#since a string>.

See <url:../plugin/utl.vim#r=Utl_processFragmentText> for details about
fragment processing.


3.6 Other media types					*utl-tutmtypes*

URLs are not restricted to .txt files or web pages. You can for instance
reference a PDF document:

    <url:foo.pdf>

To make this work a handler for .pdf type files has to be present. If you are
lucky Utl.vim already defined a handler for you. Utl.vim aims to provide a
generic media type handler for the most common platforms. The generic media
type handler should handle a file like the system does (e.g. left (double)
click to the file in the systems file explorer). The generic media type
handler is implemented by the Vim variable  g:utl_cfg_hdl_mt_generic .

It can be overruled by a specific media type handler. For PDF files this would
be g:utl_cfg_hdl_mt_application_pdf. See explanation under
<url:config:#r=mediaTypeHandlers> how to provide a specific handler. Normally
the generic handler will be sufficient. A specific handler is needed for instance
if fragments should be handled (see |utl-tutextfrag|). 

It is a good idea to test with verbose mode switched on if you want to
define a specific media type handler If none of the handlers (specific and
generic) is present, Utl.vim will try to make creation of a handler as
painless as possible through a smart setup facility which is invoked
automatically then [22].


3.7 Link to folders					*utl-tutfolders*

An URL can also specify a folder:

    <url://c:/Program Files>	    # Windows
    <url:/usr/local/bin>	    # Unix
    <url:./tmp>
    <url:.>

Folders also have a media type associated: text/directory. This means
the specific or the generic media type handler has to be present to open
a folder-URL. Utl.vim predefines the specific handler. The definition is:

    :let g:utl_cfg_hdl_mt_text_directory='VIM'

The special value 'VIM' means that no external handler shall be called but the
folder should be opened by (the current) Vim, which will use Vim's built in
netrw directory browser. The special value 'VIM' can also be used for all
other utl_cfg_hdl_mt_xxx handlers. Try to execute <url:.> to see how that
works.

But what if you want to open a directory not with Vim but rather with the file
explorer of your system? Well, that is easy if your generic handler is set
up [23]:

    :let g:utl_cfg_hdl_mt_text_directory=g:utl_cfg_hdl_mt_generic

Another possibility is to open a directory in a command-shell, i.e.
open a shell with CWD set to the directory. Can be achieved by:

    :let g:utl_cfg_hdl_mt_text_directory__cmd = ':!start cmd /K cd /D "%P"' " Windows (DOS box)
    :let g:utl_cfg_hdl_mt_text_directory__cmd = ':!bash ... " Unix

Unfortunately Utl.vim does not provide a means to dynamically choose one of
these handlers, i.e. open one directory in Vim, the other in the systems
explorer, the next in a command shell. But there is a workaround: Define
mappings for the above assignments. See <url:config:r=#map_directory> for
suggested mappings.


3.8 Typing an URL					*utl-tuttypeurl*

In a web browser there are two ways to go to a page:
- You follow a hyperlink from the page you are in.
- You type an URL in the address field.

Possibility 1 corresponds to ':Utl' in Utl.vim. Possibility 2 corresponds to
the command. Examples:

    :Utl openLink ../plugin/utl.vim
    :Utl openLink www.vim.org

You can use this for editing another file which is in the same directory as
the current file. Example:

    gvim /really/an/annoying/long/path/to/src/main.c
    :Utl openLink option.c	" [24]

I myself use :Utl a lot for this purpose. Most often I type directory-URLs,
see previous section |utl-tutfolders|. And my favorite folder is . (dot), i.e.
the current directory:

    :Utl openLink .	    " or, shorter:
    :Utl ol .

So  :Utl ol .  opens the directory the current file is in. Either in Vim, the
systems file explorer or in the command-shell. 


3.9 The Utl user interface				*utl-tutUI*

Until now you know the commands  :Utl  (to open the URL under the cursor) and
:Utl openLink myUrl  (to open a typed URL). The general command interface is:

    :Utl <command> <operand> <mode>

:Utl (without any arguments) is the same as:

    :Utl openLink underCursor edit

since these are the default values for the three arguments. Instead  edit
which displays the file in Vim [25] with the Vim command  :edit  you might
want to open the link in a split buffer or in a new tab and so on (just as
you open files in Vim in many different ways):

    :Utl openLink underCursor split	" Open link in split window
    :Utl openLink underCursor tabe	" Open link in new tab

Try these with the URL

    <url:../plugin/utl.vim> !

Utl.vim provides command line completion for the arguments to save typing. I
recommend to set the 'wildmenu' option for enhanced completion [26]. Try:

    :Utl co<Tab>	" or
    :Utl co<CTRL-D>	" or
    :Utl<Tab>		" etc.

The completion works the like for second and third argument. Another aspect
of completion besides saving typing is that it offers the possibilities in a
menu like manner which makes it unnecessary to learn all the commands,
especially those used less frequently [27].

Additionally to completion Utl.vim supports abbreviations for the arguments.
The following are equivalent:

    :Utl openLink underCursor edit	" is same as:
    :Utl ol uc edit			" is same as:
    :Utl o u edit
 
See <url:../plugin/utl.vim#r=cmd_abbreviations> for all abbreviations and
explanation of the abbreviation rules. If you typed an abbreviation for
an argument completion does still work for further arguments, e.g.

    :Utl o u<CTRL-D>

Again, verbose mode might help to figure out what's going on when playing with
abbreviations.

One design goal of the Utl.vim user interface is to make mappings obsolete
for the most since commands are short enough. Note that you can save one
character on :Utl,

    :Ut

is possible in standard Vim 7.1 [28]. See <url:../plugin/utl.vim#r=suggested_
mappings> if you consider to use mappings anyway.


3.10 Visual URLs					*utl-tutVisUrls*

Sometimes you want to execute an URL which is different from what Utl.vim
would parse out. Examples (desired URL underlined):

    ~dp0register_packages.bat	" (Windows) file name not separated as (Utl) word
        ---------------------

    <url:./path/to/file.txt >	" Only the directory part wanted
         ---------

Visually select the URL, possibly copy to clipboard (with CTRL-C under
Windows), then execute

    :Utl openLink visual    " or, shorter
    :Utl o v		    " [29].


3.11 The Vimscript scheme				*utl-tutVimscript*

Utl.vim supports a special non standard protocol to execute Vim commands from
within a plain text document. It is introduced here because needed in the
sections which follow. The general format is:

    vimscript:<ex-command>

Try these examples:

    <url:vimscript::ls>	    " This which is the same as:
    <url:vimscript:ls>	    " (i.e. you can omitt the `:')

"Ex-command" is just the same as what you can type in an ex command line, for
instance multiple commands can be concatenated with `|'. Example:

    <url:vimscript:split|call input('I will open a new window now!')>

Certain characters needed in an ex command line will collide with characters
that have special meaning for URLs. In this case you have use normal URL percent
encoding. Example:

    <url:vimscript:call input('Hit %3creturn%3e to continue')>

The  3c  is the hex value of the  <  character, the  3e  is the hex value
of the  >  character. Just keep in mind that if an URL does not work, then try
to encode the characters appearing dangerous with percent encoding [30].

Vimscript ex commands are executed in the context of a function (namely
the handler, <../plugin/utl_scm.vim#r=vimscript>). This has the implication
that global variables must be prefixed with g:

See |utl-smartsamples|for more vimscript examples. 


3.12 Other commands and options to operate on an URL	*utl-tutOtherCmds*

COPYLINK						*utl-tutCopyLink*

Until now we always opened (displayed) the target of an URL, i.e. jumped to
the URL. You can also copy the link to the clipboard:

    :Utl copyLink	" or, shorter
    :Utl cl

This does the same as the right mouse popup function called 'copy link
address' or so in web browser. Try for instance  :Utl cl  on

    <url:../plugin/utl.vim>  and

check the * register by executing

    <url:vimscript::reg *>.

NOte that the register contains an absolute URL, not a relative one. Copying
links is often useful, for instance to email a link address to someone.

Another nice usage is to open the current file in another Vim instance:

    :Utl copyLink currentFile

then switch to the other Vim instance and perform:

    :Utl openLink <URL pasted from clipboard>

This example also introduced the  currentFile  operand (you already know
underCursor, visual, <typed URL>).


COPYFILENAME						*utl-tutCopyFileName*

Related to copyLink is copyFileName

    :Utl copyFileName	    " or, shorter
    :Utl cf

which copies the full path to the clipboard. Try the URL with the command
:Utl copyFileName:

    <url:../plugin/utl.vim>

and check the * register. Usage example: use  copyFileName  for a file you
want to mail to someone as an attachment. Paste that file name in your mailer.
Probably even more interesting is the other way round: You received a
mail attachment and want to make it hot linkable from within a text file.
Create a new link in the text file, e.g.

    <url:./infos/20080523_Instructions_Workreports_ext.ppt> ,

then perform

    :Utl copyFileName 

and paste the result into the 'save as' dialog of your mailer [31]. This can
save you a lot of tedious browsing down directories in GUI programs
(especially under Windows). CopyFileName does only work for (implicit or 
explicit) file:// URLs, not for example for http:// URLs.

The file name will have slashes or back slashes depending on your system.
But you can force the one or the other (for instance if using Cygwin under
Windows):

     :Utl copyFileName underCursor backslash
     :Utl copyFileName underCursor slash

(As these are positional parameters you have to provide a second argument,
'underCursor' here).


For reference of all available commands and arguments see:

    :Utl help commands


3.13 The http scheme					*utl-tutscmhttp*

Until now we concentrated on local files. The scheme for a local file is
(implicitly or explicitly) `file', e.g. file://path/to/file. Of course
an URL can be used to retrieve other than local resources (a web page) or
other resources than files (an email). 

Depending on what you are using Utl.vim for, file  might be the most important
scheme, followed by  mail  and http . Lets consider http now.

You already know that you can execute the links:

    <url:http://www.vim.org>
    http://www.vim.org
    www.vim.org

They are all equivalent. To make a http URL with fragment work, e.g.

    http://www.vim.org/download.php#unix

the defined handler has to support that, which might not be the case in
the default setup. You have to set up a handler that supports the  %f
conversion specifier. See the hints and instructions

    <url:config:#r=schemeHandlerHttp>

how to do this. A http URL does not necessarily mean "web browser". Consider
for instance the URL:

    <url:http://www.ietf.org/rfc/rfc3986.txt>
							*utl-tutscmhttpwget*
This is a plain text document. Wouldn't it much better to display it in Vim?
Utl.vim provides interfacing to the non interactive download tool  wget . For
this purpose the handler  utl_cfg_hdl_scm_http  has to be set up as:

    :let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http__wget

    Use this vimscript service URL to do the configuration (unless you prefer
    to type it in yourself :-)
    <url:vimscript:let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http__wget>

Now try the above link with this configuration! The RFC3986 will be displayed
in Vim as a temporary file. So now you can browse the RFC3986 document
directly in Vim.

It gets even more interesting if you want to address a specific part in the
target document. Examples:

    <url:http://www.ietf.org/rfc/rfc3986.txt#^1.1.2.  Examples>
    <url:http://www.ietf.org/rfc/rfc3986.txt#line=343>

    <url:http://www.vim.org/scripts/download_script.php?src_id=3640#horizontal or vertical>

Now the ultimate combination of all techniques: retrieving a document from the
web (with wget), using an external media type handler configured in Utl.vim
for the ability to add a fragment:

    <url:http://bullium.com/support/vim.pdf#page=3>

See |utl-tutpdffrag| how to make this work. 
    
In practice the one URL you want to display with your browser, the other URL
using the wget handler. Again (like |utl-tutfolders|) no real dynamic
switching between the handlers is possible. The suggested workaround is again
to define mappings that switch between the handlers, see
<url:config:#r=map_http>.


3.13 The mail scheme					*utl-tutscmmail*

There is a special, non standard scheme for referencing specific emails
from your local mail boxes via URL. For instance, executing the link

    <url:mail:///Inbox?date=12.04.2008 15:04>

will open the so specified email in your mailer. This can be very
convenient if you are using Vim for project management, software
development, PDA etc. It helps you to have all relevant information at your
fingertips.

The only implementation of the  mail  scheme currently available is
MS Outlook (under Windows) [32]. If you use another mailer you might
consider to contribute an implementation [33]. If you don't use Outlook but
like to reference emails you can workaround: save the mail as file (.txt,
.rtf, .msg etc format) and create a link to this file.

If your mailer is MS Outlook read on.

Suppose you have an email in your Inbox, received the 2008-04-12 at 15:04
you can open the mail by executing the link (make sure that Outlook is
already running!):

    <url:mail:///Inbox?date=12.04.2008 15:04>

Currently the date is locale dependent, the above sample is for a German
Outlook. The date format is directly that of Outlook in the 'Received'
column ('Erhalten in German), but without the week day prepended. The
above can be written shorter as:

    <url:mail:///Inbox?12.04.2008 15:04>

since `date' is the default query [34]

Examples using different mail folders are:

    <url:mail:///Sent Items?12.04.2008 15:04>
    <url:mail://archive/Inbox?12.04.2008 15:04>

The form /// denotes the default folder (maybe this syntax is too Outlook
specific).


3.14 Other schemes					*utl-tutscmoth*

							*utl-tutscmothstd*
Besides file and http scheme Utl.vim currently Utl.vim supports the following
standard schemes:

    ftp:
	Delegates to http (web browser to handle this)

    https:
	Delegates to http (web browser to handle this)

    mailto:
	Delegates call to your mail client. 
	configurable by  g:utl_cfg_hdl_scm_mailto
	Mailto URL specified at <url:http://www.ietf.org/rfc/rfc2368>

	Examples:
	<url:mailto:stb@bf-consulting.de>
	<url:mailto:stb@bf-consulting.de?subject=otto&cc=karl.meier@web.de&body=test>
	<url:mailto:majordomo@example.com?body=subscribe%20bamboo-l>

    scp:
	Uses Vims netrw-Plugin, see |scp|
	configurable by  g:utl_cfg_hdl_scm_scp

	Syntax:
	<url:scp://hostname/path/to/file>

							*utl-tutscmothnonstd*
Moreover, besides mail, vimscript and vimhelp scheme Utl.vim introduces and
supports the following non standard schemes:

    man:
	Accesss manual pages via URL.
	Relies on the ManPageView plugin (:Man command) which needs to be
	installed [35].

	Example:
	<url:man:ls>

    config:
	Utl specific. Ad hoc scheme for accessing Utls setup file.
	Not really exciting.

	Examples:
	<url:config:>		(try it!)
	:Utl ol config:

    foot:	
	Interface to make footnotes accessible via URL. Normally not called
	directly but through heuristic form as has been explained at
	<url:foot:10>. This will be elaborated in the next section.


The schemes  http, mail, mailto, scp  are configurable by
utl_cfg_hdl_scm_<scheme>. All other schemes not (yet). See <url:../plugin/utl.
vim#r=spec_ihsv> for specification of that configuration interface.

You can easily implement your own schemes or define new ones. You just
implement a Vim function somewhere. Utl.vim dynamically calls those functions.
Have a look at <url:../plugin/utl_scm.vim#r=implscmfunc> or just hack one of
the existing functions in ../plugin/utl_scm.vim.  But I recommend that you
read chapter 5, Tips, details, pitfalls,  before you write your own scheme
handler. A common misunderstanding is to create a new scheme where support 
media type support to an existing one would be the better choice. See
|utl-privateScmHdl|for an elaborated example below.


3.15 Footnotes						*utl-tutfoot*

Now let's go into some detail with footnotes (reference style links).

As you already know (from [10]), Utl.vim supports these commonly used
references in square brackets:

    The software can be downloaded from [11]
    .
    .
    [11] http://www.vim.org/download.php

Besides given texts from elsewhere, there are some Vim plugins that create
such footnotes [36]. But AFAIK there is no tool except Utl.vim that cares
about making them executable.

Often, like in the previous example, the [] syntax is used to indirectly
reference URLs because, citing from [36_2]: "Inline URIs [...] make the text
around them obscure". Utl.vim normally does not dereference the reference
target; in the example above it does not open the http:// Link

Often [] references are used for simple footnotes:

    This is true [101] 
    .
    .
    [101] but not always

In this case () style references like (*), (1),(2) might be more common,
but this is not supported by Utl.vim.

-----
Syntax Details						*utl-tutfragsyn*

References are not restricted to numbers, you can also use mnemonics
or abbreviations like [UTL_RC]. Allowed characters inside [...] are
_, A-Z, 0-9. Amongst others this style is useful for document reference.

According to common use of references the slight syntax variations for the
reference target are supported:

    [102]	This is used most often (and in all examples so far)
    [102]:	A bit exotic, but more parse-safe [37].

NOte that  102.  (= number followed by just a point, no square brackets), is
not supported as reference target because in practice too often the wrong
target is found. The 102. form is useed by [36_2]. 

Obviously with the first form the reference source and target look the same.
And it can actually be possible to switch the roles. When searching for the
target, the source line is excluded. Often the reference target will be
located at the bottom of the text, but needs not. The reference target must
appear at the beginning of the line (after optional whitespace) [38]. ---
Don't forget to run Utl.vim in verbose mode (see |utl-tutverbosemode|) if I
confused you :-) Verbose mode also shows you the search algorithm.

-----
Footnote Fragments					*utl-tutfootfrag*

You can append a fragment to [] references. Example:

    [UTL_RC]#tn=1.3.

This will open the target of the reference, i.e. file .plugin/utl_rc.vim and
position the cursor according the fragment in this file. So adding a reference
allows you to automatically forward a [] reference. Obviously this only makes
sense if the reference target is a reference itself and not just a footnote
text. Forwarding also happens with empty fragments. Try for example to execute
this reference:

    [36_1]#

Reference fragments can be especially useful if you have more than one
references into another document, e.g. 

    [UTL_RC]#r=utl_cfg_hdl_scm_http
    [UTL_RC]#r=utl_cfg_hdl_scm_scp
    [UTL_RC]#r=utl_cfg_hdl_scm_mailto

There is no Utl.vim option or so to let you choose whether to
automatically forward or not.

Well, #-fragments appended to [] style footnotes is a new syntax introduced by
Utl, in the hope that it will be useful. 

-----
Reference Links are implemented as URLs			*utl-tutfooturl*

Inside utl.vim there is not much special treatment of [] references, they are
handled as URLs, a new non standard scheme "foot:" has been introduced. So
most of the specific code is hence in the corresponding handler outside the
kernel of utl.vim. The following Urls are equivalent: <url:foot:36> =
<url:[36]> = [36]. Again, to see what's going on internally you can the
verbose option: <url:vimscript:let g:utl_opt_verbose=1>


3.16 Fragments to external Media Type Handlers		*utl-tutextfrag*

As foretold at |utl-tutmtypes| defining a specific media type handler makes
sense if you want to address fragments in files not displayed within Vim.
Utl.vim offers limited support for PDF and MS Word documents.

-----
PDF page addressing					*utl-tutpdffrag*

You can execute an URL like

  <url:http://www.tech-invite.com/RFCs/PDF/RFC3986.pdf#page=4>

if you use Acrobat Reader to display PDF documents. Enable enable the specific
handler for media type application/pdf:

- Execute <url:config:#r=utl_cfg_hdl_mt_application_pdf__acrobat>,
- uncommment the two lines below the cursor and activate
  the change by :w , :so %
- Then look for a test PDF on you computer with a least 4 pages,
  e.g. /path/to/my.pdf
- Open this file with:
  :Utl ol /path/to/my.pdf#page=4
- follow the directives (to configure Acrobat Reader).

This can be very useful for, say, to reference technical specifications (= PDF
document) from within source code.

NOte that addressing PDF pages this is not restricted to local files. To make
the above http link work (after set up of the specific handler) you just need
to bypass your web browser (AFAIK these do not support addressing pages) and
use the wget handler as described in section |utl-tutscmhttp|.

Currently only #page= fragments are supported.

-----
MS Word text search					*utl-tutwordfrag*

Analog to PDF, to execute an URL like

    <url:my.doc#tn=textToSearch>
    <url:my.doc#textToSearch>	    (short form)

you just need to enable the specific handler for media type
application/msword:

- Execute <url:config:#r=utl_cfg_hdl_mt_application_msword__word> and
- uncommment the two lines below the cursor and activate
  the change by :w , :so %
- Then try a .doc URL (with tn= fragment) and
- follow the directives (to setup the .vbs interface and configure MS Word).

Currently only text search (#tn= fragment) is supported. 
#page= and #r= for jumping to numbered elements, section, text marks etc
would be desirable. 

Addressing fragments can be quite useful for:

- technical documentation if you use Vim for collecting and managing changes
  of your document or to use Vim as annotation system for MS Word.

- Referencing documents from within source code


3.17 Creation of URLs				    	*utl-tutcreateurls*

You might use Utl.vim mostly for "defensive" purpose: there is existing plain
text like emails (pasted into Vim or using Vim as viewer), source code,
READMEs and FAQs that contain URLs [39].

But if you use Utl.vim for your own texts, documents and source code you might
like to have ways to quickly create URLs and links. Here are some hints:

To ease creation of an URL with embedding  <url ... >  you can define mappings
in your .vimrc file ( without the trailing ">  ):

    imap xu <url:			">
    imap xuh <url:http://		">
    imap xumi <url:mail:///Inbox?	">
    imap xuh <url://c:/stb/home/	">

Another thing is to create a link to a local file or a resource which you
already have on your desktop. To create a file:// -URL for a file displayed in
Vim (same or different session) you can:
- go to the intended link target file,
- type  :Utl copyLink currentFile, 
- go to the intended link source file,
- paste from clipboard

That's all what the current version offers [40].


3.18 Miscellaneous					*utl-tutmisc*

-----
Creating files by executing a link			*utl-createFiles*

If you execute an URL which points to a non existing file, this file (firstly
its Vim buffer) will be created. This is very useful for authoring: You write
the URL in your document and then execute it. You can try this with the URL
<url:utl_foobar.txt>. 


-----
Multiline URLs						*utl-multiLineURLs*

You can spread URLs across several lines like this: <url:../plu
gin/utl_uri.vim>. This is sometimes useful for long URL, see examples
below at #r=lu. When typing an URL that Vim breaks (because it contains a
space and 'tw' option is set) you have to be careful: Utl.vim eliminates all
spaces around the line break. The above link is thus equivalent to <url:../plu
    gin/utl_uri.vim>. In order to preserve the space, you could escape it with
%20 (see |utl-uri-forbchars| about escaping), e.g. <url:this filename
    %20contains blanks.txt>. But you could also just split at another position:
<url:this filenam
    e contains blanks.txt>


-----
Tilde support						*utl-tildeSupport*

You can use the ~ (tilde) character in URLs. Example: <url:~/.vim/plugin/utl.
vim>. The ~ is replaced by the contents of the $HOME environment variable.
On Unix system ~user also works. See |$HOME|.


==============================================================================
4. Smart samples					*utl-smartSamples*

-----
Lookup word						*utl-lookupWord*

You can use Utl's web browser integration to look up the word under cursor in
the dictionary or encyclopedia of your choice with a mapping like:

    nmap ,l :exe ":Utl ol http://dict.leo.org/?search=" . expand("<cword>")

This is practical for spell checking (despite Vim built in spell checker). The
following mapping is similar:

    " Lookup of expression given on command line.
    " Of benefit because often faster than click click on desktop
    " Use %20 or \ or + to escape blanks, example:
    "		for%20that%matter
    "		for\ that\ matter 
    "		for+that+matter 
    nmap ,m :Utl ol http://dict.leo.org/?search=

is similar.


-----
Vimscript heuristic URL					*utl-vimsHeuristicUrl*

As an enthusiastic Vim user reading vim tips or receiving help by other users
you often get advices like

    To tell Vim to jump to the already open window or tab instead of
    creating a new window by some split command do:

    :set switchbuf=usetab

    See also:

    :h 'switchbuf'

With utl.vim you can execute both : lines directly. Just visually select the
line and perform the command  :Utl openLink visual  (or shorter:  :Utl ol v ).
This is implemented as a heuristic. Perform links with utl_opt_verbose=1 to
see what's going on.


-----
Using vimscript URL for backup				*utl-vimsBackup*

The following URL creates a copy of the file containing the URL under the
name <current-date>_<current_file_name> to the directory /tmp. You can
directly try the link (possibly after change of the /tmp directory to
something else under Windows):

    <url:vimscript::let dt=strftime('%Y%m%d_%H%M') | exe ':w /tmp/'.dt.'_%:t'>

This can be convenient for files that should be backuped beyond some regular
backup. The URL is portable, you can directly implant to a file of yours.


-----
Using vimscript URL for compiling			*utl-vimsCompile*

If you use LaTeX you can insert the following in a .tex file to compile it
using pdflatex (first URL) and to display it using the Utl.vim-configured
pdf Reader (second URL):

    %   <url:vimscript:!pdflatex %>
    %   <url:vimscript:exe 'Utl ol '.expand('%:r').'.pdf'>


-----
Invoke Utls media type handlers in Vim file browser	*utl-fbcallmt*

In the Vim file browser (netrw.vim) you can use  :Utl  to invoke the files and
directories presented there with the Utl-defined media type handlers! Just
useFor example open a MS Word document, show a picture, open a pdf document or
open a directory with system file explorer etc. That's very convenient. Seems
like magic first, but isn't, it is completely straight forward and without any
special treatment by Utl.vim (run with utl_opt_verbose=1 to see what's going
on). It might be worth to nOte that you do not execute self written URLs here
but URLs in the wild.

    " ========================================================================
    " Netrw Directory Listing                                    (netrw v123e)
    "   /home/stb
    "   Sorted by      name
    "   Sort sequence: [\/]$,\.h$,\.c$,\.cpp$,*,\.o$,\.obj$,\.info$,\.swp$,...
    "   Quick Help: <F1>:help  -:go up dir  D:delete  R:rename  s:sort-by  ...   
    " ========================================================================
    ../
    foo.pdf
    pic_0123.jpg
    tmp/


-----					*utl-btSample* *utl-privateScmHdl*
Reference your bug tracker database - a private scheme handler example

If you are a software developer you might use a bug tracking system.
Following the usage pattern |utl-projectManagement| information
regarding individual bug tracking issues would be tracked in the
project text file. Bug tracking issues are identified by some sort
of ID. For an example let's name them BT1234, BT4711

You can use Utl.vim to turn these references into hotlinks:

Make a bug tracker scheme with the (abritrary) name 'bt', and hence
URLs like
    <url:bt:BT1234>, <url:bt:BT4711>

Implement the protocol by defining in your .vimrc the handler
function:

    fu! Utl_AddressScheme_bt(url, fragment, dispMode)		" url= bt:BT4711
	let btId = UtlUri_unescape( UtlUri_opaque(a:url) )	" btId = BT4711
	let btUrl = 'http://server.company.com/bt/ticket/ticketView.ssp?\
		     ticket_id='.btId.'user_id=foo&user_pwd=bar'
	return  Utl_AddressScheme_http(btUrl, a:fragment, a:dispMode)
    endfu

Adapt the line specifying the web interface (btUrl=...). The call to
Utl_AddressScheme_http means that the actual work is delegated to the http
protocol handler. (See ../plugin/utl_scm.vim#r=implscmfunc for details on
writing handler function if needed.). With this definition the above URLs can
be executed. Also without embedding, e.g. just bt:BT1234. The bt: prefix is
more owed to URL syntax needs than to practical concerns. To get rid of it
define a heuristic. Currently this is only possible by hacking Utl.vim, but I
did it already for you, see ../plugin/utl.vim#r=heur_example. With heuristic
defined you can just execute a plain BT4711 anywhere in the text.


-----
Starting a program					*utl-startprog*

The following starts a vncviewer client for me:

    <url://q:/projekt_511/Iberl/vnc3.3.3R2/vnc_x86_win32/vncviewer/vncviewer.exe?>

The question mark at the end denotes that the path in front of it should be
interpreted as a program to be executed. This is straight forward URL
techniques, Utl applies the general URL query concept to programs which are
directly accessible by your file system.

You can also supply the server IP address to connect to:

    <url://q:/projekt_511/Iberl/vnc3.3.3R2/vnc_x86_win32/vncviewer/vncviewer.exe?89.11.11.242>

Starting programs is especially useful in case of long, strange paths to the
program that you either forget or which is simply to annoying to type. This
can be an alternative to one liner programs. A good place to keep such links
might be your info file, see |utl-useinfofile|.

Here is another example using a slightly different form of query:

    <url:my-decrypt.pl?stb-cellphone-pin%3e>

This link is contained in my address book. It looks up the PIN number of my
cellphone which is GPG encrypted. My-decrypt is a small Perl program which
asks for the password and then writes the PIN to standard output. The %3e at
the end is the '>' character in escaped form (see |utl-uri-forbchars|). The
'>' as the last character means the following to Utl: Execute the given
program synchronously and write the output into a temporary file. The
temporary file is then displayed in Vim. In the above vncviewer example the
program is started asynchronously and no output is awaited.
							    [id=patch]
The following line is contained in DOS script  patch.bat  that contains some
copy commands to patch a target system from the source code:

    rem <url:./patch.bat?>

This link enables you to execute the file directly from within Vim without
taking the detour to the shell.  


-----
Displaying and browsing HTML				*utl-displayHtml*

Use Utl to display a HTML file/page that you are currently editing with the
command:

    :Utl openLink currentFile	    " or shorter:
    :Utl ol cf

This will open the HTML file in your web browser (possibly after dynamic
request for configuration). Utl.vim also supports for browsing of HTML source
code, see|utl-efmeddep|.

==============================================================================
5. Usage Patterns					*utl-usagePatterns*

Here are some usage pattern for URLs in plain text. Although they do not exclude
each other and will often appear all together, they sketch different use
focuses. I worked the patterns out in the hope they are helpful in exploring
plain text URLs.

5.1 Use Vim as Desktop application			*utl-usedesktop*

If you use your text editor not only in a defensive manner (to edit program
source code what you are engaged for since you are a programmer) but
also unsolicited because you recognized that a text editor is an excellent
desktop tool then you might consider to read explore this section.

5.1.1 Project Management				*utl-projectManagement*

This pattern is about compiling lots of different informations and making them
available at your fingertips. Characteristics are:
- The information changes frequently
- Many different schemes and media types involved
The compiled information might consist of:
- references to important email threads
- web links
- links to resources (project drives, document management system links)
- links to downloaded documents
- references into bug tracker database

Example (the #-comments are only for clarification and not in the real file):

    --- install_project.txt -----------{
    file: poland_project.txt - Poland Install Project
    hist: 14.07.08/Stb

			# Link to architecture working document
    <url:../i/rcinstall_arch.txt>

			# Link to installation instructions
    <url:../../data/PL Installation Procedure - IMS Installation.doc>

    <url:cr.txt>	# Link to change requests notes
    <url:versions.txt>	# Link to SCM related stuff
    <url:t.txt>		# Link to test reports
    <url:t.txt#r=act>	# ... direct link to current test there

		        # Link to project root in document management system
    <url:http://kstbx032.ww010.mycompany.net/livelink/livelink.exe?func=ll&
    objId=1007014&objAction=browse&sort=name>			    [id=lu]

    Iinstall:		# Link to a specific document there
    <url:http://kstbx032.ww010.mycompany.net/livelink/livelink.exe/RC_D_
INSTALLATION_COMPONENT_IF_SPEC.doc?func=doc.Fetch&nodeId=1017472&
    docTitle=RC_D_INSTALLATION_COMPONENT_IF_SPEC%2Edoc&vernum=1>

			# Hot link to the current installation CD
    <url:vimscript:!net use w: %5c%5c56.123.11.73%5cc$ myAdminPassword /user:administrator>
    <url://56.123.11.73/infrastructure/installation/poland/CD>
    

    Configuration files for all deployment sites 
      <url:mail:///Inbox?14.07.2008 20:40>
      = <url:../../data/sd/20080219_all_siteconfigs>  # I use the = notation
			# for attachments or references contained in an
			# email, which data I saved locally

    Info about the CGW Tool
      <url:mail:///Inbox16.06.2008 11:21>

    Release of installer version 3.13.1.14
      ! Contained in application version 35.106, 35.107
      <url:mail:///Inbox?13.03.2008>	    Announcement Mail
      <url://d:/plInst/ws_3_13_1_14>	    Link to source code copy
      Solved issues: PT97084, PT97411, PT97460 (partly), PT97957

    Patching of integration test system
			# See <url:#r=patch> for explanation
      <url:./tools/patch.bat#>

			# Reference to bug tracker issue.
			# See |utl-btSample|
    BT4711
	<url:mail:///Sent Items?21.07.2008 22:03>

    BT4712
	Analysis of issue: <...>
	<url:mail:///Inbox?21.07.2008 10:23>	As discussed with Rob
	
    
    -----------------------------------}


5.1.2 Collecting and organizing ideas			*utl-useOrganizeIdeas*

Keywords for this section are:
Hypertext, Personal Wiki, NOtes, Mind Map, Writing in outlines.

With (executable) URLs you can build up hypertext (as you know from the
Web/HTML - where the H stands for hypertext and the implementation of that is
URLs). Here I mean self written hypertext, pieces of text that you write and
which you want to interlink because those pieces are associated somehow.

An example is software development. When you start thinking of some software
to be developed you may write down the thoughts, ideas, known requirements
etc. down to a piece of paper. Or you write it in a text file using your
favorite Vim editor because with this media you can rearrange, modify and
search the text...and because you can interlink portions of the text.

Utl.vim helps you with interlinking and associating. Especially fragment
addressing |utl-tutfrags| and also reference style links |utl-tutfoot| are
helpful in this context.

Personal Wikis [42] also serve this usage pattern. Contrary to (some of) them,
Utl.vim does not offer any text formatting (and conversion to HTML etc) - Utl
is just URL. Vims folding can also help a lot in organizing your ideas.

Collecting and organizing notes is quite related, so it might be ok to
subordinate within this section. Example is a personal info file.
You might maintain a file that contains for instance:
- Installation instructions of tools (e.g. what to modify after you installed
  a new Vim version)
- Usage of tools they use, for instance CVS usage and commands
- Links to network drives, resources and documentation
- Web links (instead or additional to bookmarks/favorites in web browser)
- HOWTO information (for instance collection of important cvs commands)
All these informations are much more useful if enriched with URLs.


5.1.3 Information Directory      			*utl-infoDir*

Keywords for this section are:
Index File, Bookmarking.

A common desktop use of Utl is to maintain a file directory of your important
files. This tends to be most helpful for files that you need less frequently
so that you don't remember their locations. Furthermore, the ability to add
comments can help to figure out in which file certain information resides.
Some people also use this technique to switch between files, but for this
purpose there might be better ways (like self written tag files, session
files, buffer explorer etc). The Information Directory rather contains static
information.

Example (the #-comments are only for clarification and not in the real file):

    --- directory.txt -----------------{
    ./apps			# NOtes related to different application areas
      ./apps/tex_app.txt
      ./apps/sys_app.txt
      ./apps/lpr_app.txt	(Unix an Windows)	# Printers

    ./p
      ./p/invoices
      ./p/privat/
	  ./p/privat/books_db.xml   Private and bf!
	  ./p/privat/running.txt    # sports
	  ./p/privat/st/
	      ./p/privat/st/st07.txt
	      ./p/privat/st/st08.txt
      ./p/data/cal_2008.txt
      ./p/org/tk_ow10/
      ./p/org/tk_ow10/tk.txt
      ./p/spendings.txt
				# correspondence
      ./p/corr/			.tex letters
	./p/corr/carla.txt
	./p/corr/alice.txt	
	./p/corr/notes.txt#r=akt

      ./p/adb/
        ./p/adb/stb_adb.xml	# address book
				Include xy-spendings!
      ./sd
        ./sd/index.txt		# link to another index file
    -----------------------------------}

Go to the line of the file you want to open and type :Utl . NOte that this
also works if the cursor is on the whitespace before a file.

A related usage is to maintain web bookmarks not in a web browser but,
in a text file. This might be more portable, or quicker than click click
in your web browser. Example:

    --- bookmarks.txt -----------------{
    http://www.vim.org				Vim Page
    http://maps.google.de/			Google
    http://de.wikipedia.org/wiki/Hauptseite	Wikipedia
    http://dict.leo.org/?lang=de&lp=ende	Dictionary
    -----------------------------------}

Of course you should create some shortcut to the bookmarks.txt file, e.g.
create a tag, a mapping or an URL linking to it
    


5.2 Link and comment source code			*utl-useSourceCode*

This is a usage of big potential IMHO. But as Utl is currently only
implemented for the Vim Editor this usage might be of real benefit only for
people who have an own interest in quality source code. You can use Utl to:

- link between the source code files using fragment addressing. For
  instance point to a C/C++ header file where a structure/class is defined.

- link from a source code file to Man pages using the man: scheme (Unix only).
  For an example see [35].

- reference design documents, technical specification papers, illustrating
  pictures etc from within source code.

The Utl source code uses URLs itself, search in <url:../plugin/utl.vim>
for 'url:'


==============================================================================
6. Tips, details, pitfalls				*utl-tipsdetails*

-----
Using a hot key						*utl-hotKey*

Mappings to shorten :Utl commands have already been explained, see
[29] / <url:../plugin/utl.vim#r=suggested_mappings_visual>. Using a hot key is
even shorter and gives perhaps more "hypertext feeling". Examples:

    :nmap <F4> :Utl ol<cr>

Or still more radical with double click?:

    :nmap <2-LeftMouse> :Utl ol<cr>


-----
Writing correct URLs					*utl-writeUrls*

- Pittfall: Don't use backslashes

  Even on MS Windows do not write:

      <url:file:D:\htdocs\corephp\kalender\WebCalendar\index.php>   # bad!!!

  Instead write:

      <url:file://D:/htdocs/corephp/kalender/WebCalendar/index.php> # good!

- Tip: Use relative URLs instead of absolute URLs whenever possible. For
  example, use:

      <url:sub_dir/foo.txt> or
      <url:./sub_dir/foo.txt>	# same as previous line

  instead of:

      <url:file:/full/path/to/sub_dir/foo.txt>

  Other example with file which is in a directory with is parallel to the
  directory where the current file is in:

      <url:../sibbling_dir/foo.txt>


-----
Pitfall: Absolute URLs do not combine!			*utl-absDontCombine*

The following makes no sense:

    <url:file:../do/not/do/this>	    # VERY BAD

Here is the easy rule to keep in mind: If the protocol (`file:' in this case)
is present, then it's an absolute URL! If it is absent, then it is a relative
URL.

An absolute URL is taken as is! The ../ in the example suggests a relative
path. But since the URL is absolute, the path will _not_ be combined with the
path of the document containing that URL. Executing the link above is about
the same as typing the Vim command:

    :edit ../do/not/do/this

That means: the result depends on the current directory, not on the directory
of the file containing the URL. Not what you want!


-----
Pitfall: Protocol and file type are different things	*utl-protvsftype*

This is really important to understand, especially if you are going to extend
Utl by your own protocol and media type handlers. People tend to create
a protocol where a media type is the better choice.

Example: Linking to a HTML file does not mean that you necessarily need the
http: protocol then! Protocol and file type (= media type) of the link target
are completely independent.

You can have `http:' to retrieve a txt file:

    <url:http://www.ietf.org/rfc/rfc2396.txt>

Or you can have `file:' to link to a local HTML file:

    <url:file:///usr/local/apache/htdocs/index.html>

Utl.vim knows scheme handlers (implemented in ../plugin/utl_scm.vim, 
function Utl_AddressScheme_<scheme>) and media type handlers (variables
utl_cfg_hdl_mt_<media-type>). First the scheme handler is performed
(download), then the media type handler (display).

							*utl-efmeddep*
-----
Detail: Embedding and fragment interpretation depend on media-type

As you already know, Utl introduces the embedding `<url:myUrl>' for plain text
files. For HTML files (.html or .htm), it makes sense to support HTMLs
embedding, i.e. something like `<A HREF="myUrl">'. This means that when
editing a HTML file and executing  :Utl  to follow a link, utl.vim expects the
pattern `<A HREF...>' under the cursor. This can be useful if editing and
browsing local html files "under construction".

The URL embedding syntax relates to the media type of the source of the link.
The fragment expression syntax relates to the media type of the target of the
link. The semantics of the fragment expression depends on the media-type.

If the target is a HTML file, with an IdRef expression like `#myFrag' then
Utl finds the position `<A NAME="myFrag">' (it will not parse the HTML file
though, merely search it; but in practice this works as expected).  When
the target is any other file type (utl.vim only distinguishes HTML from all
others) then Utl finds the position of `id=myFrag' (case never matters).

So you can really use Utl as a HTML-Source-Browser! That's useful
especially for editing and browsing your "under construction" web site.

The other fragment expressions like line=, tn= do not depend on the file
type (= media-type) in utl.vim.


==============================================================================
7. Configuration and Options				*utl-config*

All configuration and customization is done via global Vim variables.

You need not do anything in advance since missing configuration variables are
detected dynamically. Utl.vim will present you the file <url:../plugin/utl_rc.
vim> that contains template variables along with some help. You can just add
or uncomment variables there and activate the changes per ":so %".
More conventionally the variables can also reside in your vimrc file. Utl.vim
will take care to not overwrite changes done in utl_rc.vim when updating to a
newer version. The utl_rc.vim file approach has been chosen to make getting
started with Utl.vim as easy and painless as possible.

It is recommended to enclose all variables in utl_rc.vim in "if !exits(var)"
blocks. This way you can easily take any variables over into your vimrc file
without adapting utl_rc.vim.

-----
Config Variables					*utl-configcfg*

All configuration variables are named utl_cfg_*. Type: >

    :let utl_cfg_<CTRL-D>

to see all config variables. As stated you need not to know the individual
variables because they are demanded dynamically.

-----
Option Variables					*utl-configopt*

Besides config there are two option variables:

							*utl-opt_verbose*
Verbose mode on/off >

    :let g:utl_opt_verbose=0/1		    " 0=no (default), 1=yes
. 
							*utl-opt_hlighturls*
Verbose mode on/off >

    :let g:utl_opt_highlight_urls='yes'/'no'  " 'yes' is default

There is no option to customize the highlighting colors. But the source code
<url:../plugin/utl.vim#highl_custom> gives some samples you might want to try.

-----
Internal and External Utl variables			*utl-configIntExt*

Type >

    :let utl_<CTRL-D>

to see all variables Utl.vim uses. Variables which have a double underscore
in their name (like in utl_cfg_hdl_scm_http__wget), are internal to Utl and
should not be changed. All other variables you can change, even those that
might be predefined by Utl.vim (like utl_cfg_hdl_mt_generic under Windows).


==============================================================================
8. Changes since Utl-2.0              			*utl-changes*

OVERVIEW						*Utl-chgOverview*

The most important changes are:

- Added generic media type handler: open .pdf, .doc,	|utl-chgNewGenMTHdl|
  .jpg etc without the need to define handler variables.
- Added support for footnote references: make "[1]"	|utl-chgAddFootRefs|
  executable.
- Added scheme to open emails, e.g.			|utl-chgNewMailScheme|
  <mail:///Inbox?26.07.2008 16:01>
- Added verbose mode: Better figure out what's going    |utl-chgNewVerbose|
- Added 'copy link/filename to clipboard' function	|utl-chgNewOperators|
- Changed user interface: Basic Command :Utl instead	|utl-chgUI|
  only mapping \gu
- Alternate http access method: open web documents	|utl-chgNewHttpAccess|
  directly in Vim
- Support network files (shares, NFS), e.g.		|utl-chgNetworkFile|
  <file://127.0.0.1/path/to/file>
- Improved jumping back and forth			|utl-fixedBackForth|
- More versatile scheme handler interface		|utl-chgcfgscm|
- Fixed Bugs

Following the changes in detail.

INCOMPATIBLE CHANGES					*utl-chgincompat*

-----
All mappings \gu, \gE,... gone				*utl-chgUI*
It is a design goal of Utl.vim to have no side effects and to stay out
of the way. A mapping could clash with the mappings of other plugins.
Therefor mappings are no longer the standard user interface to Utl.vim;
new user interface is the command :Utl , see |utl-tutUI|.

See <url:../plugin/utl.vim#r=suggested_mappings> to define the 
mappings to :Utl commands to the get the behavior of Utl v2.0.

-----
Changed variable names					*utl-chgVarNames*

The naming scheme has been changed for a clearer scheme. All configuration
(=setup) oriented variables are now named utl_cfg_... , for instance 
utl_cfg_hdl_mt_application_msword. All option oriented variables are now
named utl_opt_, for instance utl_opt_verbose. All internal variables internal
to Utl.vim have two underscores in the name. See |utl-customization|
During installation you are guided to renaming the variables. You can check
with <url:vimscript:call Utl_finish_installation()> if there are still old
variables around.

-----
Command :Gu gone					*utl-chgGuGone*

Instead
    :Gu <url> <displayMode>
you have now to use
    :Utl openLink <url> <displayMode>

-----
Change in SCM Handler Interface				*utl-chgScmIf*

The scheme handler functions in <url:../plugin/utl_scm.vim> have got
an extra argument 'dispMode'. So in case you created or changed an
existing scheme you have to adapt this. It's normally sufficient to
add the argument to the function, e.g.

    Utl_AddressScheme_file(auri, fragment)
    --->
    Utl_AddressScheme_file(auri, fragment, dispMode)

-----
URL lookup table disabled, commands \gs, \gc gone	*utl-chgCacheGone*

V2.0 maintained a lookup table for URLs that mapped local files into URLs.
This allowed to resolve relative URLs within web pages. But the design had
conceptual problems, especially in conjunction with new footnote references
|utl-totfoot| [41]. Since not of big practical relevanve I decided to disable
the lookup table. This means that only relative URLs file:// URLs can be
resolved, e.g. ./some_file.txt -> file://path/to/file.txt. As a consequence
the commands \gs, \gc are gone as well as the file utl_arr.vim which
implemented an associative array (a data structure that was not available
in Vim 6).


CHANGED							*utl-chgchanged*

-----
More versatile scheme handler interface			*utl_chgcfgscm*

Utl 2.0 used the two variables utl_cfg_app_browser, utl_cfg_app_mailer,
which have been used to parametrize the http- and mailto- scheme handler.
This pragmatic approach has been replaced by a more consistent and
systematic interface. The above two have been renamed:

    utl_cfg_app_browser -> utl_cfg_hdl_scm_http
    utl_cfg_app_mailer  -> utl_cfg_hdl_scm_mailto

which clearly associates each variable with its scheme. New variables

    utl_cfg_hdl_scm_mail	# new for new mail: scheme
    utl_cfg_hdl_scm_scp		# now scp: scheme parametrizable

have been added. Not all supported schemes are yet parametrized though.

The interface is specified at <url:../plugin/utl_scm.vim#r=spec_ihsv>

-----
Minor: Changed syntax highlighting of URLs		*utl-chghighl*

The URL surroundings `<url' and '>' no longer highlighted, only the URL
itself.

    You can change the highlighting of the URL surrounding and the URL
    itself in the source:
	<url:../plugin/utl.vim#highl_surround>
	<url:../plugin/utl.vim#highl_inside>
    Some commented out samples are given there. (Do not forget to write down
    the changes you made in order to prevent overwriting when you install
    a new Utl.vim version.)



ADDED							*utl-chgadded*

-----
New generic media type handler for any media type	*utl-chgNewGenMTHdl*

In v2.0 for each media type an individual media type handler variable had to
be defined. Added a generic media type handler which will be called if no
specific media type handler is defined. See |utl-tutmtypes|.

-----
Added support for footnote references			*utl-chgAddFootRefs*

In given texts you often find references like:

    ----- (Example taken from <url:vimhelp:beos-timeout>)
    "Because some POSIX/UNIX features are still missing[1], there is no
     direct OS support [...]"
    .
    .
    [1]: there is no select() on file descriptors; also the termios VMIN [...]
    -----

These can be executed using Utl.vim. See |utl-tutfoot|.


-----
New operators on URLs					*utl-chgNewOperators*

- copyLink     - copy link to clipboard, see |utl-tutCopyLink|
- copyFileName - copy filename corresponding to clipboard, see |utl-tutCopyFileName|

-----
New URL operand						*utl-chgNewOperand*

- currentFile  - Operates on the current file, i.e. creates an URL from the
  current file and use it as the URL to be operated on (instead the URL under
  the cursor (operand underCursor) or an URL typed in at the command line
  (operand = the typed URL).

-----
New mail scheme						*utl-chgNewMailScheme*

Introduced a non standard scheme for referencing emails from your local mail
boxes via URL. Example: <url:mail:///Inbox?date=12.04.2008 15:04>. Currently
the only implementation for actually displaying the emails if for MS Outlook.
See |utl-tutscmmail|.

-----
New verbose mode					*utl-chgNewVerbose*

Set Vim variable
    :let utl_opt_verbose=1
to see what's going on when executing an URL. See |utl-tutverbosemode|.

-----
							*utl-chgFragAW*
Support fragment addressing for Acrobat Reader and MS Word  

If you use Acrobat Reader you can execute an URL like:
<url:http://www.tech-invite.com/RFCs/PDF/RFC3986.pdf#page=4>. See
|utl-tutpdffrag|.
If you are under Windows and use MS Word you can execute an URL like:
<url:my.doc#tn=textToSearch>. See |utl-tutwordfrag|.

-----
New HTTP-URL access method				*utl-chgNewHttpAccess*

Two standard methods are provided for accessing http URLs:
- Delegation to your internet browser and 
- Display inside Vim (using the non-interactive retriever "wget")

(1.) was the only method in Utl-V2.0, where (2.) was the only
method in Utl-v1.x
Now the one or the other method can be used, choosing it URL by URL.
See |utl-tutscmhttp| 

-----
Support network files (Shares, UNC, NFS)		*utl-chgNetworkFile*

You can now access Windows share files like
    <URL://127.0.0.1/ADMIN$/System32/EULA.txt>
or Unix shares (e.g. NFS) like
    <URL://server/sharefolder/path/to/file.txt>
See |utl-tutdrivesshares|.


-----
							*utl-chgNewFragConv*
Support %f fragment conversion specifier in media type handlers

New fragment conversion specifier %f allowed in media type variables. For
external media type handlers fragments can now be passed to the handler.
This enables URLs like the these to be performed:

    <url:./path/to/file.pdf#page=3>
    <url:./path/to/myWordDocument.doc#searchText>
    <url:./path/to/websources/mypage.html#htmlAnchor>

-----
Support negative numbers in #line= fragments.		*utl-chgLineNegative*

#line=-3 positions cursor three lines upwards. Starting either from bottom of
buffer or, if relative addressing (see |utl-tutfragsrel|) from current cursor
position.


FIXED BUGS						*utl-fixed*

-----
Allow single quotes in URLs

Example: The URL <url:vimhelp:'compatible'> did not work because single quotes
where use for quoting inside Utl.vim.

-----
Fixed fragment quirks

- In certain cases (involving for instance files already displayed in buffer
  or Vimhelp URL) the wrong cursor position was set.

- More clear when relative fragment addressing happens.
  This depended on whether file was already displayed or was displayed by the
  scheme handler. Now only for same-document references |utl-tutfragsdref| or
  for non file oriented fragment addressing |utl-tutfragsnonfile|. 

-----
Jump forth and back with ctrl-o/-i improved		*utl-fixedBackForth*

Jumping back from link target to link source with ctrl-o should be more
reliable now (added explicit context marks before certain cursor changes).

-----
Fixed visual area off by one error (Windows)

Under Windows when visually selecting an URL the character following the
visual area was taken into the URL.

-----
Fixed bug with media type to variable name mapping

Media types can contain characters . + - which must not be mapped directly
into variables. Now convert all . + - all into underscores. Example:
Variable for video/x-msvideo is utl_cfg_hdl_mt_video_x-msvideo.



==============================================================================
9. Todo     						*utl-todo*

-----
Wish list

- Better support for URL creation (authoring support)

- Check for dangling links
  Provide a function to check whether all links point to existing targets.

- Follow links when searching.
  Add a function which searches the file tree which is defined by a file
  containing file URLs.

-----
Known major bugs					*utl-knownbugs*

- Not compliant to newer URI specification [RFC3986], rather to obsoleted
  [RFC2396]. 

- Found fragment string of #somestring will not be the current search string.
  See <url:#tp=The found string>

- Jump to wrong target if URL is substring of current file.
  Have displayed a file /tmp/s.txt, which contains a folder URL <url:/tmp>.
  Executing it will display the folder /tmp but rather jump to line 1
  of current file /tmp/s.txt. Reason is that Vim function bufwinnr() is used
  to check if to be loaded file (i.e. folder /tmp) is already loaded.
  Bufwinnr takes file-patterns as arguments not full names. /tmp is a match
  for /tmp/s.txt. Utl.vim thinks the target is already displayed and just
  positions the cursor (to line 1).

- Exclamation mark in externally handled URLs to be escaped.
  In URLs that contain URLs like
  <URL:http://server.foo.com:9010/bugtracker/secure/CreateIssue!default.jspa>
  the exclamation point  !  will be expanded by Vim on the command line of the
  invoked shell. Utl.vim should escape the !, but is doesn't, so you have to 
  workaround yourself. Insert two \\ before the !, e.g.
  <URL:http://server.foo.com:9010/bugtracker/secure/CreateIssue\\!default.jspa>
  See <vimhelp::!#Any>. NOte that actually a double backslash is needed since
  Utl.vim consumes one for itself before Vims :! is invoked... probably
  another bug.

- Utl copylink does not percent encode invalid URI characters.
  For a link containing blanks (under Windows) like
  <url://c:/tmp/file name with blanks.txt> the command  :Utl copylink
  yields the URL <url:file://c:/tmp/file name with blanks.txt>. Although
  this URL can be executed within Utl itself or can be used in Windows
  Explorer etc. it is not a valid URL since the space character is not in the
  URI character set (see <[RFC3986]#tn=^2.  Characters>). Utl.vim should
  percent encode the space: <url:file://c:/tmp/file%20name%20with%20blanks.txt>.
  Other characters than space have similar problems (also under Unix).
  The invalid URLs is really a problem when you try to open the URL with
  :Utl ol file://c:/tmp/file name with blanks.txt  (in other Vim instance as
  described at <url:vimhelp:utl-tutCopyLink#Vim instance>.
  
- Spell checking in URLs.
  URLs embedded in <url: and > should not be spell checked. (Unembedded URLs
  cannot be excluded anyway because not parsesafe.)


==============================================================================
10. Credits						*utl-credits*

Tatjana Dreier, for her patience
Wolfgang Fleig, my partner, for sponsoring, testing, feedback
Ines Paegert, for her impulses.
Bram Moolenaar <Bram at moolenaar.net>, for the Vim editor.
Barrie Stott <G.B.Stott at bolton.ac.uk>, for helping a lot with the
	documentation
REKellyIV <Feral at FireTop.Com>
Klaus Horsten <horsten at gmx.at>.
Patrik Nyman <patrik.nyman at orient.su.se>
Engelhard Heß <Engelhard.Hess at artofbits.de>
Grant Bowman <grantbow at grantbow.com>
Ward Fuller <wfuller at SeeBeyond.com>
Mark S. Thomas <Mark.Thomas at SWFWMD.STATE.FL.US>
William Natter <wnatter at nortelnetworks.com>
Alex Jakushev <Alex.Jakushev at kemek.lt>
Geoff Caplan <geoff at advantae.com>
Bruno Díaz <bruno.diaz at gmx.net>
Michael Lesniak <ich at mlesniak.de>
Janek Kozicki <janek at thenut.eti.pg.gda.pl>
Olivier Teulière <ipkiss at via.ecp.fr>
Nathan Howell <nathan at atdot.ca> 
Samuel Wright <sam.wright@celoxica.com>
clemens fischer <ino-qc@spotteswoode.de.eu.org>
Gabor Grothendieck <ggrothendieck@gmail.com>
Bill Powell <bill@billpowellisalive.com>
Jeremy Cantrell <jmcantrell at gmail.com>
Charles E. Campbell <drchip@campbellfamily.biz>
Al S. Budden <abudden at gmail.com>, for Pdf page addressing and idea to use
	Windows start command as generic handler.
Alpt <alpt@freaknet.org>
Cristian Rigamonti <cri at linux.it>
Olle Romo <olleromo at metasound.ch>


==============================================================================
FOOTNOTES

[20] But you can use something like:
    <url:vimscript:!net use w: %5c%5c56.240.73.41%5cc$ myAdminPassword /user:administrator>
    to authenticate (the %5c masks the \ in the URL). The Vimscript scheme and
    masking will be explained later in the docs.

[22] It is not sufficient to provide a media type handler variable to make
    a new specific handler work. There has to be a file extension to
    media type mapping defined, see <url:config:#r=new_mt>. Again, perform
    Utl.vim with verbose mode set to get this illustrated - watch out for
    section 'start media type handler processing' in the output.
    If no mapping is defined, no handler variable will be evaluated, and
    the file will be displayed in current Vim.
    If a mapping is defined, a handler has to present (at runtime when such
    a file is performed).

[23] NOte that you cannot include this line in your .vimrc because it is
    :source'd before utl_rc.vim (which defines g:utl_cfg_hdl_mt_generic).
    So either include/change it at <url:config:#r=utl_cfg_hdl_mt_text_directory>
    or include it in the after-directory, see <url:vimhelp:after-directory#5.>

[24] If a typed URL clashes with a keyword or an abbreviated keyword
    prefix it with a ./    Example:
    If you want to open the literal URL "underCursor" use
	:Utl openLink ./underCursor

[25] The displayMode is currently only used for link targets displayed in Vim
    and are ignored if the resource is displayed by an external handler.

[26] I don't know why this isn't Vim's default...
    Check if currently set with	  <url:vimscript:set wildmenu?>
    Set it with		          <url:vimscript:set wildmenu>
    Then retry the given <Tab> examples to see the difference.
    For help see		  <url:vimhelp:'wildmenu'>

[27] For the third argument in  :Utl openLink  command (the  mode  argument)
    only a few values are offered for completion. Actually any Vim command
    that takes a file name as argument is allowed here. Colons are also
    allowed if this gives you more Vim feeling. Examples:
	:Utl openLink underCursor :edit	    " or
        :Utl openLink underCursor :e
    More exotic examples are:
	:Utl openLink underCursor :vertical diffsplit
	:Utl openLink underCursor :bad
    This one does unfortunately not work as expected in Utl v3.0a:
      :Utl openLink underCursor :e!
    Switch on verbose mode to see why.

[28] Unfortunately :U is not possible because of the :UseVimball standard
    plugin command. I think that this is unnecessary polution of the name
    space, Vimball should better have chosen an approach like Utl, e.g.
    :Vimball use. 

[29] The Ctrl-C is normally not needed under Unix. Also not needed under
    Windows if the 'guioptions' contains 'a' Autoselect flag, see
    <url:vimhelp:guioptions>.  :Utl openLink visual  just takes the
    contents of the "* register, see <url:vimscript::reg *>. If you find
    Ctrl-C is too inconvenient you could use mappings like these:
    <url:../plugin/utl.vim#r=suggested_mappings_visual>

[30] You can use the Vim command  :asc  to get the hex value of a character,
    see <url:vimscript::h asc>

[31] Well, normally the 'save as' dialog offers the base name, you copy
    this name and paste it for the construction of the link in your text
    file, and then come back with the complete path into the mailer's
    'save as' dialog.

[32] The implementation is via a VBS script that uses the OLE Automation
    capabilities of Outlook. Outlook Express does not support OLE Automation.

[33] There are two plugins that allow browsing mbox files:
    <url:http://www.vim.org/scripts/script_search_results.php?keywords=mbox>
    Perhaps these can serve as a starting point an implementation for
    mbox emails.

[34] The general query format is 
    date=<date>&from=<from>&subject=<subject>.
    But only date is currently supported in the VBS script.
    So if you received two mails within the same one or two minutes 
    you cannot properly select the correct one (resending one of them to
    yourself is a workaround).

[35] You can use the man: protocol to hotlink from a program source code file
    to the relevant man page. Utl.vim delegates to the  :Man  command, which
    is implemented by the ManPageView plugin
    <url:http://www.vim.org/scripts/script. php?script_id=489> Example:

    [myopen.c]
    .
    .
    .
    /* Opens file "filename".
     * See <url:man:open#tn=flags is one of> for possible values of the `flags' 
     * argument.
     * The restrictions described under <url:man:open#tn=^RESTRICTIONS> also
     * apply to this function.
     */
	int
    myopen(char* filename, int flags)
    {
	//
	open(filename, flags, mode);
	//
    }
    .
    .
    .
    EOF


[36]
    * VimFootnotes : Insert various types of footnotes with Vim. 
      [36_1] <url:http://www.vim.org/scripts/script.php?script_id=431>

    * uri-ref : Easily insert references to URLs in emails
      [36_2] <url:http://www.vim.org/scripts/script.php?script_id=76>

    * Markdown syntax : Syntax file for Markdown text-to-HTML language  
      [36_3] <url:http://www.vim.org/scripts/script.php?script_id=1242>
      This is only the the syntax file. Markdown is a text-to-HTML conversion
      tool and that text can contain footnote references, which are supported
      by Utl.vim

    Tip: When creating footnote references you'll often find yourself
    searching for those footnotes, which is complicated because [ and ]
    are magic characters. Search with \M preprended, e.g. \M[10], see
    <url:vimhelp:%5cM>

[37] You might wonder what is the difference between "[123]" and "[123]:".
    Of course any character can follow follow. But it is treated
    differently by utl.vim in case the reference gets forwarded
    automatically if a fragment is appended like this:
    [123]#xxx (this will be explained later). Aside from Utl.vim treatment I
    guess it is good style to have a blank or tab coming after the closing
    bracket ]. The format  [123]:  is used by the Markdown tool [36_3].

[38] This seems to be a problem in some cases. For instance it makes
    reference targets within comments of some programming languages 
    impossible:

	use Dumpvalue;	# [124] 
	.
	.
	# [124] http://perldoc.perl.org/Dumpvalue.html  <-- Does not work

[39] Keep in mind that a relative file is also an (file://) URL. Often files
    in source code systems reference each other via relative files either in
    comments or kinds of include- or call-statements. Examples:
    ./prog.c has a comment line:  /* prog.h ... */
    ./prog.c has an include statement:  #include "prog.h"
    ./script.bat contains a line:  call otherScript.bat
    ./script.sh contains a line:  source ./tools/otherScript.sh 
    Quite often these references are directly suitable for being executed by
    Utl.vim. Well, the more you use Utl.vim you get more "URL aware" and 
    get the habit of writing comments and so on which are suitable as URLs.

[40] It would be interesting to facilitate creation of links. For instance:
    - drop files into Vim window. But insert as link, not the normal behavior
      of opening and displaying the file,
    - convert Vim marks into links. Within same Vim session, create a mark
      at link target, goto to place from where you want to link, and a call
      a command like  :Utl insertLink mark  to insert a file:// URL with
      fragment.

[41] Lookup table explained: Take a web URL retrieved with wget and displayed
    in Vim (see |utl-tutscmhttp|) that contains a relative URL
    ./other_page.html. This link could be resolved in v2.0 via the lookup
    table. Problem was 1. that the implementation was buggy due to
    normalization problems with URLs and 2. conceptual problem with wrong
    scheme associations: Example: After having executed [1] (-> foot:1)
    executing a link ./some_file.txt in the same source file lead to a link
    foot:some_file.txt instead of /path/to_source_file/some_file.txt.

[42] http://www.vim.org/scripts/script_search_results.php?keywords=wiki&
     script_type=&order_by=rating&direction=descending&search=search

[RFC3986] <url:http://www.ietf.org/rfc/rfc3986.txt>
[RFC2396] <url:http://www.ietf.org/rfc/rfc2396.txt>

[UTL_RC] ../plugin/utl_rc.vim

 vim:tw=78:ts=8:ft=help:norl:fdm=marker:fen
autoload/utl_lib.vim
170
" ------------------------------------------------------------------------------
" File:		autoload/utl_lib.vim -- Finish installation and
"		data migration support
"			        Part of the Utl plugin, see ../plugin/utl.vim
" Author:	Stefan Bittner <stb@bf-consulting.de>
" Licence:	This program is free software; you can redistribute it and/or
"		modify it under the terms of the GNU General Public License.
"		See http://www.gnu.org/copyleft/gpl.txt
" Version:	utl 3.0a
" ------------------------------------------------------------------------------



"-------------------------------------------------------------------------------
" Intended to finish installation after Utl 3.0a files have been installed
" by UseVimball. Will automatically be called after UseVimball in
" utl_3_0a.vba. But can be called at any later time or can be called multiple
" times. As an autoload function it can be called directly from within
" :so utl_3_0a.vba without starting a new Vim instance.
"
" - Deletes any existing obsolete files: plugin/utl_arr.vim, doc/utl_ref.txt
" - Data migration: Checks for utl_2.0 configuration variables and print
"   instructions to user how to migrate them.
"
" Note: Utl 3.0a installation saved file plugin/utl_rc.vim to
" plugin/utl_old_rc.vim prior to Utl 3.0a installation (Preinstall). So the
" old variables remain and will be visible in new Vim instance.
"
function! utl_lib#Postinstall()

    echo "----------------------------------------------------------------------"
    echo "Info: Start of Utl 3.0a post installation."
    echo "      This will handle relicts of any previously installed Utl version"
    echo "\n"

    if ! exists("g:utl_vim")
	echo "Info: No previously installed Utl version found (variable g:utl_vim)"
	echo "      does not exist). Nothing to do at all."
	if exists("g:utl_rc_vim") 
	    echo "\n"
	    echo "Warning: But file  ".g:utl_rc_vim." still exists"
	    echo "         You should remove it from the plugin directory"
	endif
	echo "\n"
	echo "      To start with Utl open a new  Vim, type:"
	echo "        :help utl"
	echo "      and follow the live examples"
	echo "\n"
	echo "      End of Utl 3.0a post installation"
	echo "----------------------------------------------------------------------\n"
	call input("<Hit Return to continue>")
	return
    endif

    "--- 2. Delete obsolete Utl 2.0 files
    if exists("g:utl_arr_vim") 
        if filereadable(g:utl_arr_vim)
	    if delete(g:utl_arr_vim)==0
		echo "Info: obsolete Utl 2.0 file ".g:utl_arr_vim." deleted successfully"
	    else
		echohl WarningMsg
		echo "Warning: Could not delete obsolete Utl 2.0 file".g:utl_arr_vim."."
		echo "         This does not affect proper function but you might want to"
		echo "         delete it manually in order to cleanup your plugin directory"
		echohl None
	    endif
	else
	    echo "Warning: no obsolete Utl 2.0 file ".g:utl_arr_vim." found"
	endif
    else
	echo "Warning: variable g:utl_arr_vim not found. Inconsistent installation"
    endif

    if exists("g:utl_vim")   " no variable for utl_ref, so start from utl.vim
	let utl_ref_txt = fnamemodify(g:utl_vim, ":p:h:h") . "/doc/utl_ref.txt"
	if filereadable(utl_ref_txt)
	    if delete(utl_ref_txt)==0
		echo "Info: obsolete Utl 2.0 file ".utl_ref_txt." deleted successfully"
	    else
		echohl WarningMsg
		echo "Warning: Could not delete obsolete Utl 2.0 file ".utl_ref_txt
		echo "         but you might want to delete it manually to avoid garbage"
		echo "         docs / help tags"
		echohl None
	    endif
	else
	    echo "Warning: no obsolete Utl 2.0 file ".utl_ref_txt." found"
	endif
    endif

    "--- 3. Check for Utl V2.0 variables
    "	 The user might want to migrate these to Utl 2.1 variable names
    "	 g:utl_rc_xxx -> g:utl_cfg_xxx
    "	 g:utl_config_highl_urls -> g:utl_opt_highlight_urls
    "	 g:utl_mt_xxx -> utl_cfg_mth__xxx
    let varMap = {}

    if exists("g:utl_rc_app_mailer")
	let varMap['g:utl_rc_app_mailer'] = 'g:utl_cfg_hdl_scm_mailto'
    endif

    if exists("g:utl_rc_app_browser")
	let varMap['g:utl_rc_app_browser'] = 'g:utl_cfg_hdl_scm_http'
    endif

    if exists("g:utl_config_highl")
	let varMap['g:utl_config_highl'] = 'g:utl_opt_highlight_urls'
    endif

    " All utl_mt_ variables. Get them by capturing the ':let' output
    redir => redirBuf
    silent let
    redir END

    let line=split(redirBuf)
    let prefix='utl_mt_'
    for item in line
	if item=~ '^'.prefix
	    let suffix = strpart(item, strlen(prefix))
	    let newName = 'utl_cfg_hdl_mt_'.suffix

	    let varMap['utl_mt_'.suffix] = newName

	endif
    endfor

    if ! empty(varMap)
	echo "\n"
	echohl WarningMsg
	echo "Warning: The following Vim variable(s) from a previously installed"
	echo "         Utl version have been detected. You might  a) want to rename"
	echo "         them to the new Utl version 3.0a names as given in the table below."
	echo "         Or you might  b) want just delete the old variables."
	echo "\n"
	echo "         If you don't care, then choose b), i.e. just remove those variables"
	echo "         from your vimrc or delete utl_rc_old.vim (which possibly has been"
	echo "         created during preinstall (see second line in utl_3_0a.vba)). This is"
	echo "         not a bad choice since Utl 3.0 provides a generic handler variable"
	echo "         which discharges you from maintaining specific handler variables for"
	echo "         each file type."
	echohl None
    else
	echo "Info: No variables of a previous Utl installation detected."
	echo "      So nothing no further instructions for moving them away needed."
    endif
    for key in sort(keys(varMap))
	echo printf("    %-40s -> %s", key, varMap[key])
    endfor
    if ! empty(varMap)
	echo "\n"
    endif

    echo "\n"
    echo "Info: You can perform post installation again anytime with the command:"
    echo "        :call utl_lib#Postinstall()\n"
    echo "      You can also just install again by :source'ing Utl_3_0a.vba"
    echo "\n"
    echo "      You should move the possibly created file plugin/utl_old_rc.vim out of"
    echo "      the way when done with data migration. I.e. delete it or rename it to"
    echo "      other file name extension than .vim or move it away from the plugin"
    echo "      directory."
    echo "\n"
    echo "      To start with Utl open a new Vim and type:"
    echo "        :help utl"
    echo "\n"
    echo "Info: End of Utl 3.0a post installation"
    echo "----------------------------------------------------------------------\n"
    call input("<Hit Return to continue>")

endfunction
plugin/utl.vim
1846
" ------------------------------------------------------------------------------
" File:		plugin/utl.vim - Universal Text Linking - 
"			  URL based Hyperlinking for plain text
" Author:	Stefan Bittner <stb@bf-consulting.de>
" Maintainer:	Stefan Bittner <stb@bf-consulting.de>
"
" Licence:	This program is free software; you can redistribute it and/or
"		modify it under the terms of the GNU General Public License.
"		See http://www.gnu.org/copyleft/gpl.txt
"		This program is distributed in the hope that it will be
"		useful, but WITHOUT ANY WARRANTY; without even the implied
"		warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
"
" Version:	3.0a ALPHA
"
" Docs:		for online help type:	:help utl-plugin
"
" Files:	The Utl plugin consists of the following files:
"		plugin/{utl.vim,utl_scm.vim,utl_uri.vim,utl_rc.vim}
"		doc/utl_usr.txt
"
" History:
" 1.0   2001-04-26
"		First release for vim5 under the name thlnk.vim
" 1.1   2002-05-07
"		As plugin for vim6 with heavily revised documentation and homepage
" 1.2   2002-06-14
"		Two bug fixes, better error messages, largely enhanced documentation
" 1.2.1 2002-06-15
"		Bug fix. Better 'ff' setting for distribution files
" --- Renamed plugin from Thlnk to Utl ---
" 2.0	2005-03-22
"		Configurable scheme and media type handlers, syntax
"		highlighting, naked URL support, #tn as default, heuristic
"		support and other new features. See ../doc/utl_usr.txt#utl-changes
" 3.0a  ALPHA 2008-07-31
"		New :  Generic media type handler, Mail protocol, Copy Link/
"		Filename support, Foot-References [], Transparent editing of
"		share files, Tracing, Enhanced scheme handler interface,  
"		Changed : User Interface with command :Utl, variable naming.
"		Bug fixes.
" ------------------------------------------------------------------------------

if exists("loaded_utl") || &cp
    finish
endif
let loaded_utl = "3.0a"
if v:version < 700
    echohl ErrorMsg
    echo "Error: You need Vim version 7.0 or later for  utl.vim  version ".g:loaded_utl
    echohl None
finish
endif
let s:save_cpo = &cpo
set cpo&vim
let g:utl__file = expand("<sfile>")

"--- Utl User Interface [

"   (:Utl not as "command! to not override a possible user command of this name.
"     Fails with an error in this case.)
command -complete=custom,s:completeArgs -range -nargs=* Utl call Utl(<f-args>)

"-------------------------------------------------------------------------------
" Intended as command line completion function called back by command :Utl.
" See vimhelp:command-completion-custom.
" Based on the command line provided by user input so far it returns a \n
" separated line of items, which Vim then uses for presenting completion
" suggestions to the user.
" Also works if abbreviations ( see #r=cmd_abbreviations ) appear in cmdLine 
fu! s:completeArgs(dummy_argLead, cmdLine, dummy_cursorPos)

    " Split cmdLine to figure out how many arguments have been provided by user
    " so far. If Using argument keepempty=1 for split will provide empty last
    " arg in case of a new arg is about to begin or an non empty last argument
    " in case of an incomplete last argument. So can just remove the last arg.
    let utlArgs=split(a:cmdLine, '\s\+', 1)
    call remove(utlArgs, -1)

    " 1st arg to complete
    if len(utlArgs)==1
	return "openLink\ncopyFileName\ncopyLink\nhelp"
    endif

    let utlArgs[1] = s:abbr2longArg(utlArgs[1])

    " 2nd arg to complete
    if len(utlArgs)==2
	if utlArgs[1]=='openLink' || utlArgs[1]=='copyFileName' || utlArgs[1]=='copyLink'
	    if len(utlArgs)==2
		return "underCursor\nvisual\ncurrentFile\n_your_URL_here"   
	    endif
	elseif utlArgs[1]=='help'
	    if len(utlArgs)==2
		return "manual\ncommands" 
	    endif
	endif
	" config
	return ''
    endif

    " 3rd argument to complete
    if len(utlArgs)==3
	if utlArgs[1]=='openLink'
	    return "edit\nsplit\nvsplit\ntabedit\nview\nread"
	elseif utlArgs[1]=='copyFileName'
	    return "native\nslash\nbackSlash"
	endif
	return ''
    endif

    return ''

endfun

							" [id=cmd_reference]
"-------------------------------------------------------------------------------
" Table of  :Utl  commands/arguments. The [xxx] are default values and can
" be omitted. ( The table is implemented at #r=Utl )
"
"    arg# 1		2		3
"
"    :Utl [openLink]    [underCursor]	[edit]
"    :Utl	        visual		split
"    :Utl	        currentFile	vsplit
"    :Utl	        <my_url>	tabedit
"    :Utl				view
"    :Utl				read	
"
"    :Utl copyLink	[underCursor]
"    :Utl               visual
"    :Utl               currentFile
"    :Utl               <my_url>
"
"    :Utl copyFileName	[underCursor]	[native]
"    :Utl	        currentFile	backSlash
"    :Utl		Visual		slash
"    :Utl		<my_url>
"
"    :Utl help		[manual]
"    :Utl		commands

							" [id=cmd_abbreviations]
"-------------------------------------------------------------------------------
" Supported abbreviations of arguments to :Utl command.
" Abbreviation conventions are:
" - More than one abbreviation per argument is possible
" - All uppercase letter of a camel word as lower letters (copyFileName -> cfn)
" - Fewer and fewer uppercase letters as long as still unique
"   (cfn -> cf. But not c since else clash with copyLink)
" - The shortest (camel sub-)word beginning until unique
"   (view and vsplit -> vi and vs resp.)
"
" (More keys (=abbreviations) can be added to the dictionaries without further
" change as long as the values are valid long arguments.)
"
let s:d1= { 'o': 'openLink', 'ol': 'openLink', 'cl': 'copyLink', 'cf': 'copyFileName', 'cfn': 'copyFileName', 'h': 'help' }
let s:d21={ 'u': 'underCursor', 'uc': 'underCursor', 'v': 'visual', 'c': 'currentFile', 'cf': 'currentFile' }
let s:d22={ 'm': 'manual', 'c': 'commands' }
let s:d31={ 'e': 'edit', 's': 'split', 'vs': 'vsplit', 't': 'tabedit', 'te': 'tabedit', 'vi': 'view',  'r': 'read' }
let s:d32={ 'n': 'native', 'b': 'backSlash', 'bs': 'backSlash', 's': 'slash' }
"-------------------------------------------------------------------------------
" Convert possible :Utl arg abbreviation for last arg into long arg. The args
" before are the :Utl args provided so far in long form.
"
" Args: Utl command arguments according #r=cmd_reference, where the last
"	can be abbreviated.
" Returns: Last arg converted into long arg
"
" Collaboration: 
"
" Example: s:abbr2longArg('copyFileName', 'underCursor', 's')
"	returns 'slash'
"
fu! s:abbr2longArg(...)
    if ! exists('a:2')
	return s:utilLookup(s:d1, a:1)
    elseif ! exists('a:3')
	if a:1=='openLink'|| a:1=='copyLink'|| a:1=='copyFileName'
	    return s:utilLookup(s:d21, a:2)
	elseif a:1=='help'
	    return s:utilLookup(s:d22, a:2)
	endif
    else
	if a:1=='openLink'
	    return s:utilLookup(s:d31, a:3)
	elseif a:1 == 'copyFileName'
	    return s:utilLookup(s:d32, a:3)
	endif
    endif
endfu

"-------------------------------------------------------------------------------
" Lookup 'key' in 'dict'. If defined return its value else return the 'key'
" itself
fu! s:utilLookup(dict,key)
    if has_key(a:dict, a:key)
	return a:dict[a:key] 
    endif
    return a:key
endfu

"----------------------------------------------------------id=Utl---------------
" Central Utl.vim function. Normally invoked by :Utl command
" args: Same as command :Utl (but quoted), see #r=cmd_reference
"
" Example:  call Utl('openLink','http://www.vim.org','split')
"
fu! Utl(...)
    call Utl_trace("- start function Utl()",1,1)
    if exists('a:1') | let cmd=s:abbr2longArg(a:1) | else | let cmd='openLink' | endif
    call Utl_trace("- arg1 (cmd)      provided or by default = `".cmd."'")

    if cmd == 'openLink'
	if exists('a:2') | let operand=s:abbr2longArg(cmd,a:2) | else | let operand='underCursor' | endif
	call Utl_trace("- arg2 (operand)  provided or by default = `".operand."'")
	if exists('a:3') | let dispMode=s:abbr2longArg(cmd,operand,a:3) | else | let dispMode='edit' | endif
	call Utl_trace("- arg3 (dispMode) provided or by default = `".dispMode."'")
	if operand=='underCursor'
	    call s:Utl_goUrl(dispMode)
	elseif operand=='visual'
	    let url = @*
	    call s:Utl_processUrl(url, dispMode)
	elseif operand=='currentFile'
	    let url = 'file://'.Utl_utilBack2FwdSlashes( expand("%:p") )
	    call s:Utl_processUrl(url, dispMode)
        else	" the operand is the URL
	    call s:Utl_processUrl(operand, dispMode)
	endif

    elseif cmd=='copyFileName' || cmd=='copyLink'
	if exists('a:2') | let operand=s:abbr2longArg(cmd,a:2) | else | let operand='underCursor' | endif
	call Utl_trace("- arg2 (operand)  provided or by default = `".operand."'")

	let suffix=''
	if cmd == 'copyFileName'
	    if exists('a:3') | let modifier=s:abbr2longArg(cmd,operand,a:3) | else | let modifier='native' | endif
	    call Utl_trace("- arg3 (modifier) provided or by default = `".modifier."'")
	    let suffix='_'.modifier
	endif

	if operand=='underCursor'
	    call s:Utl_goUrl(cmd.suffix)
	elseif operand=='visual'
	    let url = @*
	    call s:Utl_processUrl(url, cmd.suffix)
	elseif operand=='currentFile'
	    let url = 'file://'.Utl_utilBack2FwdSlashes( expand("%:p") )
	    call s:Utl_processUrl(url, cmd.suffix)
        else	" the operand is the URL
	    call Utl_trace("- `".operand."' (arg2) is not a keyword. So is directly taken as an URL")
	    call s:Utl_processUrl(operand, cmd.suffix)
	endif

    elseif cmd == 'help'
	if exists('a:2') | let operand=s:abbr2longArg(cmd,a:2) | else | let operand='manual' | endif
	call Utl_trace("- arg2 (operand)  provided or by default = `".operand."'\n")   " CR054_extra_nl

	if operand=='manual'
	    help utl_usr.txt
	elseif operand=='commands'
	    call Utl('openLink', 'file://'.Utl_utilBack2FwdSlashes(expand(g:utl__file)).'#r=cmd_reference', 'sview')
	else
	    echohl ErrorMsg | echo "invalid argument: `".operand."'" | echohl None
	endif

    else
	echohl ErrorMsg | echo "invalid argument: `".cmd."'" | echohl None
    endif
    call Utl_trace("- end function Utl()",1,-1)
endfu

"]

"--- Set unset Utl options to defaults (id=options) [

if ! exists("utl_opt_verbose")
    let utl_opt_verbose=0
endif
if ! exists("utl_opt_highlight_urls")
    let utl_opt_highlight_urls='yes'
endif
"]


"--- Suggested mappings for most frequent commands  [id=suggested_mappings] [
"
" nmap <unique> <Leader>ge :Utl openLink underCursor edit<CR>
" nmap <unique> <Leader>gu :Utl openLink underCursor edit<CR>
" nmap <unique> <Leader>gE :Utl openLink underCursor split<CR>
" nmap <unique> <Leader>gS :Utl openLink underCursor vsplit<CR>
" nmap <unique> <Leader>gt :Utl openLink underCursor tabedit<CR>
" nmap <unique> <Leader>gv :Utl openLink underCursor view<CR>
" nmap <unique> <Leader>gr :Utl openLink underCursor read<CR>
"
"					[id=suggested_mappings_visual]
" vmap <unique> <Leader>ge "*y:Utl openLink visual edit<CR>
" vmap <unique> <Leader>gu "*y:Utl openLink visual edit<CR>
" vmap <unique> <Leader>gE "*y:Utl openLink visual split<CR>
" vmap <unique> <Leader>gS "*y:Utl openLink visual vsplit<CR>
" vmap <unique> <Leader>gt "*y:Utl openLink visual tabedit<CR>
" vmap <unique> <Leader>gv "*y:Utl openLink visual view<CR>
" vmap <unique> <Leader>gr "*y:Utl openLink visual read<CR>
"
"
" nmap <unique> <Leader>cfn :Utl copyFileName underCursor native<CR>
" nmap <unique> <Leader>cfs :Utl copyFileName underCursor slash<CR>
" nmap <unique> <Leader>cfb :Utl copyFileName underCursor backSlash<CR>
"
" vmap <unique> <Leader>cfn "*y:Utl copyFileName visual native<CR>
" vmap <unique> <Leader>cfs "*y:Utl copyFileName visual slash<CR>
" vmap <unique> <Leader>cfb "*y:Utl copyFileName visual backSlash<CR>
"
"
" nmap <unique> <Leader>cl :Utl copyLink underCursor<CR>
"
" vmap <unique> <Leader>cl "*y:Utl copyLink visual<CR>
"
"]

let s:utl_esccmdspecial = '%#'	" keep equal to utl_scm.vim#__esc

" isfname adapted to URI Reference characters
let s:isuriref="@,48-57,#,;,/,?,:,@-@,&,=,+,$,,,-,_,.,!,~,*,',(,),%"

"----------------------------------------------------------id=thl_gourl---------
" Process URL (or read: URI, if you like---Utl isn't exact there) under
" cursor: searches for something like <URL:myUrl> or <A HREF="myUrl"> (depending
" on the context), extracts myUrl, an processes that Url (e.g. retrieves the
" document and displays it).
"
" - Arg dispMode -> see <URL:#r=dispMode>
"
fu! s:Utl_goUrl(dispMode)
    call Utl_trace("- start processing (dispMode=".a:dispMode.")",1,1)
    let url =  Utl_getUrlUnderCursor()
    if url == ''
	let v:errmsg = "No URL under Cursor"
	echohl ErrorMsg | echo v:errmsg | echohl None
    else 
	call s:Utl_processUrl(url, a:dispMode)
    endif
    call Utl_trace("- end processing.",1,-1) 
endfu

"-------------------------------------------------------------------------------
" Tries to extract an URL in current buffer at current cursor position.
"
" Returns: URL under cursor if any, else ''
"
fu! Utl_getUrlUnderCursor()
    call Utl_trace("- start getting URL under cursor",1,1) 

    let line = getline('.')
    let icurs = col('.') - 1	" `Index-Cursor'

    call Utl_trace("- first try: checking for URL with embedding like <url:xxx> in current line...",1,1) 
    let url = s:Utl_extractUrlByPattern(line, icurs, '')

    if url=='<undef>'
	call Utl_trace("- ...no",1,-1)
	call Utl_trace("- retry: checking for embedded URL spanning over range of max 5 lines...",1,1) 
	let lineno = line('.')
	" (lineno-1/2 can be negative -> getline gives empty string -> ok)
	let line = getline(lineno-2) . "\n" . getline(lineno-1) . "\n" .
		 \ getline(lineno) . "\n" .
		 \ getline(lineno+1) . "\n" . getline(lineno+2)
	" `Index of Cursor'
	" (icurs off by +2 because of 2 \n's, plus -1 because col() starts at 1 =    +1)
	let icurs = strlen(getline(lineno-2)) + strlen(getline(lineno-1)) + col('.') +1

	let url = s:Utl_extractUrlByPattern(line, icurs, '')
    endif

    if url=='<undef>'
	call Utl_trace("- ...no", 1, -1)
	call Utl_trace("- retry: checking if [ ] style reference...", 1, 1) 
	if stridx(line, '[') != -1
	    let isfname_save = &isfname | let &isfname = s:isuriref " ([)
	    let pat = '\(\(\[[A-Z0-9_]\{-}\]\)\(#\f*\)*\)'	    " &isfname here in \f
	    let url = s:Utl_extractUrlByPattern(line, icurs, pat)
	    let &isfname = isfname_save				    " (]) 
	    " remove trailing punctuation characters if any
	    if url!='<undef>'
		call Utl_trace("- removing trailing punctuation chars from URL if any")
		let url = substitute(url, '[.,:;!?]$', '', '')
	    endif
	endif
    endif

    if url=='<undef>'
	call Utl_trace("- ...no", 1,-1)
	call Utl_trace("- retry: checking for unembedded URL under cursor...", 1,1) 
	" Take <cfile> as URL. But adapt isfname to match all allowed URI Reference characters
	let isfname_save = &isfname | let &isfname = s:isuriref " ([)
	let url = expand("<cfile>")
	let &isfname = isfname_save				" (]) 
    endif


    if url!=''
	call Utl_trace("- ...yes, URL found: `".url."'", 1,-1) 
    else
	call Utl_trace("- ...no", 1,-1)
    endif

    call Utl_trace("- end getting URL under cursor.",1,-1) 
    return url
endfu

"--------------------------------------------------------id=thl_curl------------
" `Utl_extractUrlByPattern' - Extracts embedded URLs from 'linestr':
" Extracts URL from given string 'linestr' (if any) at position 'icurs' (first
" character in linestr is 0). When there is no URL or icurs does not hit the
" URL (i.e. 'URL is not under cursor') returns '<undef>'. Note, that there can
" be more than one URL in linestr. Linestr may contain newlines (i.e. supports
" multiline URLs).
"
" 'pat' argument:
" Embedded URL means, that the URL is surrounded by some tag or characters
" to allow for safe parsing, for instance '<url:'...'>'. This regexp pattern
" has to specify a group \(...\) by which defines the URL.
" Example : '<url:\([^<]\{-}\)>'. If an empty pattern '' is given, default
" patterns apply (see code below).
"
" Examples:
"   :echo s:Utl_extractUrlByPattern('Two Urls <URL:/foo/bar> in this <URL:/f/b> line', 35, '')
"   returns `/f/b'
"
"   :echo s:Utl_extractUrlByPattern('Two Urls <URL:/foo/bar> in this <URL:/f/b> line', 28, '')
"   returns `<undef>'
"
"   :echo s:Utl_extractUrlByPattern('Another embedding here <foo bar>', 27, '')
"   returns `foo bar'
"	
" Details:
" - The URL embedding (or if embedding at all) depends on the context: HTML
"   has different embedding than a txt file.
" - Non HTML embeddings are of the following form: <URL:...>, <LNK:...> or
"   <...>
" - Returns `<undef>' if `no link under cursor'. (Note that cannot cause
"   problems because `<' is not a valid URI character)
" - Empty Urls are legal, e.g. <URL:>
" - `Under cursor' is like with vim's gf-command: icurs may also point to
"   whitespace before the cursor. (Also pointing to the embedding characters
"   is valid.)
"
fu! s:Utl_extractUrlByPattern(linestr, icurs, pat)
    let pat = a:pat
    call Utl_trace("- start extracting URL by pattern `".pat."'",1,1) 

    if pat == ''
	call Utl_trace("- pattern is <undef>, determine based on file type") 

	if &ft == 'html'
	    let embedType = 'html'
	else
	    let embedType = 'txt'
	endif

	" (pat has to have the Url in first \(...\) because ({) )
	if  embedType == 'html'
	    call Utl_trace("- file type is 'html'")
	    " Html-Pattern: 
	    " - can have other attributes in <A>, like
	    "   <A TITLE="foo" HREF="#bar">  (before and/or behind HREF)
	    " - can have Whitespace embedding the `=' like
	    "   <A HREF = "#bar">
	    "   Note: Url must be surrounded by `"'. But that should not be mandatory...
	    "   Regexp-Guru please help!
	    let pat = '<A.\{-}HREF\s*=\s*"\(.\{-}\)".\{-}>'

	else
	    call Utl_trace("- file type is not 'html', so use generic pattern")
	    " Allow different embeddings: <URL:myUrl>, <myUrl>.
	    " Plus <LNK:myUrl> for backward compatibility utl-1.0 and future
	    " extension.
	    " ( % in pattern means that this group doesn't count as \1 )
	    let pat = '<\%(URL:\|LNK:\|\)\([^<]\{-}\)>'

	endif
	call Utl_trace("- will use pattern `".pat."'") 

    endif

    let linestr = a:linestr
    let icurs = a:icurs

    " do match() and matchend() ic (i.e. allow url: urL: Url: lnk: lnk: LnK:
    " <a href= <A HREF= ...)
    let saveIgnorecase = &ignorecase |  set ignorecase	    " ([)

    call Utl_trace("- now try to extract URL from given string using this pattern") 
    while 1
	" (A so called literal \n here (and elsewhere), see
	" <URL:vimhelp:expr-==#^since a string>.
	" \_s* can't be used because a string is considered a single line.)
	let ibeg = match(linestr, "[ \\t \n]*".pat)

	if ibeg == -1 || ibeg > icurs
	    let curl = '<undef>'
	    break
	else
	    " matchstart before cursor or same col as cursor,
	    " look if matchend is ok (i.e. after or equal cursor)
	    let iend = matchend(linestr, "[ \\t \n]*".pat) -1
	    if iend >= icurs
		" extract the URL itself from embedding
		let curl = substitute(linestr, '^.\{-}'.pat.'.*', '\1', '')   " (})
		break
	    else
		" match was before cursor. Check for a second URL in linestr;
		" redo with linestr = `subline' behind the match
		let linestr = strpart(linestr, iend+1, 9999)
		let icurs = icurs-iend-1
		continue
	    endif
	endif
    endwhile

    let &ignorecase = saveIgnorecase	    " (])
    call Utl_trace("- end extracting URL by pattern, returning URL=`".curl."'",1,-1) 
    return curl
endfu


"-------------------------------------------------------------------------------
" Switch syntax highlighting for URLs on or off. Depending on the config
" variable g:utl_opt_highlight_urls
fu! s:Utl_setHighl()

    if g:utl_opt_highlight_urls ==? 'yes'
	augroup utl_highl
	  au!
	  au BufWinEnter * syn case ignore

	  " [id=highl_custom]
	  " Highlighting of URL surrounding `<url' and `>'		" [id=highl_surround]
	  "au BufWinEnter * hi link UtlTag Identifier	" as of Utl v2.0
	  "au BufWinEnter * hi link UtlTag Ignore	" `<url:' and '>' invisible like | | in Vim help
	  "au BufWinEnter * hi link UtlTag PreProc

	  " Highlighting of URL itself (what is inside `<url' and '>'	" [id=highl_inside]
	  "	    Some fixed colors ( not changing with :colorscheme, but all underlined )
	  "au BufWinEnter * hi UtlUrl ctermfg=LightBlue guifg=LightBlue cterm=underline gui=underline term=reverse
	  "au BufWinEnter * hi UtlUrl ctermfg=Blue guifg=Blue cterm=underline gui=underline term=reverse
	  "au BufWinEnter * hi UtlUrl ctermfg=Cyan guifg=Cyan cterm=underline gui=underline term=reverse
	  "	    Some Standard group names (see <url:vimhelp:group-name>)
	  "au BufWinEnter * hi link UtlUrl Tag
	  "au BufWinEnter * hi link UtlUrl Constant
	  au BufWinEnter * hi link UtlUrl Underlined


	  au BufWinEnter * syn region UtlUrl matchgroup=UtlTag start="<URL:" end=">" containedin=ALL
	  au BufWinEnter * syn region UtlUrl matchgroup=UtlTag start="<LNK:" end=">" containedin=ALL

	  au BufWinEnter utl*.vim hi link UtlTrace Comment
	  au BufWinEnter utl*.vim syn region UtlTrace matchgroup=UtlTrace start="call Utl_trace" end=")" containedin=ALL
	  au BufWinEnter * syn case match
	augroup END

    else 
	augroup utl_highl
	  au!
	augroup END
	augroup! utl_highl
	" Clear for current buffer to make turn-off instantaneously visible.
	" ... but does not seem to work everywhere.
	if hlexists('UtlTag')
	    syntax clear UtlTag
	endif
	if hlexists('UtlUrl')
	    syntax clear UtlTag
	endif
	if hlexists('UtlTrace')
	    syntax clear UtlTrace
	endif

    endif

endfu

call s:Utl_setHighl()

"-------------------------------------------------------------------------------
" Process given Url.
"
" Processing means: retrieve or address or load or switch-to or query or
" whatever the resource given by `url'.
" When succesful, then a local file will (not necessarly) exist, and
" is displayed by vim.  Or is displayed by a helper application (e.g.
" when the Url identifies an image).  Often the local file is cache
" file created ad hoc (e.g. in case of network retrieve).
"
" - The uriref argument can contain line breaks. \s*\n\s* Sequences are
"   collapsed. Other Whitespace is left as is (CR019, CR052).
"   See also <URL:http://www.ietf.org/rfc/rfc2396.txt> under
"   chapter E, Recommendations.
" 
" Examples:
"   call s:Utl_processUrl('file:///path/to/file.txt', 'edit')
"
"   call s:Utl_processUrl('file:///usr/local/share/vim/', 'vie')
"		" may call Vim's explorer
"
"   call s:Utl_processUrl('http://www.vim.org', 'edit')
"		" call browser on URL
"
"   call s:Utl_processUrl('mailto:stb@bf-consulting.de', 'vie')
"		" the local file may be the return receipt in this case
"
fu! s:Utl_processUrl(uriref, dispMode)
    call Utl_trace("- start processing URL `".a:uriref."' in processing mode `".a:dispMode."'",1,1) 

    let urirefpu = a:uriref	" uriref with newline whitespace sequences purged
    " check if newline contained. Collapse \s*\n\s
    if match(a:uriref, "\n") != -1
	let urirefpu = substitute(a:uriref, "\\s*\n\\s*", "", "g")
	call Utl_trace("- URL contains new line characters. Remove them.")
	call Utl_trace("  now URL= `".urirefpu."'") 
    endif

    let uri = UriRef_getUri(urirefpu)
    let fragment = UriRef_getFragment(urirefpu)

    call Utl_trace("- fragment `".fragment."' stripped from URL")

    "--- Handle Same Document Reference (sdreference)
    " processed as separate case, because:
    " 1. No additional 'retrieval' should happen (see
    "    <URL:http://www.ietf.org/rfc/rfc2396.txt#4.2. Same-document>).
    " 2. UtlUri_abs() does not lead to a valid absolute Url (since the base-path-
    "	 file-component will always be discarded).
    "
    if uri == ''
	call Utl_trace("- is a same document reference. Go directly to fragment processing (in mode 'rel')") 
	    " m=go
	normal m'
	call s:Utl_processFragmentText( fragment, 'rel' )
	call Utl_trace("- end processing URL",1,-1)
	return
    endif


    call Utl_trace("- start normalize URL to an absolute URL",1,1)
    let scheme = UtlUri_scheme(uri)
    if scheme != '<undef>'
	call Utl_trace("- scheme defined (".scheme.") - so is an absolute URL")
	let absuri = uri
    else	" `uri' is formally no absolute URI but look for some
		" heuristic, e.g. prepend 'http://' to 'www.vim.org'
	call Utl_trace("- scheme undefined - so is a relative URL or a heuristic URL")
	call Utl_trace("- check for some heuristics like www.foo.com -> http://www.foo.com... ",0)
	let absuri = s:Utl_checkHeuristicAbsUrl(uri)
	if absuri != ''
	    let scheme = UtlUri_scheme(absuri)
	    call Utl_trace("yes,") | call Utl_trace("  absolute URL constructed by heuristic is `".absuri."'") 
	else
	    call Utl_trace("no") 
	endif
    endif
    if scheme == '<undef>'
	let curPath = Utl_utilBack2FwdSlashes( expand("%:p") )
	if stridx(curPath, '://') != -1	    " id=url_buffer (e.g. by netrw)
	    call Utl_trace("- buffer's name looks like an absolute URL (has substring ://)")
	    call Utl_trace("  so take it as base URL.") 
	    let base = curPath
	else
	    call Utl_trace("- try to construct a `file://' base URL from current buffer... ",0) 
	    " No corresponding resource to curPath known.   (id=nobase)
	    " i.e. curPath was not retrieved through Utl.
	    " Now just make the usual heuristic of `file://localhost/'-Url;
	    " assume, that the curPath is the resource itsself. If then the 
	    " retrieve with the so generated Url is not possible, nothing
	    " severe happens.
	    if curPath == ''
		call Utl_trace("not possible, give up")
		let v:errmsg = "Cannot make a base URL from unnamed buffer. Edit a file and try again"
		echohl ErrorMsg | echo v:errmsg | echohl None
		call Utl_trace("- end normalize URL to an absolute URL",1,-1)
		call Utl_trace("- end processing URL",1,-1)
		return
	    endif
	    let base = 'file://' . curPath
	    call Utl_trace("done,")
	endif
	call Utl_trace("  base URL is `".base."'") 
	let scheme = UtlUri_scheme(base)
	call Utl_trace("- construct absolute URL from combining base URL and relative URL")
	let absuri = UtlUri_abs(uri,base)
    endif
    call Utl_trace("- assertion: now have absolute URL `".absuri."' with scheme `".scheme."'")
    call Utl_trace("- end normalize URL to an absolute URL",1,-1)

    if a:dispMode==? 'copyLink'
	call Utl_trace("processing mode is `copyLink'. Copy link to clipboard")
	call setreg('*', absuri)
	echo "Copied `".@*."' to clipboard"
	call Utl_trace("- end processing URL",1,-1)
	return
    endif


    "--- Call the appropriate retriever (see <URL:utl_scm.vim>)
    call Utl_trace("- start scheme handler processing",1,1)

    " Always set a jump mark to allow get back to cursor position before
    " jump (see also CR051).
	" m=go	id=_setj
    normal m'

    let cbfunc = 'Utl_AddressScheme_' . scheme
    call Utl_trace("- constructing call back function name from scheme: `".cbfunc."'") 
    if !exists('*'.cbfunc)
	let v:errmsg = "Sorry, scheme `".scheme.":' not implemented"
	echohl ErrorMsg | echo v:errmsg | echohl None
        call Utl_trace("- end scheme handler processing",1,-1)
	call Utl_trace("- end processing URL",1,-1)
	return
    endif
    call Utl_trace("- calling call back function with arguments:")
    call Utl_trace("  arg 1 - absolute URL=`".absuri."'") 
    call Utl_trace("  arg 2 - fragment    =`".fragment."'") 
    call Utl_trace("  arg 3 - display Mode=`".a:dispMode."'") 
    exe 'let ret  = ' cbfunc . '("'.absuri.'", "'.fragment.'", "'.a:dispMode.'")'
    call Utl_trace("- call back function `".cbfunc."' returned list:`". join(ret,',') ."'")
    exe "normal \<C-L>"	| " Redraw seems necessary for non GUI Vim under Unix'es

    if !len(ret)
	call Utl_trace("- empty list -> no further processing")
        call Utl_trace("- end scheme handler processing",1,-1)
	call Utl_trace("- end processing URL",1,-1)
	return
    endif

    let localPath = ret[0]
    let fragMode = get(ret, 1, 'abs')
    call Utl_trace("- first list element (local path): `".localPath."'")
    call Utl_trace("- second list element (fragment mode) or default: `".fragMode."'") 

    " Assertion
    if stridx(localPath, '\') != -1 
	echohl ErrorMsg
	call input("Internal Error: localPath `".localPath."' contains backslashes <RETURN>") 
	echohl None
    endif

    call Utl_trace("- assertion: a local path corresponds to URL") 
    call Utl_trace("- end scheme handler processing",1,-1)

    let dispMode = a:dispMode
    if a:dispMode == 'copyFileName_native'
	if has("win32") || has("win16") || has("win64") || has("dos32") || has("dos16")
	    call Utl_trace("- changing dispMode `copyFileName_native' to 'copyFileName_backSlash' since under Windows")
	    let dispMode = 'copyFileName_backSlash'
	else
	    call Utl_trace("- changing dispMode `copyFileName_native' to 'copyFileName_slash' since not under Windows")
	    let dispMode = 'copyFileName_slash'
	endif
    endif

    if dispMode == 'copyFileName_slash'
	call Utl_trace("- processing mode is `copyFileName_slash': copy file name, which corresponds to link")
	call Utl_trace("  (with forward slashes) to clipboard")
	call setreg('*', localPath )
	echo "Copied `".@*."' to clipboard"
	call Utl_trace("- end processing URL",1,-1)
	return
    elseif dispMode == 'copyFileName_backSlash'
	call Utl_trace("- processing mode is `copyFileName_backSlash': copy file name, which corresponds to link")
	call Utl_trace("  (with backslashes) to clipboard")
	call setreg('*', Utl_utilFwd2BackSlashes(localPath) )
	echo "Copied `".@*."' to clipboard"
	call Utl_trace("- end processing URL",1,-1)
	return
    endif

    " See if media type is defined for localPath, and if yes, whether a
    " handler is defined for this media type (if not the Setup is called to
    " define one). Everything else handle with the default handler
    " Utl_displayFile(), which displays the document in a Vim window.
    " The pseudo handler named 'VIM' is supported: Allows bypassing the media
    " type handling and call default vim handling (Utl_displayFile)
    " although there is a media type defined.
    call Utl_trace("- start media type handler processing",1,1)

    call Utl_trace("- check if there is a file-name to media-type mapping for local path")
    call Utl_trace("  (hardcoded in Utl)... ",0)

    let contentType = s:Utl_checkMediaType(localPath)

    if contentType == ''
        call Utl_trace("no. Display local path in this Vim.")
    else
	call Utl_trace("yes, media type is `".contentType."'.")
	let slashPos = stridx(contentType, '/')

	let var_s = 'g:utl_cfg_hdl_mt_' . substitute(contentType, '[-/+.]', '_', 'g')
	call Utl_trace("- constructing Vim variable for specific media type handler:")
	call Utl_trace("  `".var_s."'. Now check if it exists...")
	if exists(var_s)
	    call Utl_trace("  ...exists, and will be used")
	    let var = var_s
	else
	    call Utl_trace("  ...does not exist. Now check generic media type handler variable")
	    let var_g = 'g:utl_cfg_hdl_mt_generic'
	    if exists(var_g)
		call Utl_trace("- Vim variable `".var_g."' does exist and will be used")
	    else
		call Utl_trace("  Vim variable `".var_g."' does not exist either")
	    endif
	    let var = var_g
	endif

	if ! exists(var)    " Entering setup
	    echohl WarningMsg
	    call input('No handler for media type '.contentType.' defined yet. Entering Setup now. <RETURN>')
	    echohl None
	    call s:Utl_processUrl('config:#r=utl_cfg_hdl_mt_generic', 'split') " (recursion, setup)
	    call Utl_trace("- end media type handler processing",1,-1)
	    call Utl_trace("- end processing URL",1,-1)
	    return
	endif
	exe 'let varVal =' . var
	call Utl_trace("- Variable has value `".varVal."'")
	if varVal ==? 'VIM'
	    call Utl_trace("- value of variable is 'VIM': display in this Vim")
	else
	    call Utl_trace("- construct command by expanding any % conversion specifiers.")
	    let convSpecDict= { 'p': localPath, 'P': Utl_utilFwd2BackSlashes(localPath),
		    \ 'f': (fragment=="<undef>" ? "" : fragment) }	" '<undef>' -> '' for external handler
	    exe 'let [errmsg,cmd] = Utl_utilExpandConvSpec('.var.', convSpecDict)'
	    if errmsg != ""
		echohl ErrorMsg
		echo "The content of the Utl-setup variable `".var."' is invalid and has to be fixed! Reason: `".errmsg."'"
		echohl None
		call Utl_trace("- end media type handler processing",1,-1)
		call Utl_trace("- end processing URL",1,-1)
		return
	    endif
	    call Utl_trace("- constructed command is: `".cmd."'")
	    " Escape string to be executed as a ex command (i.e. escape some
	    " characters from special treatment <URL:vimhelp:cmdline-special>)
	    " and execute the command
	    let escCmd = escape(cmd, s:utl_esccmdspecial)
	    if escCmd != cmd
		call Utl_trace("- escape characters, command changes to: `".escCmd."'")
	    endif
	    call Utl_trace("- execute command with :exe") 
	    exe escCmd
	    call Utl_trace("- end media type handler processing",1,-1)
	    call Utl_trace("- end processing URL",1,-1)
	    return
	endif
    endif
    call Utl_trace("- end media type handler processing",1,-1)

    if s:Utl_displayFile(localPath, dispMode)
	call s:Utl_processFragmentText(fragment, fragMode)
    endif
    call Utl_trace("- end processing URL",1,-1)
endfu


"id=Utl_checkHeuristicAbsUrl--------------------------------------------------
"
" This function is called for every URL which is not an absolute URL.
" It should check if the URL is meant to be an absolute URL and return
" the absolute URL. E.g. www.host.domain -> http://www.host.domain.
"
" You might want to extend this function for your own special URLs
" and schemes, see #r=heur_example below
"
fu! s:Utl_checkHeuristicAbsUrl(uri)

    "--- [1] -> foot:1
    if match(a:uri, '^\[.\{-}\]') != -1
	return substitute(a:uri, '^\[\(.\{-}\)\]', 'foot:\1', '')

    "--- www.host.domain -> http://www.host.domain
    elseif match(a:uri, '^www\.') != -1
	return 'http://' . a:uri

    "--- user@host.domain -> mailto:user@host.domain
    elseif match(a:uri, '@') != -1
	return 'mailto:' . a:uri

    "--- :xxx  -> vimscript::xxx
    elseif match(a:uri, '^:') != -1
	return 'vimscript:' . a:uri

    " BT12084 -> BT:12084			    #id=heur_example
    " This is an example of a custom heuristics which I use myself. I have a
    " text file which contains entries like 'BT12084' which refer to that id
    " 12084 in a bug tracking database.
    elseif match(a:uri, '^[PB]T\d\{4,}') != -1
     	return substitute(a:uri, '^\([PB]T\)\(\d\+\)', 'BT:\2', '')

    endif

    return ''
endfu


"------------------------------------------------------------------------------
" Escape some special characters in  fileName  which have special meaning
" in Vim's command line but what is not desired in URLs.
" Example: In file 'a%b.txt' the % must not be expanded to the current file.
"
" - returns: Escaped fileName
"
fu! s:Utl_escapeCmdLineSpecialChars(fileName)

    " - Escape characters '#' and '%' with special meaning for Vim
    "   cmd-line (see <URL:vimhelp:cmdline-special> because they must have no special
    "   meaning in URLs.
    let escFileName = escape(a:fileName, s:utl_esccmdspecial)

    " - Also escape '$': Will otherwise tried to be expanded by Vim as Envvar (CR030).
    "   But only escape if there is an identifier character after the $ (CR053).
    let escFileName = substitute(escFileName, '\$\(\I\)', '\\$\1', 'g')

    " - Also escape blanks because single word needed, e.g. `:e foo bar'.
    "   Escape spaces only if on unix (no problem on Windows) (CR033)
    if has("unix")
	let escFileName = escape(escFileName, ' ')
    endif

    return escFileName
endfu

"-------------------------------------------------------------------------------
" Description: 
" Display file `localPath' in a Vim window as determined by `dispMode'
" There is special treatment if `localPath' already loaded in a buffer and
" there is special treatment if current buffer cannot be abandoned.
" Escapes characters in localPath which have special meaning for Vim but
" which must not have special meaning in URL paths.
"
" - `dispMode' specification:	    (id=dispMode)
"    Resembles XML-XLink's `show' attribut. Value is taken directly as Vim
"    command. Examples: 'view', 'edit', 'sview', 'split', 'read', 'tabe'
"
" - localPath specification: 
"   . May contain any characters that the OS allows (# % $ ' ')
"     Note: No percent escaping here, localPath is a file name not an URL.
"     For instance %20.txt is taken as literal file name.
"
" - returns: 1 on success (a:localPath loaded), else 0
"
" - collaboration:
"   . Does not explicitly set the cursor
"   . Does not explicitly set the ' mark
"
" Example:	:call s:Utl_displayFile('t.txt', 'split')
"
fu! s:Utl_displayFile(localPath, dispMode)
    call Utl_trace("- start display file `".a:localPath."' in mode `".a:dispMode."'",1,1)

    let bwnrlp = bufwinnr(a:localPath)
    if bwnrlp != -1 && winnr() == bwnrlp
	call Utl_trace("- file already displayed in current window")
	call Utl_trace("- end display file",1,-1)
	return 1
    endif

    if bwnrlp != -1
	" localPath already displayed, but not in current window
	" Just make this buffer the current window.
	call Utl_trace("- file already displayed, but not in other window. Move to that window")
	exe bwnrlp . "wincmd w"
    else    " Open file
	call Utl_trace("- file not yet displayed in any window")

	" Possibly alter dispMode to avoid E37 error	(id=_altersa)
	" If buffer cannot be <URL:vimhelp:abandon>ned, for given dispMode,
	" silently change the dispMode to a corresponding split-dispMode. Want
	" to avoid annoying E37 message when executing URL on modified buffer (CR024)
	let dispMode = a:dispMode
	if getbufvar(winbufnr(0),"&mod") && ! getbufvar(winbufnr(0),"&awa") && ! getbufvar(winbufnr(0),"&hid")
	    if dispMode == 'edit'
		let dispMode = 'split'
		call Utl_trace("- current window can probably not be quit, so silently change mode to `split'")
	    elseif dispMode == 'view'
		let dispMode = 'sview'
		call Utl_trace("- current window can probably not be quit, so silently change mode to `sview'")
	    endif
	endif

	let escLocalPath = s:Utl_escapeCmdLineSpecialChars(a:localPath)
	if escLocalPath != a:localPath
	    call Utl_trace("- Escaped one or more characters out of #,%,$ (under Unix also blank)")
	    call Utl_trace("  because these would else be expanded in Vim's command line")
	    call Utl_trace("  File name changed to: `".escLocalPath."'")
	endif


	"--- Try load file or create new buffer. Then check if buffer actually
	"   loaded - might fail for if E325 (swap file exists) and user abort
	" 
	let cmd = dispMode.' '.escLocalPath
	call Utl_trace("- trying to load/display file with command: `".cmd."'\n")   " CR054_extra_nl
	exe cmd
	exe "normal \<C-L>"	| " Redraw seems necessary for non GUI Vim under Unix'es

	if bufwinnr(escLocalPath) != winnr()	" not loaded
	    call Utl_trace("- not loaded.")
	    call Utl_trace("- end display file (not successful)",1,-1)
	    return 0
	endif

    endif

    call Utl_trace("- end display file (successful)",1,-1)
    return 1
endfu

"----------------------------------------------------------id=utl_checkmtype----
" Possibly determines the media type (= mime type) for arg `path', e.g. 
" pic.jpeg -> 'image/jpeg' and returns it. Returns an empty string if media
" type cannot be determined or is uninteresting to be determined. Uninteresting
" means: Only those media types are defined here which are of potential
" interest for being handled by some external helper program (e.g. MS Word for
" application/msword or xnview for application/jpeg).
"
" When this function returns a non empty string Utl checks if a specific media
" type handler is defined. If not Utl's setup utility is called to define one.
"
" - You may add other mediatypes. See
"   <URL:ftp://ftp.iana.org/assignments/media-types/> or
"   <URL:http://www.iana.org/assignments/media-types/> for the registry of
"   media types. On Linux try <URL:/etc/mime.types> In general this makes only
"   sense when you also supply a handler for every media type you define, see
"   <URL:./utl_rc.vim#r=mediaTypeHandlers>.
"
fu! s:Utl_checkMediaType(path)

    if isdirectory(a:path)
	return "text/directory"
    endif
  
    let ext = fnamemodify(a:path, ":e")

    let mt = ''

    " MS windows oriented
    if ext==?'doc' || ext==?'dot' || ext==?'wrd'
        let mt = 'application/msword'
    elseif ext==?'xls'
        let mt = 'application/excel'
    elseif ext==?'ppt'
        let mt = 'application/powerpoint'
    elseif ext==?'wav'
        let mt = 'audio/wav'
    elseif ext==?'msg'
        let mt = 'application/msmsg'
    elseif ext==?'avi'
	let mt = 'video/x-msvideo'

    " universal
    elseif ext==?'dvi'
	let mt = 'application/x-dvi'
    elseif ext==?'pdf'
        let mt = 'application/pdf'
    elseif ext==?'rtf'
        let mt = 'application/rtf'
    elseif ext==?'ai' || ext==?'eps' || ext==?'ps'
	let mt = 'application/postscript'
    elseif ext==?'rtf'
        let mt = 'application/rtf'
    elseif ext==?'zip'
        let mt = 'application/zip'
    elseif ext==?'mp3' || ext==?'mp2' || ext==?'mpga'
	let mt = 'audio/mpeg'
    elseif ext==?'png'
	let mt = 'image/png'
    elseif ext==?'jpeg' || ext==?'jpg' || ext==?'jpe'  || ext==?'jfif' 
	let mt = 'image/jpeg'
    elseif ext==?'tiff' || ext==?'tif'
	let mt = 'image/tiff'
    elseif ext==?'gif' || ext==?'gif'
	let mt = 'image/gif'
    elseif ext==?'mp2' || ext==?'mpe' || ext==?'mpeg' || ext==?'mpg'
	let mt = 'video/mpeg'

    " id=texthtml
    elseif ext==?'html' || ext==?'htm'
     	let mt = 'text/html'

    " unix/linux oriented
    elseif ext==?'fig'
	let mt = 'image/x-fig'

    endif
    return mt 

endfu

"id=Utl_processFragmentText-----------------------------------------------------
" Description:
" Position cursor in current buffer according `fragment', modified by
" `fragMode' which can have values 'abs' or 'rel'.
"
" - arg `fragment' can be:
"   tn=string	    - searches  string  beginning at start position forward.
"		      The naked fragment (without a `xx=' as prefix defaults
"		      to tn=).
"   tp=string	    - searches  string  beginning at start position backward.
"   line=number	    - move cursor  number  lines from start position. Number
"		      can be positive or negative. If `fragMode' is 'abs'
"		      -1 denotes the last line, -2 the before last line etc.
"   r=identifier    - (IdReference) search for  id=identifier\>  starting from
"		      begin of buffer. `fragMode' is ignored.
"
" - arg `fragMode' modifies the start position. Can have the values:
"   'abs' = absolute: Cursor is set to begin or end of document, depending on
"	    fragment, then position starting from there.
"	    Start position for tn=, line=nnn, line=+nnn r= is begin of buffer.
"	    Start position for tp=, line=-nnn is end of buffer.
"   'rel' = relative: Start positioning the cursor from current position.
"
" Details: 
" - `fragment' will be URI-Unescaped before processing (e.g. 'tn=A%3aB' ->
"   'tn=A:B')
" - Interpretation of `fragment' depends on the filetype. But currently,
"   the only non generic treatment is for HTML references.
" - `Fragment' can be '<undef>' or '' (empty).
" - If `rel' position the cursor to begin or end of line prior to actual
"   search: a target string in the same line will not be found.
"   (Remark: Intent is to support Same-Document references: avoid that
"   the search finds the fragment definition itself. Should not be a
"   problem in other cases, e.g. vimhelp scheme)
"
" Known Bugs:
" - For 'abs' search does not find pattern starting at begin of file
"
fu! s:Utl_processFragmentText(fragment, fragMode)
    call Utl_trace("- start processing fragment `".a:fragment."' in mode `".a:fragMode."'",1,1) 

    if a:fragment == '<undef>' || a:fragment == ''
	call Utl_trace("- have no or empty fragment") 
	if a:fragMode=='abs'
	    call Utl_trace("- since mode is `abs' position cursor to begin of buffer") 
	    call cursor(1,1)
	else
	    call Utl_trace("- since mode is `rel' do nothing") 
	endif
	call Utl_trace("- end processing fragment",1,-1) 
	return
    endif

    let ufrag = UtlUri_unescape(a:fragment)
    if ufrag != a:fragment
        call Utl_trace("- unescaped URL to: `".ufrag."'") 
    endif

    if ufrag =~ '^line=[-+]\=[0-9]*$'
	call Utl_trace("- is a `line=' fragment") 

	let sign = substitute(ufrag, '^line=\([-+]\)\=\([0-9]*\)$', '\1', '')
	let num =  substitute(ufrag, '^line=\([-+]\)\=\([0-9]*\)$', '\2', '')

	if a:fragMode=='abs'
	    if sign == '-'
		call Utl_trace("- negative sign in mode 'abs': position cursor up ".num." lines from end of buffer") 
		call cursor( line('$') - num + 1, 1 )
	    else
		call Utl_trace("- positive sign in mode 'abs': position cursor to line ".num) 
		call cursor(num,1)
	    endif

	else
	    if sign == '-'
		call Utl_trace("- negative sign in mode 'rel': position cursor up ".num." lines from current position") 
		call cursor( line('.') - num , 1 )
	    else
		call Utl_trace("- positive sign in mode 'rel': position cursor down ".num." lines from current position") 
		call cursor( line('.') + num , 1 )
	    endif

	endif
	call Utl_trace("- end processing fragment",1,-1) 
	return
    endif

    " (the rest is positioning by search)
    " Note: \r is necessary for executing cmd with :normal.
    " Note: \M is used in patterns to do search nomagic (e.g. pattern a.c to find a.c
    " and not abc).

    let fragMode = a:fragMode
    let sfwd=1
    if ufrag =~ '^r='
	call Utl_trace("- is an ID reference. Construct file type dependent search pattern") 
	" ( \w\@! is normally the same as \> , i.e. match end of word,
	"   but is not the same in help windows, where 'iskeyword' is
	"   set to include non word characters. \w\@! is independent of
	"   settings )
	let val = substitute(ufrag, '^r=\(.*\)$', '\1', '')
	if &ft == 'html'
	    call Utl_trace("- file type is 'html' - search for NAME=") 
	    let cmd = '/\c\MNAME=\.\=' . val . '\w\@!' . "\r"
	else
	    call Utl_trace("- file type is not 'html' - search for id=") 
	    let cmd = '/\c\Mid=' . val . '\w\@!' . "\r"
	endif
	if fragMode=='rel'
	    call Utl_trace("- search will be with 'wrapscan' (since ID reference anywhere in text)") 
	    let opt_wrapscan='wrapscan'
	endif

    elseif ufrag =~ '^tp='  " text previous
	call Utl_trace("- is a `tp=' (Text Previous) fragment: search backwards") 
	let cmd = substitute(ufrag, '^tp=\(.*\)$', '?\\c\\M\1\r', '')
	let sfwd=0

    elseif ufrag =~ '^tn='  " tn= or naked. text next
	call Utl_trace("- is a `tn=' (Text Next) fragment: search forward") 
	let cmd = substitute(ufrag, '^tn=\(.*\)$', '/\\c\\M\1\r', '')

    else
	call Utl_trace("- is a naked fragment. Is treated like `tn=' (Text Next) fragment: search forward") 
	let cmd = '/\c\M' . ufrag . "\r"	" Note: \c\M vs \\c\\M at <#tp=substitute>
    endif


    " Initialize Cursor before actual search (CR051)
    if fragMode=='abs'
	if sfwd==1
	    call Utl_trace("- forward search in mode 'abs': starting search at begin of buffer") 
	    call cursor(1,1)
	else
	    call Utl_trace("- backward search in mode 'abs': starting search at end of buffer") 
	    call cursor( line('$'), col('$') )
	endif
    else
	if sfwd==1
	    call Utl_trace("- forward search in mode 'rel': starting search at end of current line") 
	    call cursor( line('.'), col('$') )
	else
	    call Utl_trace("- forward search in mode 'rel': starting search at begin of current line") 
	    call cursor( line('.'), 1)
	endif
    endif

    if ! exists('opt_wrapscan') 
	let opt_wrapscan = 'nowrapscan'
	call Utl_trace("- search will be with 'nowrapscan' (avoid false hit if mode='rel')") 
    endif

    " Do text search (id=fragTextSearch)

    "   (Should better use search() instead normal / - there is also a w flag)
    let saveWrapscan = &wrapscan | exe 'set '.opt_wrapscan  | "---[
    " (keepjumps because before jump mark is set before link execution (s. #r=_setj ).
    "  Call cursor() for line= fragments do not change jumps either.)
    call Utl_trace("- execute search command: `".cmd."'") 
    let v:errmsg = ""
    silent! exe "keepjumps normal " . cmd
    if v:errmsg != ""
	let v:errmsg = "fragment address  #" . a:fragment . "  not found in target"
	echohl ErrorMsg | echo v:errmsg | echohl None
    endif

    let &wrapscan = saveWrapscan		    "---]
    call Utl_trace("- restored previous value for 'wrapscan'") 

    call Utl_trace("- end processing fragment",1,-1) 
endfu

" Utility functions [

"id=Utl_utilExpandConvSpec--------------------------------------------------------
" Expands conversion specifiers like %p in  a:str  by replacing
" them by there replacement value. Conversion specifier - replacement pairs
" as provided in  convSpecDict  dictionary.
" Details :
" All occurrences of conversion specifier in a:str will be replaced.
" Specifiers not defined in convSpecDict lead to an error.
" The case of conversion specifier matters, e.g. %p and '%P' are different.
"
" Args:
" str		- string to be expanded
" convSpecDict	- dictionary containing specifier - replacement entries,
"		  e.g. 'p' - 'c:/path/to/file'
"
" Returns: List [errormessage, converted string],
"	   where either or the other is an empty string
"
fu! Utl_utilExpandConvSpec(str, convSpecDict)

    let rest = a:str
    let out = ''
    while 1

	let percentPos = stridx(rest, '%')
	if percentPos != -1
	    let left = strpart(rest, 0, percentPos)
	    let specifier = strpart(rest, percentPos+1, 1)
	    let rest = strpart(rest, percentPos+2)
	else
	    let out = out . rest
	    break
	endif
	if strpart(left, percentPos-1, 1) == '\'    " escaped \%
	    let left = strpart(left, 0, percentPos-1)
	    let repl = '%' . specifier
	else	    " not escaped
	    if specifier == ''
		return ["Unescaped % character at end of string >".a:str."<", ""]
	    elseif has_key(a:convSpecDict, specifier)
		let repl = a:convSpecDict[specifier]
	    else
		return ["Invalid conversion specifier `%".specifier."' in `".a:str.
		    \ "'. Valid specifiers are: `". join(map(keys(a:convSpecDict), '"%".v:val')), ""]
	    endif
	endif
	let out = out . left . repl

    endwhile
    return ["",out]

endfu

"-------------------------------------------------------------------------------
" Print tracing messages (with :echo) to see what's going on. 
" Only prints if global variable utl_opt_verbose is not 0. 
" Currently works only in on/off-manner. Might be extended to distinguish
" trace levels (as Vim's 'verbose' option does, see <url:vimhelp:'verbose'>)
"
" - args
"     msg,
"     [flush,]	    boolean, default=1 -> print msg directly
"     [incrLevel]   number, values= -1 (reduce indent), 0 (unchanged), +1 (augment indent)
"		    default ist 0 (unchanged)
"
let s:utl_trace_buffer = ''
let s:utl_trace_level = 0
fu! Utl_trace(msg, ...)

    if g:utl_opt_verbose == 0
	return
    endif
    "echo "                                DBG msg=`".a:msg."'"

    let flush=1
    if exists('a:1')
	let flush = a:1
    endif

    let incrLevel = 0
    if exists('a:2')
	let incrLevel = a:2
    endif

    " If negative, do it before printing
    if incrLevel < 0  
	let s:utl_trace_level += incrLevel
	" Assertion
	if s:utl_trace_level < 0
	    echohl ErrorMsg
	    call input("Internal Error: Utl_trace: negative indent. Setting to zero <RETURN>")
	    echohl None
	    let s:utl_trace_level = 0
	endif
	"echo "                                DBG (changed,before) utl_trace_level=`".s:utl_trace_level."'"
    endif 

    " echohl ErrorMsg
    " echo "Error: internal error: s:utl_trace_level < 0: `".s:utl_trace_level."'"
    " echohl None


    let s:utl_trace_buffer = s:utl_trace_buffer . a:msg
    if flush=='1'

	" construct indenting corresponding to level
	let indentNum = s:utl_trace_level
	let indent = ''
	while indentNum
	    "echo "                                DBG indentNum=`".indentNum."'"
	    let indent = indent . '  '  " indent depth is two blanks
	    let indentNum -= 1
	endwhile
	"echo "                                DBG indent=`".indent."'"

	echo indent . s:utl_trace_buffer
	let s:utl_trace_buffer = ''

    endif

    " If positive, do it after printing
    if incrLevel > 0  
	let s:utl_trace_level += incrLevel
	"echo "                                DBG (changed,after) utl_trace_level=`".s:utl_trace_level."'"
    endif 

endfu

"-------------------------------------------------------------------------------
" Descr: Creates a file named  a:outFile  as a copy of file  a:srcFile, where
" only the lines between the first and the second occurrence of  a:mark are kept.
" Details :
" - a:outFile  gets some additional header lines.
" - a:mark  is anchored at the beginning of the line (^ search)
" - a:mark  is taken literally (search with \M - nomagic for it) 
"
" Collaboration: 
" - Shows result to user by prompting hit-any-key
" - Except for use of utl_trace function pure utility function.
"
" Ret:	    -
"
"
fu! Utl_utilCopyExtract(srcFile, outFile, mark)
    call Utl_trace("- start Utl_utilCopyExtract(".a:srcFile.",".a:outFile.",".a:mark.")",1,1)

    let go_back = 'b ' . bufnr("%")
    enew!
    exe 'read '.a:srcFile
    setl noswapfile modifiable
    norm gg

    let buf = bufnr("%")

    " Delete from first line to the first line that starts with a:mark
    let delCmd='1,/\M^'.a:mark.'/d'
    call Utl_trace("- command to delete from top to begin mark= `".delCmd."'")
    exe delCmd

    " Delete from the now first line that starts with a:mark to the end of the text
    let delCmd='/\M^'.a:mark.'/,$d'
    call Utl_trace("- command to delete from end mark to bottom= `".delCmd."'")
    exe delCmd

    0insert
' *****
' CREATED BY VIM PLUGIN UTL.VIM BY FUNCTION Utl_utilCopyExtract()
' *****
.

    exe 'w! '.a:outFile
    exe go_back
    exe 'bwipeout ' . buf

    echohl MoreMsg
    call input("Success: Created file ".a:outFile." <RETURN>")
    echohl None
    call Utl_trace("- end Utl_utilCopyExtract()",1,-1)
endfu


"-------------------------------------------------------------------------------
" Substitute all slashes with forward slashes in copy of  a:str  and return it.
fu! Utl_utilFwd2BackSlashes(str)
    return substitute( a:str , '/', '\', 'g')
endfu
"-------------------------------------------------------------------------------
" Substitute all backslashes with slashes in copy of  a:str  and return it.
fu! Utl_utilBack2FwdSlashes(str)
    return substitute( a:str , '\', '/', 'g')
endfu

" ]

" BEGIN OF DEFINITION OF STANDARD UTL `DRIVERS'		      " id=utl_drivers [

"-------------------------------------------------------------------------------
" Retrieve a resource from the web using the wget network retriever.
" Function designed as g:utl_cfg_hdl_scm_http interface function, e.g. intended to
" be used via  :let g:utl_cfg_hdl_scm_http="call Utl_if_hdl_scm_http__wget('%u')".
" See also #r=utl_cfg_hdl_scm_http__wget
"
" Arg:	    url - URL to be downloaded
" Ret:	    global Vim var  g:utl__hdl_scm_ret_list  set, containing one element:
"	    the name of a temporary file where wget downloaded into.
"
" Setup:    See <url:config:#r=utl_if_hdl_scm_http_wget_setup>
"

fu! Utl_if_hdl_scm_http__wget(url)
    call Utl_trace("- start Utl_if_hdl_scm_http__wget(".a:url.")",1,1)

    " Possibly transfer suffix from URL to tempname for correct subsequent
    " media type handling If no suffix then assume 'html' (ok for
    " http://www.vim.org -> index.html). But is not generally ok
    " (example: http://www.vim.org/download.php).
    " TODO: 
    " Should determine media type from HTTP Header, e.g.
    " wget --save-headers -> Content-Type: text/html)
    let suffix = fnamemodify( UtlUri_path(a:url), ":e")
    if suffix == ''
	let suffix = 'html'
    endif

    let tmpFile = Utl_utilBack2FwdSlashes( tempname() ) .'.'.suffix
    call Utl_trace("- tmpFile name with best guess suffix: ".tmpFile)

    if ! executable('wget') 
	call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_mail does not exist")
	echohl WarningMsg
	let v:errmsg="No executable `wget' found."
	call input( v:errmsg . " Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=utl_if_hdl_scm_http_wget_setup split
	call Utl_trace("- end execution of Utl_AddressScheme_mail",1,-1) 
	return
    endif

    let cmd = '!wget '.a:url.' -O '.tmpFile
    call Utl_trace("- executing cmd: `".cmd."'")
    exe cmd
    call Utl_trace("- setting global list g:utl__hdl_scm_ret_list to `[".tmpFile."]'")
    let g:utl__hdl_scm_ret_list = [tmpFile]
    call Utl_trace("- end Utl_if_hdl_scm_http__wget()",1,-1)
endfu

"-------------------------------------------------------------------------------
" Display an email in Outlook
" Function designed as g:utl_cfg_hdl_scm_mail interface function, e.g. intended to
" be used via  :let g:utl_cfg_hdl_scm_mail="call Utl_if_hdl_scm_mail__outlook('%a',
" '%p','%d','%f','%s')". See also #r=utl_cfg_hdl_scm_mail__outlook
"
" Args:	    ...
" Ret:	    - 
"
" Setup:    See <url:config:#r=utl_if_hdl_scm_mail__outlook_setup>

fu! Utl_if_hdl_scm_mail__outlook(authority, path, date, from, subject)
    call Utl_trace("- start Utl_if_hdl_scm_mail__outlook(".a:authority.",".a:path.",".a:date.",".a:from.",".a:subject.")",1,1)
    if ! exists('g:utl__file_if_hdl_scm__outlook')
	let g:utl__file_if_hdl_scm__outlook = fnamemodify(g:utl__file, ":h") . '/../utl_if_hdl_scm__outlook.vbs'
	call Utl_trace("- configure interface handler variable for Outlook g:utl__file_if_hdl_scm__outlook=")
	call Utl_trace("  ".g:utl__file_if_hdl_scm__outlook)
    endif
    if ! filereadable(g:utl__file_if_hdl_scm__outlook)
	echohl WarningMsg
	let v:errmsg="No Outlook interface found."
	call input( v:errmsg . " Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=Utl_if_hdl_scm_mail__outlook_setup split
	call Utl_trace("- end Utl_if_hdl_scm_mail__outlook()",1,-1)
	return
    endif
    let cmd='!start wscript "'.g:utl__file_if_hdl_scm__outlook .'" "'. a:authority.'" "'.a:path.'" "'.a:date.'" "'.a:from.'" "'.a:subject.'"'
    call Utl_trace("- executing cmd: `".cmd."'")
    exe cmd
    call Utl_trace("- end Utl_if_hdl_scm_mail__outlook()",1,-1)
endfu

"-------------------------------------------------------------------------------
" Display a file in Acrobat Reader. #page=123 Fragments are supported, i.e.
" display the file at this given page.
" Function designed as  g:utl_cfg_hdl_mt_application_pdf  interface function,
" e.g. intended to be used via  :let g:utl_cfg_hdl_mt_application_pdf="call
" Utl_if_hdl_mt_application_pdf_acrobat('%P', '%f')".
" See also #r=utl_cfg_hdl_mt_application_pdf_acrobat.
"
" Arg:	    path     - file to be displayed in Acrobat (full path)
"	    fragment - fragment (without #) or empty string if no fragment
"
" Ret:	    -
"
" Setup:    See <config:#r=Utl_if_hdl_mt_application_pdf_acrobat_setup>
"

fu! Utl_if_hdl_mt_application_pdf_acrobat(path,fragment)
    call Utl_trace("- start Utl_if_hdl_mt_application_pdf_acrobat(".a:path.",".a:fragment.")",1,1)
    let switches = ''
    if a:fragment != ''
	let ufrag = UtlUri_unescape(a:fragment)
	if ufrag =~ '^page='
	    let fval = substitute(ufrag, '^page=', '', '')
	    let switches = '/a page='.fval
	else 
	    echohl ErrorMsg
	    echo "Unsupported fragment `#".ufrag."' Valid only `#page='"
	    echohl None
	    return
	endif
    endif

    if ! exists('g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path')    " Entering setup
	call Utl_trace("- Vim variable `g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path.' does not exist")
	echohl WarningMsg
	call input('variable  g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path  not defined. Entering Setup now. <RETURN>')
	echohl None
	Utl openLink config:#r=Utl_if_hdl_mt_application_pdf_acrobat_setup split
	call Utl_trace("- end Utl_if_hdl_mt_application_pdf_acrobat() (not successful)",1,-1)
	return
    endif
										" id=ar_switches
    let cmd = ':silent !start '.g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path.' /a page='.ufrag.' "'.a:path.'"'
    call Utl_trace("- executing cmd: `".cmd."'")
    exe cmd

    call Utl_trace("- end Utl_if_hdl_mt_application_pdf_acrobat()",1,-1)
endfu

"-------------------------------------------------------------------------------
" Display a file in MS-Word. #tn=text  Fragments are supported, i.e.
" display the file at position of first occurrence of  text.
" Function designed as  g:utl_cfg_hdl_mt_application_msword  interface function,
" e.g. intended to be used via  :let g:utl_cfg_hdl_mt_application_msword="call
" Utl_if_hdl_mt_application_msword__word('%P', '%f')".
" See also #r=utl_cfg_hdl_mt_application_msword__word.
"
" Arg:	    path     - file to be displayed in Acrobat (full path)
"	    fragment - fragment (without #) or empty string if no fragment
"
" Ret:	    - 
"
" Setup:    See <config:#r=Utl_if_hdl_mt_application_msword__word_setup>
"

fu! Utl_if_hdl_mt_application_msword__word(path,fragment)
    call Utl_trace("- start Utl_if_hdl_mt_application_msword__word(".a:path.",".a:fragment.")",1,1)

    if ! exists('g:utl__file_if_hdl_mt_application_msword__word')
	let g:utl__file_if_hdl_mt_application_msword__word = fnamemodify(g:utl__file, ":h") . '/../utl_if_hdl_mt_application_msword__word.vbs'
	call Utl_trace("- configure interface handler variable for MS-Word g:utl__file_if_hdl_mt_application_msword__word=")
	call Utl_trace("  ".g:utl__file_if_hdl_mt_application_msword__word)
    endif
    if ! filereadable(g:utl__file_if_hdl_mt_application_msword__word)
	echohl WarningMsg
	let v:errmsg="No Word interface found."
	call input( v:errmsg . " Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=Utl_if_hdl_mt_application_msword__word_setup split
	call Utl_trace("- end Utl_if_hdl_mt_application_msword__word() (not successful)",1,-1)
	return
    endif

    if ! exists('g:utl_cfg_hdl_mt_application_msword__word_exe_path')    " Entering setup
	call Utl_trace("- Vim variable `g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path.' does not exist")
	echohl WarningMsg
	call input('variable  g:utl_cfg_hdl_mt_application_msword__word_exe_path  not defined. Entering Setup now. <RETURN>')
	echohl None
	Utl openLink config:#r=Utl_if_hdl_mt_application_msword__word_setup split
	call Utl_trace("- end Utl_if_hdl_mt_application_msword__word() (not successful)",1,-1)
	return
    endif

    let cmd = 'silent !start '.g:utl_cfg_hdl_mt_application_msword__word_exe_path.' "'.a:path.'"'
    call Utl_trace("- cmd to open document: `".cmd."'")
    exe cmd
    if a:fragment == ''
	call Utl_trace("- end Utl_if_hdl_mt_application_msword__word() (successful, no fragment)",1,-1)
	return
    endif
    " (CR044:frag)
    let ufrag = UtlUri_unescape(a:fragment)
    if ufrag =~ '^tn=' " text next / text previous
	let fval = substitute(ufrag, '^tn=', '', '')
    elseif ufrag =~ '[a-z]\+='
	echohl ErrorMsg
	echo 'Unsupported fragment key `'.substitute(ufrag, '\c^\([a-z]\+\).*', '\1=', '')."'. Valid only: `tn='"
	echohl None
	call Utl_trace("- end Utl_if_hdl_mt_application_msword__word() (not successful)",1,-1)
	return
    else
	let fval=ufrag	    " naked fragment same as tn=
    endif
    let cmd='silent !start wscript "'.g:utl__file_if_hdl_mt_application_msword__word .'" "'. a:path.'" "'.fval.'"'
    call Utl_trace("- cmd to address fragment: `".cmd."'")
    exe cmd
    call Utl_trace("- end Utl_if_hdl_mt_application_msword__word()",1,-1)
endfu

let &cpo = s:save_cpo

finish

=== FILE_OUTLOOK_VBS {{{
' file: utl_if_hdl_scm__outlook.vbs
' synopsis: utl_if_hdl_scm__outlook.vbs "" "Inbox" "08.02.2008 13:31" "" ""
' collaboration: - Used by utl.vim when accessing "mail:" URLs using MS-Outlook.
'		 - Outlook must be running
' hist:
' 2008-02-29/Stb: Version for Utl.vim v3.0a
Option Explicit

Dim ol, olns, folder, entryId, item, myNewFolder
Dim a_authority, a_path, a_from, a_subject, a_date

a_authority = WScript.Arguments(0)
a_path = WScript.Arguments(1)
a_date = WScript.Arguments(2)
a_from = WScript.Arguments(3)
a_subject = WScript.Arguments(4)

if a_from <> "" Then
    MsgBox "utl_if_hdl_scm__outlook.vbs: Sorry:  from=  query not supported. Will be ignored"
end if
if a_from <> "" Then
    MsgBox "utl_if_hdl_scm__outlook.vbs: Sorry:  subject=  query not supported. Will be ignored"
end if

Set ol = GetObject(, "Outlook.Application")
Set olns = ol.GetNameSpace("MAPI")

'-----
' Get root folder
if a_authority = "" Then
    ' No a_authority defaults to folder which contains the default folders
    Set folder = olns.GetDefaultFolder(6)
    Set folder = folder.Parent
else
    Set folder = olns.Folders.item( a_authority )
end if

'-----
' Trailing slash possible even with no path defined.
' So remove it independently of path treatment
if a_path <> "" Then
    ' Remove leading "/"
    a_path = Right( a_path, Len(a_path)-1 )
end if

'-----
' If a_path given search a_path recursively to get corresponding
' folder object (currently no hierarchies, only one subfolder)
if a_path <> "" Then
    Set folder = folder.Folders.item( a_path )
end if


Dim sFilter

'-----
' Four minute time range turned out to work fairly well finally...
Dim dateMin, dateMax
dateMin = CStr( DateAdd("n", -2, a_date) )
dateMax = CStr( DateAdd("n", 2, a_date) )
'	cut seconds added by DateAdd
dateMin = Left(dateMin, Len(dateMin) -3 )
dateMax = Left(dateMax, Len(dateMax) -3 )

'id=adapt_column_name
' Unless you have a german Outlook adapt the following line to match you language.
' The Word "Erhalten" probably something like "Received" in english.
' Have a look in you Outlook; its the name of the column which shows and sorts
' by date.
'
'   
' [id=received]	Change to actual column name in your Outlook
'               +---------------------------------+
'	        v                                 v
sFilter = "[Erhalten] > '" + dateMin + "' AND [Erhalten] < '" + dateMax + "'"

Set item = folder.Items.find(sFilter)

item.Display
=== FILE_OUTLOOK_VBS }}}
=== FILE_WORD_VBS {{{
' usage: utl_if_hdl_mt_application_msword__word.vbs <.doc file> <string_to_search>
' description: Position cursor in Word document <.doc file> at string
'	<string_to_search> 
' Collaboration: Word being started or running. Document subject to fragment
'	addressing active or being opened and activated.
' hist:
' 2008-03-20/Stb: Version for Utl.vim v3.0a

' TODO: "Option Explicit" ( Can't get it running with...  %-/ )

const wdGoToPage = 1
const wdGoToAbsolute = 1
const wdFindContinue = 1

docPath = WScript.Arguments(0)
fragment = WScript.Arguments(1)

' Wait for WORD in case it just starts up
countTries = 0
maxTries = 50
Do While countTries < maxTries 
    countTries = countTries+1
    On Error Resume Next
	Set o = GetObject(, "Word.Application")
    If Err Then
	WScript.Sleep 200
	Err.Clear
    Else
        Exit Do
    End If
Loop

' TODO: Exit if still not loaded

' Wait until document loaded
countTries = 0
maxTries = 20
docFound = FALSE
Do While countTries < maxTries 

    countTries = countTries+1

    ' schauen ob ActiveDocument.Name (schon) gleich
    ' dem docPath ist.


    pos = InStr(1, docPath, o.ActiveDocument.Name, 1)

    If pos <> 0 then
        docFound = TRUE
        Exit Do
    End If

    WScript.Sleep 200

Loop

If docFound=FALSE then
    WScript.Echo("Document not found")
End If 

' TODO: Exit If docFound=FALSE
' assertion: document active

' process fragment
' TODO: support also page= fragment:
' 'o.Selection.GoTo wdGotoPage, wdGoToAbsolute, 20

o.Selection.Find.ClearFormatting
With o.Selection.Find
    .Text = fragment
    .Replacement.Text = ""
    .Forward = True
    .Wrap = wdFindContinue
    .Format = False
    .MatchCase = False
    .MatchWholeWord = False
    .MatchWildcards = False
    .MatchSoundsLike = False
    .MatchAllWordForms = False
End With
o.Selection.Find.Execute

=== FILE_WORD_VBS }}}

" END OF DEFINITION OF STANDARD UTL `DRIVERS' ]

" vim: set foldmethod=marker:

" -----id=foot1
" Thanks for trying out Utl.vim :-)
plugin/utl_rc.vim
423
" BEGIN OF UTL PLUGIN CONFIGURATION 				     id=utl_rc [
"   vim: fdm=marker

let utl__file_rc =    expand("<sfile>")	    " Do not remove this line

" Hints							    id=hints
" 
" - Choose a template variable and uncomment it or create a new one.
"   Then issue the command  :so %  to activate it. You can check whether
"   a variable is defined with the command   :let utl_cfg_<name>
"
" - You can change the variables in this file whenever you want, not just when
"   Utl.vim automatically presented you this file.
"
" - You might want to take any variables defined here into your vimrc file.
"   Since vimrc is always loaded before any plugin files you should comment
"   all variables to avoid overwriting of your vimrc settings.
"   (Deletion of utl_rc.vim is also possible. In this case you should
"   preserve the Utl link targets id=xxx plus line :let utl__file_rc
"   above (i.e. also take over into you vimrc file).)


" id=schemeHandlers------------------------------------------------------------[


" id=schemeHandlerHttp---------------------------------------------------------[
"
" Allowed conversion specifiers are: 
" %u - URL	    (without fragment, e.g. 'http://www.vim.org/download.php'
" %f - fragment	    (what comes after the '#', if any)
" %d - display mode (e.g. 'edit', 'tabedit', 'split' etc. Probably only relevant
"		    if downloaded document handled in Vim)


    " [id=utl_cfg_hdl_scm_http]
    "
    " Hints:
    " 1. If  g:utl_cfg_hdl_mt_generic  is defined then you can probably
    "   construct utl_cfg_hdl_scm_http by just replacing %u -> %p (Unix) or %u
    "   -> %P (Windows).
    " 2. Instead of directly defining  g:utl_cfg_hdl_scm_http  it is recommended
    "   to define  g:utl_cfg_hdl_scm_http_system . Doing so enables the dynamic
    "   handler switching:
    " 3. Suggestion for mapping for dynamic switch between handlers [id=map_http]
    "   :map <Leader>uhs :let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http_system<cr>
    "   :map <Leader>uhw :let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http__wget<cr>


    " [id=utl_cfg_hdl_scm_http_system] {
    "	    Definition of your system's standard web handler, e.g. Firefox.
    "	    Either directly (e.g. Firefox), or indirectly ("start" command
    "	    in Windows).
    "	    Note: Needs not necessarily be the system's standard handler.
    "	    Can be anything but should be seen in contrast to
    "	    utl_cfg_hdl_scm_http__wget below
    "
    if !exists("g:utl_cfg_hdl_scm_http_system")

	if has("win32")
	    let g:utl_cfg_hdl_scm_http_system = 'silent !cmd /q /c start "dummy title" "%u"'
	    "let g:utl_cfg_hdl_scm_http_system = 'silent !start C:\Program Files\Internet Explorer\iexplore.exe %u#%f' 
	    "let g:utl_cfg_hdl_scm_http_system = 'silent !start C:\Program Files\Mozilla Firefox\firefox.exe %u#%f'

	elseif has("unix")

	    " TODO: Standard Handler for Unixes that can be shipped
	    "	    preconfigured with next utl.vim release
	    "	    Probably to distinguish different Unix/Linux flavors.
	    "
	    "	    Proposed for Ubuntu/Debian by Jeremy Cantrell
	    "	    to use xdg-open program
	    "	    'silent !xdg-open %u'  <- does this work?
	    "
	    " 2nd best solution: explicitly configured browser:
	    "
	    "	Konqueror
	    "let g:utl_cfg_hdl_scm_http_system = "silent !konqueror '%u#%f' &"
	    "
	    "	Lynx Browser.
	    "let g:utl_cfg_hdl_scm_http_system = "!xterm -e lynx '%u#%f'"
	    "
	    "	Firefox
	    "	Check if an instance is already running, and if yes use it, else start firefox.
	    "	See <URL:http://www.mozilla.org/unix/remote.html> for mozilla/firefox -remote control
	    "let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"

	endif
	" else if MacOS
	" ??
	"let g:utl_cfg_hdl_scm_http_system = "silent !open -a Safari '%u#%f'"
	"
	"}

    endif

    if !exists("g:utl_cfg_hdl_scm_http")
	if exists("g:utl_cfg_hdl_scm_http_system")
	    let g:utl_cfg_hdl_scm_http=g:utl_cfg_hdl_scm_http_system
	endif
    endif


    " [id=utl_cfg_hdl_scm_http__wget]
    let g:utl_cfg_hdl_scm_http__wget="call Utl_if_hdl_scm_http__wget('%u')"

    " Platform independent
    "	Delegate to netrw.vim	    [id=http_netrw]
    "let g:utl_cfg_hdl_scm_http="silent %d %u"
    "

"]

" id=schemeHandlerScp--------------------------------------------------------------[
" Allowed conversion specifiers are: 
" %u - URL	    (without fragment, e.g. 'scp://www.someServer.de/someFile.txt'
" %f - fragment	    (what comes after the '#', if any)
" %d - display mode (e.g. 'edit', 'tabedit', 'split' etc. Probably only relevant
"		    if downloaded document handled in Vim)

    " [id=utl_cfg_hdl_scm_scp]
    " Delegate to netrw.vim.  TODO: Should set utl__hdl_scm_ret_list to buffer name
    " NOTE: On Windows I have set  g:netrw_scp_cmd="pscp -q" (pscp comes with
    "	    the  putty  tool), see also <url:vimscript:NetrwSettings>
    if !exists("g:utl_cfg_hdl_scm_scp")
	    let g:utl_cfg_hdl_scm_scp = "silent %d %u"
    endif

"]

" id=schemeHandlerMailto-----------------------------------------------------------[
" Allowed conversion specifiers are: 
" %u - will be replaced with the mailto URL
"
    if !exists("g:utl_cfg_hdl_scm_mailto")

	" [id=utl_cfg_hdl_scm_mailto] {
	if has("win32")
	    let g:utl_cfg_hdl_scm_mailto = 'silent !cmd /q /c start "dummy title" "%u"'
	endif
	" Samples:
	" Windows
	"	 Outlook
	"let g:utl_cfg_hdl_scm_mailto = 'silent !start C:\Programme\Microsoft Office\Office11\OUTLOOK.EXE /c ipm.note /m %u'
	"let g:utl_cfg_hdl_scm_mailto = 'silent !start C:\Program Files\Microsoft Office\Office10\OUTLOOK.exe /c ipm.note /m %u' 
	"
	" Unix
	"let g:utl_cfg_hdl_scm_mailto = "!xterm -e mutt '%u'" 
	"let g:utl_cfg_hdl_scm_mailto = "silent !kmail '%u' &"
	"}

    endif


" id=schemeHandlerMail---------------------------------------------------------[
" Allowed conversion specifiers are: 
" %a - main folder	    Example:
" %p - folder path	    Given the URL
" %d - date		      <url:mail://myfolder/Inbox?date=12.04.2008 15:04&from=foo&subject=bar>
" %f - from		    the specifiers will be converted as 
" %s - subject		      %a=myfolder, %p=Inbox, %d=12.04.2008 15:04, %f=foo, %s=bar

    " Windows
    "	Outlook						[id=utl_cfg_hdl_scm_mail__outlook]
    if has("win32")
	let g:utl_cfg_hdl_scm_mail__outlook = "call Utl_if_hdl_scm_mail__outlook('%a','%p','%d','%f','%s')"
    endif

    " [id=utl_cfg_hdl_scm_mail] {
    if !exists("g:utl_cfg_hdl_scm_mail")
	"let g:utl_cfg_hdl_scm_mail=g:utl_cfg_hdl_scm_mail__outlook
    endif
    "}

"]

" id=mediaTypeHandlers---------------------------------------------------------[
" Setup of handlers for media types which you don't want to be displayed by Vim.
"
" Allowed conversion specifiers:
"
" %p - Replaced by full path to file or directory
"
" %P - Replaced by full path to file or directory, where the path components
"      are separated with backslashes (most Windows programs need this).
"      Note that full path might also contain a drive letter.
"
" %f - Replaced by fragment if given in URL, else replaced by empty string.
"
" Details :
" - The variable name is g:utl_cfg_hdl_mt_<media type>, where the characters / . + -
"   which can appear in media types are mapped to _ to make a valid variable
"   name, e.g. Vim variable for media type 'video/x-msvideo' is
"   'g:utl_cfg_hdl_mt_video_x_msvideo'
" - The "" around the %P is needed to support file names containing blanks
" - Remove the :silent when you are testing with a new string to see what's
"   going on (see <URL:vimhelp::silent> for infos on the :silent command).
"   Perhaps you like :silent also for production (I don't).
" - NOTE: You can supply any command here, i.e. does not need to be a shell
"   command that calls an external program (some cmdline special treatment
"   though, see <URL:utl.vim#r=esccmd>)
" - You can introduce new media types to not handle a certain media type
"   by Vim (e.g. display it as text in Vim window). Just make sure that the
"   new media type is also supported at this place:
"   <URL:utl.vim#r=utl_checkmtype>
" - Use the pseudo handler 'VIM' if you like the media type be displayed by
"   by Vim. This yields the same result as if the media type is not defined,
"   see last item.


    " [id=utl_cfg_hdl_mt_generic] {
    "	    You can either define the generic variable or a variable
    "	    for the specific media type, see #r=mediaTypeHandlersSpecific
    if !exists("g:utl_cfg_hdl_mt_generic")
	if has("win32")
	    let g:utl_cfg_hdl_mt_generic = 'silent !cmd /q /c start "dummy title" "%P"'
	elseif has("unix")
	    if $WINDOWMANAGER =~? 'kde'
		let g:utl_cfg_hdl_mt_generic = 'silent !konqueror "%p" &'
	    endif
	    " ? Candidate for Debian/Ubuntu: 'silent !xdg-open %u'
	endif
    endif
    "}
    

    " [id=mediaTypeHandlersSpecific] {

    "if !exists("g:utl_cfg_hdl_mt_application_excel")
    "	     let g:utl_cfg_hdl_mt_application_excel = ':silent !start C:\Program Files\Microsoft Office\Office10\EXCEL.EXE "%P"'
    "endif

    "if !exists("g:utl_cfg_hdl_mt_application_msmsg")
    "	     let g:utl_cfg_hdl_mt_application_msmsg = ':silent !start C:\Program Files\Microsoft Office\Office10\OUTLOOK.EXE -f "%P"'
    "endif

    "if !exists("g:utl_cfg_hdl_mt_application_powerpoint")
    "        let g:utl_cfg_hdl_mt_application_powerpoint = ':silent !start C:\Program Files\Microsoft Office\Office10\POWERPNT.EXE "%P"'
    "endif

    "if !exists("g:utl_cfg_hdl_mt_application_rtf")
    "	     let g:utl_cfg_hdl_mt_application_rtf = ':silent !start C:\Program Files\Windows NT\Accessories\wordpad.exe "%P"'
    "endif
    
    "if !exists("g:utl_cfg_hdl_mt_text_html")
    "	     let g:utl_cfg_hdl_mt_text_html = 'VIM'
    "		Windows
    "	     let g:utl_cfg_hdl_mt_text_html = 'silent !start C:\Program Files\Internet Explorer\iexplore.exe %P' 
    "		KDE
    "	     let g:utl_cfg_hdl_mt_text_html = ':silent !konqueror %p#%f &'
    "endif


    "if !exists("g:utl_cfg_hdl_mt_application_zip")
    "	     let g:utl_cfg_hdl_mt_application_zip = ':!start C:\winnt\explorer.exe "%P"'
    "endif

    "if !exists("g:utl_cfg_hdl_mt_video_x_msvideo")
    "	     let g:utl_cfg_hdl_mt_video_x_msvideo = ':silent !start C:\Program Files\VideoLAN\VLC\vlc.exe "%P"'
    "endif


    "--- Some alternatives for displaying directories	[id=utl_cfg_hdl_mt_text_directory] {
    if has("win32")
	let g:utl_cfg_hdl_mt_text_directory__cmd = ':!start cmd /K cd /D "%P"'   " Dos box
    endif
    let g:utl_cfg_hdl_mt_text_directory__vim = 'VIM'   " Vim builtin file explorer

    if !exists("g:utl_cfg_hdl_mt_text_directory")
	    let g:utl_cfg_hdl_mt_text_directory=utl_cfg_hdl_mt_text_directory__vim
	    "
	    "	KDE
	    "let g:utl_cfg_hdl_mt_text_directory = ':silent !konqueror %p &'
    endif
    " Suggestion for mappings for dynamic switch between handlers [id=map_directory]
    ":map <Leader>udg :let g:utl_cfg_hdl_mt_text_directory=g:utl_cfg_hdl_mt_generic<cr>
    ":map <Leader>udv :let g:utl_cfg_hdl_mt_text_directory=g:utl_cfg_hdl_mt_text_directory__vim<cr>
    ":map <Leader>udc :let g:utl_cfg_hdl_mt_text_directory=g:utl_cfg_hdl_mt_text_directory__cmd<cr>
    "
    "}


    "						[id=utl_cfg_hdl_mt_application_pdf__acrobat] {
    "let g:utl_cfg_hdl_mt_application_pdf__acrobat="call Utl_if_hdl_mt_application_pdf_acrobat('%P', '%f')"
    "if !exists("g:utl_cfg_hdl_mt_application_pdf")
    "	     let g:utl_cfg_hdl_mt_application_pdf = g:utl_cfg_hdl_mt_application_pdf__acrobat
    "
    "		Linux/KDE
    "	     let g:utl_cfg_hdl_mt_application_pdf = ':silent !acroread %p &'
    "endif
    "}


    "						[id=utl_cfg_hdl_mt_application_msword__word] {
    "let g:utl_cfg_hdl_mt_application_msword__word = "call Utl_if_hdl_mt_application_msword__word('%P','%f')"
    "if !exists("g:utl_cfg_hdl_mt_application_msword")
    "        let g:utl_cfg_hdl_mt_application_msword = g:utl_cfg_hdl_mt_application_msword__word
    "		Linux/Unix
    "	     let g:utl_cfg_hdl_mt_application_msword = ... Open Office
    "endif
    "}


    "if !exists("g:utl_cfg_hdl_mt_application_postscript")
    "		Seem to need indirect call via xterm, otherwise no way to
    "		stop at each page
    "	     let g:utl_cfg_hdl_mt_application_postscript = ':!xterm -e gs %p &'
    "endif

    "if !exists("g:utl_cfg_hdl_mt_audio_mpeg")
    "	     let g:utl_cfg_hdl_mt_audio_mpeg =	    ':silent !xmms %p &'
    "endif

    "if !exists("g:utl_cfg_hdl_mt_image_jpeg")
    "	     let g:utl_cfg_hdl_mt_image_jpeg = ':!xnview %p &'
    "endif

    "}

"]

" Utl interface variables				      " id=utl_drivers [

" id=utl_if_hdl_scm_http_wget_setup--------------------------------------------[
"
" To make Wget work you need a wget executable in the PATH.
" Windows : Wget not standard. Download for example from
" <url:http://users.ugent.be/~bpuype/wget/#download>
" and put it into to c:\windows\system32
" Unix : Should work under Unix out of the box since wget standard!?
"
" ]


" id=utl_if_hdl_scm_mail__outlook_setup----------------------------------------[
"
" To make Outlook work you for the mail:// schemes you need the VBS OLE
" Automation file:
"
" 1. Adapt the VBS source code to your locale by editing the file utl.vim at
"    the position: <url:./utl.vim#r=received> and then  :write  the file (utl.vim).
"
" 2. Execute the following link to (re-)create the VBS file by cutting it
"    out from utl.vim:
"
"    <url:vimscript:call Utl_utilCopyExtract(g:utl__file, g:utl__file_if_hdl_scm__outlook, '=== FILE_OUTLOOK_VBS' )>
"
" ]


" id=Utl_if_hdl_mt_application_pdf_acrobat_setup-------------------------------[
"
" To make acrobat work with fragments you need to provide the variable
" g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path. 
"
" Modify and uncomment one of the samples below, then do  :so %
" Windows:
" Normally you should get the path by executing in a dos box:
" cmd> ftype acroexch.document
" Here are two samples:
"     let g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path = "C:\Program Files\Adobe\Reader 8.0\Reader\AcroRd32.exe"
"     let g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path = 'C:\Programme\Adobe\Reader 8.0\Reader\AcroRd32.exe'
" Full path not needed if Acrobat Reader in path
" Unix: 
" Probably Acrobat Reader is in the path, with program's name `acroread'.
" But most certainly the command line options used below will not fit,
" see <url:#r=ar_switches>, and have to be fixed. Please send me proper
" setup for Linux, Solaris etc. I'm also interested in xpdf instead 
" of Acrobat Reader (function Utl_if_hdl_mt_application_pdf_xpdf).
"   ?? let g:utl_cfg_hdl_mt_application_pdf_acrobat_exe_path = "acroread - ?? "
"
" ]


" id=Utl_if_hdl_mt_application_msword__word_setup------------------------------[
"
" To make MSWord support fragments you need:
"
" 1. Create the VBS OLE Automation file by executing this link:
"    <url:vimscript:call Utl_utilCopyExtract(g:utl__file, g:utl__file_if_hdl_mt_application_msword__word, '=== FILE_WORD_VBS' )>
"    (This will (re-)create that file by cutting it out from the bottom of this file.)
"
" 2. Provide the variable g:utl_cfg_hdl_mt_application_msword__word_exe_path. 
"    Modify and uncomment one of the samples below, then do  :so %
"    Windows:
"    Normally you should get the path by executing in a dos box:
"    cmd> ftype Word.Document.8
"    Here are two samples:
"    let g:utl_cfg_hdl_mt_application_msword__word_exe_path = 'C:\Program Files\Microsoft Office\OFFICE11\WINWORD.EXE'
"    let g:utl_cfg_hdl_mt_application_msword__word_exe_path = 'C:\Programme\Microsoft Office\OFFICE11\WINWORD.EXE'

" ]
" ]


" Utl Options		id=_utl_options [

"id=utl_opt_verbose------------------------------------------------------------[
"   Option utl_opt_verbose switches on tracing. This is useful to figure out
"   what's going on, to learn about Utl or to see why things don't work as
"   expected.
"   
"let utl_opt_verbose=0	    " Tracing off (default)
"let utl_opt_verbose=1	    " Tracing on 

" ]

"id=utl_opt_highlight_urls-----------------------------------------------------[
"   Option utl_opt_highlight_urls controls if URLs are highlighted or not.
"   Note that only embedded URLs like <url:http://www.vim.org> are highlighted.
"   
"   Note: Change of the value will only take effect a) after you restart your
"   Vim session or b) by :call Utl_setHighl() and subsequent reedit (:e) of the
"   current file. Perform the latter by simply executing this URL:
"   <url:vimscript:call Utl_setHighl()|:e>

"let utl_opt_highlight_urls='yes'   " Highlighting on (default)
"let utl_opt_highlight_urls='no'    " Highlighting off

"]
"]

" END OF UTL PLUGIN CONFIGURATION FILE ]

plugin/utl_scm.vim
716
" ------------------------------------------------------------------------------
" File:		plugin/utl_scm.vim -- callbacks implementing the different
"	        schemes
"			        Part of the Utl plugin, see ./utl.vim
" Author:	Stefan Bittner <stb@bf-consulting.de>
" Licence:	This program is free software; you can redistribute it and/or
"		modify it under the terms of the GNU General Public License.
"		See http://www.gnu.org/copyleft/gpl.txt
" Version:	utl 3.0a
" ------------------------------------------------------------------------------


" In this file some scheme specific retrieval functions are defined.
" For each scheme one function named Utl_AddrScheme_xxx() is needed.
"
" - If a scheme (i.e. functions) is missing, the caller Utl_processUrl()
"   will notice it and show an appropriate message to the user.
"
" - You can define your own functions:


" How to write a Utl_AddrScheme_xxx function		(id=implscmfunc)
" ------------------------------------------
" To implement a specific scheme (e.g. `file', `http') you have to write
" write a handler function named `Utl_AddrScheme_<scheme>' which obeys the
" following rules:
"
" - It takes three arguments:
"
"   1. Arg: Absolute URI
"   (See <URL:vimhelp:utl-uri-relabs> to get an absolute URI explained). The
"   given `auri' will not have a fragment (without #... at the end).
"
"   2. Arg: Fragment
"   Where the value will be '<undef>' if there is no fragment. In most cases a
"   handler will not actually deal with the fragment but leaves that job for
"   standard fragment processing in Utl by returning a non empty list (see
"   next). Examples for fragment processing handlers are
"   Utl_AddressScheme_http and Utl_AddressScheme_foot.
"
"   3. Arg: display Mode (dispMode)
"   Most handlers will ignore this argument. Exception for instance handlers
"   which actually display the retrieved or determined file like 
"   Utl_AddressScheme_foot. If your function is smart it might, if applicable,
"   support the special dispMode values copyFileName (see examples in this file).
"
"
" - It then does what ever it wants.
"   But what it normally wants is: retrieve, load, query, address the resource
"   identified by `auri'.

" - It Returns a list with 0 (empty list), 1 or 2 elements.    [id=scm_ret_list]
"   (See vimhelp:List if you don't know what a list is in Vim)
"
"   * Empty list means: no subsequent processing by Utl.vim
"     Examples where this makes sense:
"     ° If the retrieve was not successful, or
"     ° if handler already cared for displaying the file (e.g. URL
"       delegated to external handler)
"
"   * 1st list element = file name (called localPath) provided means:
"     a) Utl.vim will delegate localPath to the appropriate file type handler
"        or display it the file in Vim-Window.
"        It also possible, that the localPath is already displayed in this case
"        (Utl.vim will check if the localPath corresponds to a buffer name.)
"        Note : It is even possible that localPath does not correspond to
"        an existing file or to a file at all. Executing a http URL with
"        netrw is an example for this, see: ../plugin/utl_rc.vim#http_netrw.
"        Netrw uses the URL as buffer name.
"     c) Fragment will be processed (if any).
"
"     Details :
"     ° File name should be a pathname to (an existing) local file or directory.
"       Note : the 
"     ° File name's path separator should be slash (not backslash).
"     ° It does not hurt if file is already displayed (an example for this is
"       vimhelp scheme).
"
"   * 2nd list element = fragment Mode (fragMode). Allowed values:
"     `abs', 'rel'. Defaults to `abs' if no 2nd list element.
"     `abs': Fragment will be addressed to beginning of file. 
"     `rel': Fragment will be addressed relative to current cursor position
"            (example: Vimhelp scheme).

" 
" Specification of 'scheme handler variable interface'	(id=spec_ihsv)
" ----------------------------------------------------
" 
" - Variable naming: utl_cfg_hdl_scm_<scheme>
" 
" - Variables executed by :exe  (see <vimhelp::exe>).
"   This implies that the variable has to a valid ex command. (to execute more
"   than one line of ex commands a function can be called).
" 
" - Should handle the actual link, e.g. download the file.
"   But it can do whatever it wants :-)
" 
" - Input data: scheme specific conversion specifiers should appear in the
"   variable. They will be replaced by Utl.vim when executing an URL, e.g %u
"   will be replaced by the actual URL. The available conversion specifiers are
"   defined at <url:../plugin/utl_rc.vim#r=utl_cfg_hdl_scm_http> for http etc.
" 
" - Output data: an optional global list, which is the same as that of the
"   handler itself, see <url:../plugin/utl_scm.vim#r=scm_ret_list>. Since the
"   variable's value can be any ex command (and, for instance, not always a
"   function) a global variable is used:
"       g:utl_hdl_scm_ret_list
"   This variable will be initialized to an empty list [] by Utl.vim before
"   executing the contents of the variable. 
" 
" - Exception handling: Normally nothing needs to be done in the variable code.
"   Utl.vim checks for v:shell_error and v:errmsg after execution. There are
"   situation where setting v:errmsg makes sense. The variable might want to
"   issue the error message (Utl.vim does not).
" 


if exists("loaded_utl_scm") || &cp || v:version < 700
    finish
endif
let loaded_utl_scm = 1
let s:save_cpo = &cpo
set cpo&vim
let g:utl__file_scm = expand("<sfile>")

let s:utl_esccmdspecial = '%#'  " keep equal to utl.vim#__esc

"-------------------------------------------------------------------------------
" Addresses/retrieves a local file.
"
" - If `auri' gives a query, then the file is executed (it should be an
"   executable program) with the query expression passed as arguments
"   arguments. The program's output is written to a (tempname constructed)
"   result file.  
"   
" - else, the local file itself is the result file and is returned.
" 
fu! Utl_AddressScheme_file(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_file",1,1) 

    " authority: can be a
    " - windows drive, e.g. `c:'
    " - server name - interpret URL as a network share
    let authority = UtlUri_authority(a:auri)
    let path = ''
    if authority =~? '^[a-z]:$'
        if has("win32") || has("win16") || has("win64") || has("dos32") || has("dos16")
	    call Utl_trace("- Am under Windows. Server part denotes a Windows drive: `".authority."'")
	    let path = authority
	endif
    elseif authority != '<undef>' && authority != ''
        if has("win32") || has("win16") || has("win64") || has("dos32") || has("dos16")
	    call Utl_trace("- Am under Windows. Server part specified: `".authority."',")
	    call Utl_trace("  will convert to UNC path //server/sharefolder/path.")
	    let path = '//' . authority
	elseif has("unix")
	    call Utl_trace("- Am under Unix. Server part specified: `".authority."',")
	    call Utl_trace("  will convert to  server:/path")
	    " don't know if this really makes sense. See <http://en.wikipedia.org/wiki/Path_%28computing%29>
	    let path = authority . ':'
	endif
    endif

    let path = path . UtlUri_unescape(UtlUri_path(a:auri))
    call Utl_trace("- local path constructed from URL: `".path."'")

    " Support of tilde ~ notation.
    if stridx(path, "~") != -1
	let tildeuser = expand( substitute(path, '\(.*\)\(\~[^/]*\)\(.*\)', '\2', "") )
	let path = tildeuser .  substitute(path, '\(.*\)\(\~[^/]*\)\(.*\)', '\3', "")
	call Utl_trace("- found a ~ (tilde) character in path, expand to $HOME in local path:")
	let path = Utl_utilBack2FwdSlashes( path )
	call Utl_trace("  ".path."'")
    endif

    if a:dispMode =~ '^copyFileName'
	call Utl_trace("- mode is `copyFileName to clipboard': so quit after filename is known now") 
	call Utl_trace("- end execution of Utl_AddressScheme_file",1,-1) 
	return [path]
    endif

    " If Query defined, then execute the Path	    (id=filequery)
    let query = UtlUri_query(a:auri)
    if query != '<undef>'   " (N.B. empty query is not undef)
	call Utl_trace("- URL contains query expression (".query.") - so try to execute path") 

	" (Should make functions Query_form(), Query_keywords())
	if match(query, '&') != -1	    " id=query_form
	    " (application/x-www-form-urlencoded query to be implemented
	    "  e.g.  `?foo=bar&otto=karl')
	    let v:errmsg = 'form encoded query to be implemented'
	    echohl ErrorMsg | echo v:errmsg | echohl None
	elseif match(query, '+') != -1		" id=query_keywords
	    let query = substitute(query, '+', ' ', 'g')
	endif
	let query = UtlUri_unescape(query)
	" (Whitespace in keywords should now be escaped before handing off to shell)
	let cacheFile = ''
	" If redirection char '>' at the end:
	" Supply a temp file for redirection and execute the program
	" synchronously to wait for its output
	if strlen(query)!=0 && stridx(query, '>') == strlen(query)-1 
	    call Utl_trace("- query with > character at end: assume output to a temp file and use it as local path")
	    let cacheFile = Utl_utilBack2FwdSlashes( tempname() )
	    let cmd = "!".path." ".query." ".cacheFile
	    call Utl_trace("- trying to execute command `".cmd."'")
	    exe cmd
	" else start it detached
	else
	    if has("win32") || has("win16") || has("win64") || has("dos32") || has("dos16")
		let cmd = "!start ".path." ".query
	    else
		let cmd = "!".path." ".query.'&'
	    endif
	    call Utl_trace("- trying to execute command `".cmd."'")
	    exe cmd
	endif
	
	if v:shell_error
	    let v:errmsg = 'Shell Error from execute searchable Resource'
	    echohl ErrorMsg | echo v:errmsg | echohl None
	    if cacheFile != ''
		call delete(cacheFile)
	    endif
	    call Utl_trace("- end execution of Utl_AddressScheme_file",1,-1) 
	    return []
	endif
	call Utl_trace("- end execution of Utl_AddressScheme_file",1,-1) 
	if cacheFile == ''
	    return []
	else 
	    return [cacheFile]
	endif

    endif

    call Utl_trace("- end execution of Utl_AddressScheme_file",1,-1) 
    return [path]
endfu


"-------------------------------------------------------------------------------
"
fu! Utl_AddressScheme_ftp(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_ftp",1,1) 
    call Utl_trace("- delegating to http scheme handler")
    let ret = Utl_AddressScheme_http(a:auri, a:fragment, a:dispMode)
    call Utl_trace("- end execution of Utl_AddressScheme_ftp",1,-1) 
    return ret
endfu


"-------------------------------------------------------------------------------
"
fu! Utl_AddressScheme_https(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_https",1,1) 
    call Utl_trace("- delegating to http scheme handler")
    let ret = Utl_AddressScheme_http(a:auri, a:fragment, a:dispMode)
    call Utl_trace("- end execution of Utl_AddressScheme_https",1,-1) 
    return ret
endfu

"-------------------------------------------------------------------------------
"
fu! Utl_AddressScheme_http(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_http",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName to clipboard' not possible for scheme `http:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_http",1,-1) 
	return []
    endif

    if ! exists('g:utl_cfg_hdl_scm_http')    " Entering setup
	call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_http does not exist")
	echohl WarningMsg
	call input("No scheme handler variable g:utl_cfg_hdl_scm_http defined yet. Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=utl_cfg_hdl_scm_http split " (recursion, setup)
	call Utl_trace("- end execution of Utl_AddressScheme_http",1,-1) 
	return []
    endif
    call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_http exists, value=`".g:utl_cfg_hdl_scm_http."'")

    let convSpecDict= { 'u': a:auri, 'f': a:fragment, 'd': a:dispMode }
    let [errmsg,cmd] = Utl_utilExpandConvSpec(g:utl_cfg_hdl_scm_http, convSpecDict)
    if errmsg != ""
	echohl ErrorMsg
	echo "The content of your Vim variable `".g:utl_cfg_hdl_scm_http."' is invalid and has to be fixed!"
	echo "Reason: `".errmsg."'"
	echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_http",1,-1) 
	return []
    endif

    call Utl_trace("- Escape cmdline-special characters (".s:utl_esccmdspecial.") before execution")
    " see <URL:vimhelp:cmdline-special>).
    let cmd = escape( cmd, s:utl_esccmdspecial)

    let g:utl__hdl_scm_ret_list=[]
    let v:errmsg = ""
    call Utl_trace("- trying to execute command: `".cmd."'")
    exe cmd

    if v:shell_error || v:errmsg!=""
	call Utl_trace("- execution of scm handler returned with v:shell_error or v:errmsg set")
	call Utl_trace("  v:shell_error=`".v:shell_error."'")
	call Utl_trace("  v:errmsg=`".v:errmsg."'")
	call Utl_trace("- end execution of Utl_AddressScheme_http (not successful)",1,-1) 
	return []
    endif

    call Utl_trace("- end execution of Utl_AddressScheme_http (successful)",1,-1) 
    return g:utl__hdl_scm_ret_list
endfu

"-------------------------------------------------------------------------------
" Retrieve file via scp.
"
fu! Utl_AddressScheme_scp(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_scp",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `scp:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_scp",1,-1) 
	return []
    endif

    if ! exists('g:utl_cfg_hdl_scm_scp')    " Entering setup
	call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_scp does not exist")
	echohl WarningMsg
	call input("No scheme handler variable g:utl_cfg_hdl_scm_scp defined yet. Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=utl_cfg_hdl_scm_scp split " (recursion, setup)
	call Utl_trace("- end execution of Utl_AddressScheme_scp",1,-1) 
	return []
    endif
    call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_scp exists, value=`".g:utl_cfg_hdl_scm_scp."'")

    let convSpecDict= { 'u': a:auri, 'f': a:fragment, 'd': a:dispMode }
    let [errmsg,cmd] = Utl_utilExpandConvSpec(g:utl_cfg_hdl_scm_scp, convSpecDict)
    if errmsg != ""
	echohl ErrorMsg
	echo "The content of your Vim variable `".g:utl_cfg_hdl_scm_scp."' is invalid and has to be fixed!"
	echo "Reason: `".errmsg."'"
	echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_scp",1,-1) 
	return []
    endif

    call Utl_trace("- Escape cmdline-special characters (".s:utl_esccmdspecial.") before execution")
    " see <URL:vimhelp:cmdline-special>).
    let cmd = escape( cmd, s:utl_esccmdspecial)

    let g:utl__hdl_scm_ret_list=[]
    let v:errmsg = ""
    call Utl_trace("- trying to execute command: `".cmd."'")
    exe cmd

    if v:shell_error || v:errmsg!=""
	call Utl_trace("- execution of scm handler returned with v:shell_error or v:errmsg set")
	call Utl_trace("- end execution of Utl_AddressScheme_scp (not successful)",1,-1) 
	return []
    endif

    call Utl_trace("- end execution of Utl_AddressScheme_scp",1,-1) 
    return g:utl__hdl_scm_ret_list

endfu


"-------------------------------------------------------------------------------
" The mailto scheme.
" It was mainly implemented to serve as a demo. To show that a resource
" needs not to be a file or document.
"
" Returns empty list. But you could create one perhaps containing
" the return receipt, e.g. 'mail sent succesfully'.
"
fu! Utl_AddressScheme_mailto(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_mailto",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `http:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_http",1,-1) 
	return []
    endif

    if ! exists('g:utl_cfg_hdl_scm_mailto')    " Entering setup
	call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_mailto does not exist")
	echohl WarningMsg
	call input("No scheme handler variable g:utl_cfg_hdl_scm_mailto defined yet. Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=utl_cfg_hdl_scm_mailto split " (recursion, setup)
	call Utl_trace("- end execution of Utl_AddressScheme_mailto",1,-1) 
	return []
    endif
    call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_mailto exists, value=`".g:utl_cfg_hdl_scm_mailto."'")

    let convSpecDict= { 'u': UtlUri_build_2(a:auri,a:fragment) }
    let [errmsg,cmd] = Utl_utilExpandConvSpec(g:utl_cfg_hdl_scm_mailto, convSpecDict)
    if errmsg != ""
	echohl ErrorMsg
	echo "The content of your Vim variable `".g:utl_cfg_hdl_scm_mailto."' is invalid and has to be fixed!"
	echo "Reason: `".errmsg."'"
	echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_mailto",1,-1) 
	return []
    endif


    call Utl_trace("- Escape cmdline-special characters (".s:utl_esccmdspecial.") before execution")
    let cmd = escape( cmd, s:utl_esccmdspecial)

    let g:utl__hdl_scm_ret_list=[]
    let v:errmsg = ""
    call Utl_trace("- trying to execute command: `".cmd."'")
    exe cmd

    if v:shell_error || v:errmsg!=""
	call Utl_trace("- execution of scm handler returned with v:shell_error or v:errmsg set")
	call Utl_trace("- end execution of Utl_AddressScheme_mailto (not successful)",1,-1) 
	return []
    endif

    call Utl_trace("- end execution of Utl_AddressScheme_mailto",1,-1) 
    return g:utl__hdl_scm_ret_list
endfu

"-------------------------------------------------------------------------------
" Scheme for accessing Unix Man Pages.
" Useful for commenting program sources.
"
" Example: /* "See <URL:man:fopen#r+> for the r+ argument" */
"
" Possible enhancement: Support sections, i.e. <URL:man:fopen(3)#r+>
"
fu! Utl_AddressScheme_man(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_man",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `man:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_man",1,-1) 
	return []
    endif

    exe "Man " . UtlUri_unescape( UtlUri_opaque(a:auri) )
    if v:errmsg =~ '^Sorry, no man entry for'
	return []
    endif
    call Utl_trace("- end execution of Utl_AddressScheme_man",1,-1) 
    return [Utl_utilBack2FwdSlashes( expand("%:p") ), 'rel']
endfu

"-------------------------------------------------------------------------------
" Scheme for footnotes. Normally by heuristic URL like [1], which is
" transformed into foot:1 before calling this handler. Given
" foot:1  as reference, a referent is searched beginning from
" the end of the current file.  The referent can look like:
"   [1]	    or
"   [1]:
" where only whitespace can appear in front in the same line. If the reference
" has a fragment, e.g. [1]#string or even an empty fragment, e.g. [1]# 
" the value of the footnote is tried to derefence, i.e. automatic forwarding.
"
fu! Utl_AddressScheme_foot(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_foot",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `foot:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_foot",1,-1) 
	return []
    endif

    let opaque = UtlUri_unescape( UtlUri_opaque(a:auri) )

    let reftPat = '\c\m^\s*\(\['.opaque.'\]:\?\)'
    call Utl_trace("- searching for referent pattern `".reftPat."' bottom up until current line...",0)

    let refcLine = line('.') | let refcCol = col('.')
    call cursor( line('$'), col('$') )

    let reftLine = search(reftPat, 'Wb', refcLine+1)
    if reftLine==0
	call Utl_trace("not found")
    endif

    if reftLine==0
	call Utl_trace("- now searching for referent pattern `".reftPat."' top down until current line...",0)
	call cursor(1, 1)
	" (avoid stopline==0, this is special somehow. With -1 instead,
	"  stopping works in the case of reference in line 1)
	let reftLine = search(reftPat, 'Wc', refcLine==1 ? -1 : refcLine-1 )
	if reftLine==0
	    call Utl_trace("not found. Giving up")
	    call cursor(refcLine, refcCol)
	endif
    endif

    if reftLine==0
	let v:errmsg = "Reference has not target in current buffer. Provide another line starting with `[".opaque."]' or `".opaque.".' !"
	echohl ErrorMsg | echo v:errmsg | echohl None
	return []
    endif
    call Utl_trace("found, in line `".reftLine."'")

    " Feature automatic forwarding
    if a:fragment != '<undef>'
	call Utl_trace("- fragment is defined, so try dereferencing foonote's content")
	call Utl_trace("  by trying to position one character past referent")
	" This should exactly fail in case there is no one additional non white character
	let l=search(reftPat.'.', 'ce', reftLine)
	if l == 0 
	    let v:errmsg = "Cannot dereference footnote: Empty footnote"
	    echohl ErrorMsg | echo v:errmsg | echohl None
	    return []
	elseif l != reftLine
	    let v:errmsg = "Cannot dereference footnote: Internal Error: line number mismatch"
	    echohl ErrorMsg | echo v:errmsg | echohl None
	    return []
	endif
	call Utl_trace("- fine, footnote not empty and cursor positioned to start of its")
	call Utl_trace("  content (column ".col('.').") and try to get URL from under the cursor")

	let uriRef = Utl_getUrlUnderCursor()
	if uriRef == ''
	    let v:errmsg = "Cannot not dereference footnote: No URL under cursor"
	    echohl ErrorMsg | echo v:errmsg | echohl None
	    return []
	endif
	call Utl_trace("- combine URL / URL-reference under cursor with fragment of [] reference")
	let uri = UriRef_getUri(uriRef)
	let fragmentOfReferent = UriRef_getFragment(uriRef)
	if fragmentOfReferent != '<undef>' 
	    call Utl_trace("- discard non empty fragment `".fragmentOfReferent."' of referent")
	endif
	call Utl('openLink', UtlUri_build_2(uri, a:fragment), a:dispMode)
	endif

	call Utl_trace("- end execution of Utl_AddressScheme_foot",1,-1) 
	return []
    endif

    call Utl_trace("- end execution of Utl_AddressScheme_foot",1,-1) 
    return [Utl_utilBack2FwdSlashes( expand("%:p") )]
endfu

"-------------------------------------------------------------------------------
" A scheme for quickly going to the setup file utl_rc.vim, e.g.
"	:Gu config:
"
fu! Utl_AddressScheme_config(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_config",1,1) 
    let path = g:utl__file_rc 
    call Utl_trace("- set local path to equal utl variable g:utl__file_scm: `".path."'")
    call Utl_trace("- end execution of Utl_AddressScheme_config",1,-1) 
    return [ Utl_utilBack2FwdSlashes(path) ]
endfu

"id=vimscript-------------------------------------------------------------------
" A non standard scheme for executing vim commands
"	<URL:vimscript:set ts=4>
"
fu! Utl_AddressScheme_vimscript(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_vimscript",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `vimscript:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_vimscript",1,-1) 
	return []
    endif

    let exCmd = UtlUri_unescape( UtlUri_opaque(a:auri) )
    call Utl_trace("- executing Vim Ex-command: `:".exCmd."'\n")	    " CR054_extra_nl
    "echo "                                DBG utl_opt_verbose=`".g:utl_opt_verbose."'"
    exe exCmd
    "echo "                                DBG (after) utl_opt_verbose=`".g:utl_opt_verbose."'"
    call Utl_trace("- end execution of Utl_AddressScheme_vimscript (successful)",1,-1) 
    return  []
endfu

fu! Utl_AddressScheme_vimtip(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_vimtip",1,1) 
    let url = "http://vim.sf.net/tips/tip.php?tip_id=". UtlUri_unescape( UtlUri_opaque(a:auri) )
    call Utl_trace("- delegating to http scheme handler with URL `".url."'")
    let ret = Utl_AddressScheme_http(url, a:fragment, a:dispMode)
    call Utl_trace("- end execution of Utl_AddressScheme_vimtip",1,-1) 
    return ret
endfu

"-------------------------------------------------------------------------------
" A non standard scheme for getting Vim help
"
fu! Utl_AddressScheme_vimhelp(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_vimhelp",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `vimhelp:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_vimhelp",1,-1) 
	return []
    endif

    let exCmd = "help ".UtlUri_unescape( UtlUri_opaque(a:auri) )
    call Utl_trace("- executing Vim Ex-command: `:".exCmd."'\n")	    " CR054_extra_nl
    exe exCmd
    if v:errmsg =~ '^Sorry, no help for'
	call Utl_trace("- end execution of Utl_AddressScheme_vimhelp",1,-1) 
	return []
    endif
    call Utl_trace("- end execution of Utl_AddressScheme_vimhelp (successful)",1,-1) 
    return [ Utl_utilBack2FwdSlashes( expand("%:p") ), 'rel' ]
endfu

"-------------------------------------------------------------------------------
" The mail-scheme.
" This is not an official scheme in the internet. I invented it to directly
" access individual Mails from a mail client.
"
" Synopsis :
"   mail://<box-path>?query
"
"   where query = [date=]<date>[&from=<from>][&subject=<subject>]
"
" Examples :
"   <url:mail:///Inbox?24.07.2007 13:23>
"   <url:mail://archive/Inbox?24.07.2007 13:23>
"
fu! Utl_AddressScheme_mail(auri, fragment, dispMode)
    call Utl_trace("- start execution of Utl_AddressScheme_mail",1,1) 

    if a:dispMode =~ '^copyFileName'
	echohl ErrorMsg | echo "function `copyFileName name to clipboard' not possible for scheme `mail:'" | echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_mail",1,-1) 
	return []
    endif

    if ! exists('g:utl_cfg_hdl_scm_mail')    " Entering setup
	call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_mail does not exist")
	echohl WarningMsg
	call input("No scheme handler variable g:utl_cfg_hdl_scm_mail defined yet. Entering Setup now. <RETURN>")
	echohl None
	Utl openLink config:#r=utl_cfg_hdl_scm_mail split
	call Utl_trace("- end execution of Utl_AddressScheme_mail",1,-1) 
	return []
    endif
    call Utl_trace("- Vim variable g:utl_cfg_hdl_scm_mail exists, value=`".g:utl_cfg_hdl_scm_mail."'")

    let authority = UtlUri_unescape( UtlUri_authority(a:auri) )
    let path = UtlUri_unescape( UtlUri_path(a:auri) )
    let query = UtlUri_unescape( UtlUri_query(a:auri) )
    call Utl_trace("- URL path components: authority=`".authority."', path=`".path."'" )

    " Parse query expression
    if query == '<undef>' || query == ""
	let v:errmsg = 'Query expression missing'
	echohl ErrorMsg | echo v:errmsg | echohl None
	return []
    endif
    let q_from =    ''
    let q_subject = ''
    let q_date =    ''
    while 1
	let pos = stridx(query, '&')
	if pos == -1
	    let entry = query
	else
	    let entry = strpart(query, 0, pos)
	    let query = strpart(query, pos+1)
	endif

	if entry =~ '^from='
	    let q_from = substitute(entry, '.*=', '', '')
	elseif entry =~ '^subject='
	    let q_subject = substitute(entry, '.*=', '', '')
	elseif entry =~ '^date='
	    let q_date = substitute(entry, '.*=', '', '')
	else
	    let q_date = entry
	endif
	if pos == -1
	    break
	endif
    endwhile
    call Utl_trace("- URL query attributes: date=`".q_date."', subject=`".q_subject."', from=`".q_from."'" )

    let convSpecDict= { 'a': authority, 'p': path, 'd': q_date, 'f': q_from, 's': q_subject }
    let [errmsg,cmd] = Utl_utilExpandConvSpec(g:utl_cfg_hdl_scm_mail, convSpecDict)
    if errmsg != ""
	echohl ErrorMsg
	echo "The content of your Vim variable g:utl_cfg_hdl_scm_mail=".g:utl_cfg_hdl_scm_mail."' is invalid and has to be fixed!"
	echo "Reason: `".errmsg."'"
	echohl None
	call Utl_trace("- end execution of Utl_AddressScheme_mail (not successful)",1,-1) 
	return []
    endif

    call Utl_trace("- Escape cmdline-special characters (".s:utl_esccmdspecial.") before execution")
    let cmd = escape( cmd, s:utl_esccmdspecial)

    let g:utl__hdl_scm_ret_list=[]
    let v:errmsg = ""
    call Utl_trace("- trying to execute command `".cmd."'")
    exe cmd

    if v:shell_error || v:errmsg!=""
	call Utl_trace("- execution of scm handler returned with v:shell_error or v:errmsg set")
	call Utl_trace("- end execution of Utl_AddressScheme_mail (not successful)",1,-1) 
	return []
    endif

    call Utl_trace("- end execution of Utl_AddressScheme_mail (successful)",1,-1) 
    return g:utl__hdl_scm_ret_list
endfu

let &cpo = s:save_cpo

plugin/utl_uri.vim
292
" ------------------------------------------------------------------------------
" File:		plugin/utl_uri.vim -- module for parsing URIs
"			        Part of the Utl plugin, see ./utl.vim
" Author:	Stefan Bittner <stb@bf-consulting.de>
" Licence:	This program is free software; you can redistribute it and/or
"		modify it under the terms of the GNU General Public License.
"		See http://www.gnu.org/copyleft/gpl.txt
" Version:	utl 3.0a
" ------------------------------------------------------------------------------

" Parses URI-References.
" (Can be used independantly from Utl.)
" (An URI-Reference is an URI + fragment: myUri#myFragment.
" See also <URL:vimhelp:utl-uri-refs>.
" Aims to be compliant with <URL:http://www.ietf.org/rfc/rfc2396.txt>
"
" NOTE: The distinction between URI and URI-Reference won't be hold out
"   (is that correct english? %-\ ). It should be clear from the context.
"   The fragment goes sometimes with the URI, sometimes not.
" 
" Usage:
"
"   " Parse an URI
"   let uri = 'http://www.google.com/search?q=vim#tn=ubiquitous'
"
"   let scheme = UtlUri_scheme(uri)
"   let authority = UtlUri_authority(uri)
"   let path = UtlUri_path(uri)
"   let query = UtlUri_query(uri)
"   let fragment = UtlUri_fragment(uri)
"
"   " Rebuild the URI
"   let uriRebuilt = UtlUri_build(scheme, authority, path, query, fragment)
"
"   " UtlUri_build a new URI
"   let uriNew = UtlUri_build('file', 'localhost', 'path/to/file', '<undef>', 'myFrag')
"
"   " Recombine an uri-without-fragment with fragment to an uri
"   let uriRebuilt = UtlUri_build_2(absUriRef, fragment)
"
"   let unesc = UtlUri_unescape('a%20b%3f')    " -> unesc==`a b?'
"   
" Details:
"   Authority, query and fragment can have the <undef> value (literally!)
"   (similar to undef-value in Perl). That's distinguished from
"   _empty_ values!  Example: http:/// yields UtlUri_authority=='' where as
"   http:/path/to/file yields UtlUri_authority=='<undef>'.
"   See also
"   <URL:http://www.ietf.org/rfc/rfc2396.txt#Note that we must be careful>
"
" Internal Note:
"   Ist not very performant in typical usage (but clear).
"   s:UtlUri_parse executed n times for getting n components of same uri

if exists("loaded_utl_uri") || &cp || v:version < 700
    finish
endif
let loaded_utl_uri = 1
let s:save_cpo = &cpo
set cpo&vim
let g:utl__file_uri = expand("<sfile>")


"------------------------------------------------------------------------------
" Parses `uri'. Used by ``public'' functions like UtlUri_path().
" - idx selects the component (see below)
fu! s:UtlUri_parse(uri, idx)

    " See <URL:http://www.ietf.org/rfc/rfc2396.txt#^B. Parsing a URI Reference>
    "
    " ^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?
    "  12            3  4          5       6  7        8 9
    " 
    " scheme    = \2
    " authority = \4
    " path      = \5
    " query     = \7
    " fragment  = \9

    " (don't touch! ;-)				id=_regexparse
    return substitute(a:uri, '^\(\([^:/?#]\+\):\)\=\(//\([^/?#]*\)\)\=\([^?#]*\)\(?\([^#]*\)\)\=\(#\(.*\)\)\=', '\'.a:idx, '')

endfu

"-------------------------------------------------------------------------------
fu! UtlUri_scheme(uri)
    let scheme = s:UtlUri_parse(a:uri, 2)
    " empty scheme impossible (an uri like `://a/b' is interpreted as path = `://a/b').
    if( scheme == '' )
	return '<undef>'
    endif
    " make lowercase, see
    " <URL:http://www.ietf.org/rfc/rfc2396.txt#resiliency>
    return tolower( scheme )
endfu

"-------------------------------------------------------------------------------
fu! UtlUri_opaque(uri)
    return s:UtlUri_parse(a:uri, 3) . s:UtlUri_parse(a:uri, 5) . s:UtlUri_parse(a:uri, 6)
endfu

"-------------------------------------------------------------------------------
fu! UtlUri_authority(uri)
    if  s:UtlUri_parse(a:uri, 3) == s:UtlUri_parse(a:uri, 4)
	return '<undef>'
    else 
	return s:UtlUri_parse(a:uri, 4)
    endif
endfu

"-------------------------------------------------------------------------------
fu! UtlUri_path(uri)
    return s:UtlUri_parse(a:uri, 5)
endfu

"-------------------------------------------------------------------------------
fu! UtlUri_query(uri)
    if  s:UtlUri_parse(a:uri, 6) == s:UtlUri_parse(a:uri, 7)
	return '<undef>'
    else 
	return s:UtlUri_parse(a:uri, 7)
    endif
endfu

"-------------------------------------------------------------------------------
fu! UtlUri_fragment(uri)
    if  s:UtlUri_parse(a:uri, 8) == s:UtlUri_parse(a:uri, 9)
	return '<undef>'
    else 
	return s:UtlUri_parse(a:uri, 9)
    endif
endfu


"------------------------------------------------------------------------------
" Concatenate uri components into an uri -- opposite of s:UtlUri_parse
" see <URL:http://www.ietf.org/rfc/rfc2396.txt#are recombined>
"
" - it should hold: s:UtlUri_parse + UtlUri_build = exactly the original Uri
"
fu! UtlUri_build(scheme, authority, path, query, fragment)


    let result = ""
    if a:scheme != '<undef>'
	let result = result . a:scheme . ':'
    endif

    if a:authority != '<undef>'
	let result = result . '//' . a:authority
    endif

    let result = result . a:path 

    if a:query != '<undef>'
	let result = result . '?' . a:query
    endif

    if a:fragment != '<undef>'
	let result = result . '#' . a:fragment
    endif

    return result
endfu

"------------------------------------------------------------------------------
" Build uri from uri without fragment and fragment
"
fu! UtlUri_build_2(absUriRef, fragment)

    let result = ""
    if a:absUriRef != '<undef>'
	let result = result . a:absUriRef
    endif
    if a:fragment != '<undef>'
	let result = result . '#' . a:fragment
    endif
    return result
endfu


"------------------------------------------------------------------------------
" Constructs an absolute URI from a relative URI `uri' by the help of given
" `base' uri and returns it.
"
" See
" <URL:http://www.ietf.org/rfc/rfc2396.txt#^5.2. Resolving Relative References>
" - `uri' may already be absolute (i.e. has scheme), is then returned
"   unchanged
" - `base' should really be absolute! Otherwise the returned Uri will not be
"   absolute (scheme <undef>). Furthermore `base' should be reasonable (e.g.
"   have an absolute Path in the case of hierarchical Uri)
"
fu! UtlUri_abs(uri, base)

    " see <URL:http://www.ietf.org/rfc/rfc2396.txt#If the scheme component>
    if UtlUri_scheme(a:uri) != '<undef>'
	return a:uri
    endif

    let scheme = UtlUri_scheme(a:base)

    " query, fragment never inherited from base, wether defined or not,
    " see <URL:http://www.ietf.org/rfc/rfc2396.txt#not inherited from the base URI>
    let query = UtlUri_query(a:uri)
    let fragment = UtlUri_fragment(a:uri)

    " see <URL:http://www.ietf.org/rfc/rfc2396.txt#If the authority component is defined>
    let authority = UtlUri_authority(a:uri)
    if authority != '<undef>'
	return UtlUri_build(scheme, authority, UtlUri_path(a:uri), query, fragment)
    endif

    let authority = UtlUri_authority(a:base)

    " see <URL:http://www.ietf.org/rfc/rfc2396.txt#If the path component begins>
    let path = UtlUri_path(a:uri)
    if path[0] == '/'
	return UtlUri_build(scheme, authority, path, query, fragment)
    endif
	
    " see <URL:http://www.ietf.org/rfc/rfc2396.txt#needs to be merged>

    "	    step a)
    let new_path = substitute( UtlUri_path(a:base), '[^/]*$', '', '')
    "	    step b)
    let new_path = new_path . path

    " TODO: implement the missing steps (purge a/b/../c/ into a/c/ etc),
    " CR048#r=_diffbuffs: Implement one special case though: Remove ./ segments
    " since these can trigger a Vim-Bug where two path which specify the same
    " file lead to different buffers, which in turn is a problem for Utl.
    " Have to substitute twice since adjacent ./ segments, e.g. a/././b
    " not substituted else (despite 'g' flag). Another Vim-Bug?
    let new_path = substitute( new_path, '/\./', '/', 'g') 
    let new_path = substitute( new_path, '/\./', '/', 'g') 

    return UtlUri_build(scheme, authority, new_path, query, fragment)


endfu

"------------------------------------------------------------------------------
" strip eventual #myfrag.
" return uri. can be empty
"
fu! UriRef_getUri(uriref)
    let idx = match(a:uriref, '#')
    if idx==-1
	return a:uriref
    endif
    return strpart(a:uriref, 0, idx)
endfu

"------------------------------------------------------------------------------
" strip eventual #myfrag.
" return uri. can be empty or <undef>
"
fu! UriRef_getFragment(uriref)
    let idx = match(a:uriref, '#')
    if idx==-1
	return '<undef>'
    endif
    return strpart(a:uriref, idx+1, 9999)
endfu


"------------------------------------------------------------------------------
" Unescape unsafe characters in given string, 
" e.g. transform `10%25%20is%20enough' to `10% is enough'.
" 
" - typically string is an uri component (path or fragment)
"
" (see <URL:http://www.ietf.org/rfc/rfc2396.txt#2. URI Characters and Escape Sequences>)
"
fu! UtlUri_unescape(esc)
    " perl: $str =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/eg
    let esc = a:esc
    let unesc = ''
    while 1
	let ibeg = match(esc, '%[0-9A-Fa-f]\{2}')
	if ibeg == -1
	    return unesc . esc
	endif
	let chr = nr2char( "0x". esc[ibeg+1] . esc[ibeg+2] )
	let unesc = unesc . strpart(esc, 0, ibeg) . chr 
	let esc = strpart(esc, ibeg+3, 9999)

    endwhile
endfu

let &cpo = s:save_cpo
