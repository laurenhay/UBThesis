%%% ======================================================================
%%%  @LaTeX-file{
%%%     filename  = "psuthesis.sty",
%%%     version   = "2.3.2",
%%%     date      = "2007/06/06",
%%%     time      = "13:00:00 EDT",
%%%     author    = "Gary L. Gray & Francesco Costanzo",
%%%     copyright = "Gary L. Gray & Francesco Costanzo",
%%%     address   = "Engineering Science and Mechanics,
%%%                  212 Earth & Engineering Sciences Bldg.,
%%%                  Penn State University,
%%%                  University Park, PA 16802,
%%%                  USA",
%%%     telephone = "814-863-1778 (GLG) or
%%%                  814-863-2030 (FC)",
%%%     FAX       = "814-865-9974",
%%%     email     = "gray@engr.psu.edu (GLG) or
%%%                  costanzo@engr.psu.edu (FC)",
%%%     keywords  = "latex, psuthesis, thesis class",
%%%     supported = "yes",
%%%     abstract  = "This package provides a style for typesetting
%%%                  Penn State theses at the bachelors, masters,
%%%                  or Ph.D. level."
%%%  }
%%% ======================================================================
% Change History
%
% Version 2.3.2: * Changed the implementation of the tocloft package
%                  to remove the ``black boxes'' about which we got so
%                  many queries. It still isn't perfect, but it is better
%                  than it was before. Note that chapter titles that take
%                  two lines or more in the TOC now have hanging indents.
%                  We haven't been able to eliminate this, but we kind of
%                  like it, so we are leaving it as is (for now).
%
% Version 2.3.1: * Added 10pt and 11pt options to the document class,
%                  though we have no idea why anyone would want to use
%                  such insanely small font sizes since it will lead to
%                  line lengths that are much too long.
%
% Version 2.3.0: * Made substantial changes to the psuthesis.cls file
%                  since the draft option was not being passed to the book
%                  class. The change we made also prevents users from
%                  loading options that are not ``recommended''. We
%                  want to thank Jared Craig Ahern for pointing out this
%                  problem and suggesting the fix.
%
% Version 2.2.0: * Two additional class options have been added to
%                  support honors theses submitted to the Schreyer
%                  Honors College. These options are:
%                     - honors
%                     - honorsdepthead
%
%                * We have also added the commands:
%                     - honorsdegreeinfo
%                     - honorsadviser
%                     - honorsdepthead
%
%                  See the driver file for details on these options and
%                  commands.
%
% Version 2.1.2: * Added a note both here and in the template file for
%                  users wanted to implement the subfigure package. That
%                  is, if you want to use the subfigure package you need
%                  to add an option when the tocloft package is loaded.
%
% Version 2.1.1: * Fixed a bug, introduced in 2.1.0, that prevented any
%                  entries from appearing the List of Figures. :-)
%
% Version 2.1.0: * Class now requires the tocloft package to format the
%                  TOC to correspond to PSU Grad School requirements.
%                * Added the \Appendix command to work around a quirk in
%                  LaTeX that makes \addtocontents not work well with
%                  \include.
%                * Eliminated a ton of booleans associated with the
%                  management of the frontmatter. This makes the
%                  frontmatter more intuitive, but it also presents you
%                  with the noose with which you can hang yourself. Sorry.
%                * Added the inlinechaptertoc option to the class. Allows
%                  for an alternate TOC format for Chapter and Appendix
%                  entries.
%                * There is no longer a sigpage option for the class.
%
% Version 2.0.5: * Updated the signature page and added a committee page
%                  to conform to the new grad school requirement.
%                * There is now a sigpage option for the signature page
%                  (it can be turned off) and the standard
%                  now does not have signatures.
%                * Fixed problem with TOC page numbers of List of Figures,
%                  List of Tables, etc.
%                * Cleaned up a few things, especially the boolean logic
%                  for the degree type.
%
%                Version 2.0.5 owes a debt to Penn State graduate student
%                Nils Krahnstoever who sent us a list of bugs along with
%                some excellent suggestions.
%
% Version 2.0.4: Changed the alignment of "Date of Signature" text
%
% Version 2.0.3: Fixed the invocation of \psu@title to allow for \\
%                line breaks. The \MakeUppercase command originally
%                was not, for some reason, working. Unfortunately, we
%                had to resort to some TeX primitives.
%
% Version 2.0.2: Added vita to bs and ba option for the Schreyer's
%                Honors College.
%
% Version 2.0.1: * No longer include the abstract in the TOC.
%                * Double space the title on the title page.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{psuthesis}[2007/06/06 v2.3.2 psuthesis class]
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Declare options for different degree types.
% Allowable degrees are:
%     Ph.D. using class option <phd>
%     M.S. using class option <ms>
%     M.Eng. using class option <meng>
%     M.A. using class option <ma>
%     B.S. using class option <bs>
%     B.A. using class option <ba>
%     Bachelors degree with honors using class option <honors>
%
% The option of an option sets the boolean for that option to
% true and all others to false.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newboolean{psu@secondthesissupervisor}
\newboolean{psu@honorsdepthead}
\newboolean{psu@honors}
\newboolean{psu@bs}
\newboolean{psu@ba}
\newboolean{psu@ms}
\newboolean{psu@meng}
\newboolean{psu@ma}
\newboolean{psu@phd}
\newboolean{psu@toc}
\setboolean{psu@secondthesissupervisor}{false}
\setboolean{psu@honorsdepthead}{false}
\setboolean{psu@honors}{false}
\setboolean{psu@bs}{false}
\setboolean{psu@ba}{false}
\setboolean{psu@ms}{false}
\setboolean{psu@meng}{false}
\setboolean{psu@ma}{false}
\setboolean{psu@phd}{false}

\DeclareOption{bs}{\setboolean{psu@bs}{true}\setboolean{psu@phd}{false}}
\DeclareOption{ba}{\setboolean{psu@ba}{true}\setboolean{psu@phd}{false}}
\DeclareOption{ms}{\setboolean{psu@ms}{true}\setboolean{psu@phd}{false}}
\DeclareOption{meng}{\setboolean{psu@meng}{true}\setboolean{psu@phd}{false}}
\DeclareOption{ma}{\setboolean{psu@ma}{true}\setboolean{psu@phd}{false}}
\DeclareOption{phd}{\setboolean{psu@phd}{true}}
\DeclareOption{inlinechaptertoc}{\setboolean{psu@toc}{true}}
\DeclareOption{honorsdepthead}{\setboolean{psu@honorsdepthead}{true}}
\DeclareOption{secondthesissupervisor}{\setboolean{psu@secondthesissupervisor}{true}}
\DeclareOption{honors}{\setboolean{psu@honors}{true}%...
\setboolean{psu@bs}{false}\setboolean{psu@ba}{false}\setboolean{psu@phd}{false}}

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption*{\PackageWarning{psuthesis}{Unknown option `\CurrentOption'. Ignoring}}
\ExecuteOptions{phd} % the default option is <phd>
\ProcessOptions
\LoadClass[openany]{book}
\RequirePackage{calc}
\RequirePackage{setspace}
% If you are using the subfigure package, load the tocloft package with
% the subfigure option and comment out the next line.
% \RequirePackage{tocloft}[2003/09/26]
%\RequirePackage[subfigure]{tocloft}[2003/09/26]
%\RequirePackage{fancyhdr}

% Define the margins and other spacings.
\setlength{\oddsidemargin}{35pt}
\setlength{\evensidemargin}{5pt}
\setlength{\topmargin}{-32pt}
\setlength{\headheight}{12pt}
\setlength{\headsep}{\baselineskip}
\setlength{\textheight}{9.in}
\setlength{\textwidth}{6in}


% Set the linestretch using the setspace package.
% The LaTeX Companion claims that a \baselinestretch of
% 1.24 gives one-and-a-half line spacing, which is allowed
% by the PSU thesis office. FC likes 1.28 better. :-)
\setstretch{1.2}


%%%%%%%%%%%%%%%%%%%%%%%%
% Settings for tocloft %
%%%%%%%%%%%%%%%%%%%%%%%%
% Format chapter entries so that the chapter name goes on a line
% following "Chapter #".
\renewcommand{\@pnumwidth}{1.75em} % remove TOC margin errors
\renewcommand{\@tocrmarg}{2.75em}
\newlength{\mylength}% a "scratch" lengthg
\newlength{\mylonglength}% another "scratch" length
\ifthenelse{\boolean{psu@toc}}
{%
% Format chapter entries so that the chapter name goes on the same line
% as "Chapter #".
\renewcommand{\cftchappresnum}{Chapter }
\settowidth{\mylength}{\bfseries\cftchappresnum\cftchapaftersnum}% extra space% add the extra space
%
\newcommand{\mylongname}{Appendix }% the longest chapter number header
\settowidth{\mylonglength}{\bfseries\mylongname\cftchapaftersnum}% extra space
%
}
% {%
% \renewcommand{\cftchappresnum}{Chapter }
% \renewcommand{\cftchapaftersnumb}{\\ \mbox{}\hspace{-\mylength}\hspace{-0.1em}}
% \settowidth{\mylength}{\bfseries\cftchappresnum\cftchapaftersnum} % extra space
% \addtolength{\cftchapnumwidth}{\mylength+0.1em} % add the extra space\renewcommand{\cftchapfont}{\bfseries}
% }%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Here we define internal "commands" that will be used to store the
% thesis title, author name, department, etc.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Store the title of the thesis.
\newcommand{\psu@title}{Theory of Everything}
\renewcommand{\title}[1]{\renewcommand{\psu@title}{#1}}

% Store the author's name.
\newcommand{\psu@author}{Richard Feynman}
\renewcommand{\author}[1]{\renewcommand{\psu@author}{#1}}

% Store the department name.
\newcommand{\psu@dept}{ESM}
\providecommand{\dept}[1]{\renewcommand{\psu@dept}{#1}}

% Store the date the degree will be conferred.
\newcommand{\psu@degreedate}{May 1900}
\providecommand{\degreedate}[1]{\renewcommand{\psu@degreedate}{#1}}

% Store the year of the copyright.
\newcommand{\psu@copyrightyear}{1900}
\providecommand{\copyrightyear}[1]{\renewcommand{\psu@copyrightyear}{#1}}

% Store the document type.
\newcommand{\psu@documenttype}{Thesis}
\providecommand{\documenttype}[1]{\renewcommand{\psu@documenttype}{#1}}

% Store the academic unit to which the document has been submitted.
\newcommand{\psu@submittedto}{The Graduate School}
\providecommand{\submittedto}[1]{\renewcommand{\psu@submittedto}{#1}}

% Store the the info for the honors degree(s) type(s).
\newcommand{\psu@honorsdegreeinfo}{for a baccalaureate degree(s) \\ in Biology and Physics \\ with honors in Computer Engineering}
\providecommand{\honorsdegreeinfo}[1]{\renewcommand{\psu@honorsdegreeinfo}{#1}}

% Store the academic unit to which the document has been submitted.
\newcommand{\psu@honorsadviser}{Your Honors Adviser}
\providecommand{\honorsadviser}[1]{\renewcommand{\psu@honorsadviser}{#1}}

% Store the academic unit to which the document has been submitted.
\newcommand{\psu@honorsdepthead}{Department Q. Head}
\providecommand{\honorsdepthead}[1]{\renewcommand{\psu@honorsdepthead}{#1}}

% Store the name of the second Thesis Supervisor for a baccalaureate degree.
\newcommand{\psu@secondthesissupervisor}{Second Q. Jones}
\providecommand{\secondthesissupervisor}[1]{\renewcommand{\psu@secondthesissupervisor}{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Store the name of the degree by determining which boolean was
% set in the class option was specified.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{psu@bs}}%
{\newcommand{\psu@degreetype}{Baccalaureate of Science}}%
{}

\ifthenelse{\boolean{psu@ba}}%
{\newcommand{\psu@degreetype}{Baccalaureate of Arts}}%
{}

\ifthenelse{\boolean{psu@ms}}%
{\newcommand{\psu@degreetype}{Master of Science}}%
{}

\ifthenelse{\boolean{psu@meng}}%
{\newcommand{\psu@degreetype}{Master of Engineering}}%
{}

\ifthenelse{\boolean{psu@ma}}%
{\newcommand{\psu@degreetype}{Master of Arts}}%
{}

\ifthenelse{\boolean{psu@phd}}%
{\newcommand{\psu@degreetype}{Doctor of Philosophy}}%
{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Store the number of readers in \psu@readers. This quantity is
% input in the main file using the \numberofreaders command.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\psu@readers}{4}
\providecommand{\numberofreaders}[1]{\renewcommand{\psu@readers}{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\psu@advisor}{John Doe}
\newcommand{\psu@advisortitle}{John Doe}
\newcommand{\psu@advisoroption}{}%
\providecommand{\advisor}[3][]%
{\renewcommand{\psu@advisoroption}{#1}%
\renewcommand{\psu@advisor}{#2}%
\renewcommand{\psu@advisortitle}{#3}}

\newcommand{\psu@readerone}{John Doe}
\newcommand{\psu@readeronetitle}{John Doe}
\newcommand{\psu@readeroneoption}{}%
\providecommand{\readerone}[3][]%
{\renewcommand{\psu@readeroneoption}{#1}%
\renewcommand{\psu@readerone}{#2}%
\renewcommand{\psu@readeronetitle}{#3}}

\newcommand{\psu@readertwo}{John Doe}
\newcommand{\psu@readertwotitle}{John Doe}
\newcommand{\psu@readertwooption}{}%
\providecommand{\readertwo}[3][]%
{\renewcommand{\psu@readertwooption}{#1}%
\renewcommand{\psu@readertwo}{#2}%
\renewcommand{\psu@readertwotitle}{#3}}

\newcommand{\psu@readerthree}{John Doe}
\newcommand{\psu@readerthreetitle}{John Doe}
\newcommand{\psu@readerthreeoption}{}%
\providecommand{\readerthree}[3][]%
{\renewcommand{\psu@readerthreeoption}{#1}%
\renewcommand{\psu@readerthree}{#2}%
\renewcommand{\psu@readerthreetitle}{#3}}

\newcommand{\psu@readerfour}{John Doe}
\newcommand{\psu@readerfourtitle}{John Doe}
\newcommand{\psu@readerfouroption}{}%
\providecommand{\readerfour}[3][]%
{\renewcommand{\psu@readerfouroption}{#1}%
\renewcommand{\psu@readerfour}{#2}%
\renewcommand{\psu@readerfourtitle}{#3}}

\newcommand{\psu@readerfive}{John Doe}
\newcommand{\psu@readerfivetitle}{John Doe}
\newcommand{\psu@readerfiveoption}{}%
\providecommand{\readerfive}[3][]%
{\renewcommand{\psu@readerfiveoption}{#1}%
\renewcommand{\psu@readerfive}{#2}%
\renewcommand{\psu@readerfivetitle}{#3}}

\newcommand{\psu@readersix}{John Doe}
\newcommand{\psu@readersixtitle}{John Doe}
\newcommand{\psu@readersixoption}{}%
\providecommand{\readersix}[3][]%
{\renewcommand{\psu@readersixoption}{#1}%
\renewcommand{\psu@readersix}{#2}%
\renewcommand{\psu@readersixtitle}{#3}}


\newsavebox{\tempbox}
\renewcommand{\@makecaption}[2]{%
\vspace{7pt}\sbox{\tempbox}{\small\textbf{#1.} #2}%
\ifthenelse{\lengthtest{\wd\tempbox > \linewidth}}%
{\small\textbf{#1.} #2\par}%
{\centering \small\textbf{#1.} #2}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                %
% The actual layout begins here. %
%                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Here is the permission page.
\newcommand{\psupermissionpage}{%
\thispagestyle{empty}
\begin{singlespace}
\noindent
I grant The University at Buffalo the non-exclusive right to use this work for the University's own purposes and to make single copies of the work available to the public on a not-for-profit basis if copies are not otherwise available. \\[0.6in]
\mbox{} \hfill
\parbox{3in}{\begin{center} \rule{3in}{0.4pt} \\ \psu@author
\end{center}}
\end{singlespace}
\newpage
\addtocounter{page}{-1}
}

% Here is the title page.
\newcommand{\psutitlepage}{%
\setcounter{page}{1}
\thispagestyle{empty}%
{
\vspace*{-0.75in}
\vfill
\begin{center}
    \setstretch{2}
    \bfseries\uppercase\expandafter{\psu@title}
\end{center}
\vfill
\begin{center}
    by\\
    \vfill
    \psu@author\\
    \psu@degreedate
\end{center}
\vfill
\vfill
\begin{center}
    A dissertation submitted to the \\ faculty of the Graduate School of \\ the University at Buffalo, The State University of New York \\ in partial fulfilment of the requirements for the degree of
\end{center}
\vfill
\begin{center}
     \psu@degreetype
\end{center}
\vfill
\begin{center}
   \psu@dept\\
\end{center}

\newpage
\ifthenelse{\boolean{psu@ms} \or \boolean{psu@meng} \or \boolean{psu@ma}}{\psupermissionpage}{}
}}

%Here is the Copyright Page

\newcommand{\copyrightpage}[1]{%
\pagestyle{plain}
\begin{singlespace}
    \input{#1}
\end{singlespace}
}

% Here is the signature page.
\newcommand{\signature}[1]{%
\begin{minipage}{\textwidth}
   \rule{3.9in}{0.4pt} \hfill \rule{1.375in}{0.4pt} \\ {\normalsize #1}
\end{minipage}}

\newlength{\psu@sigoptionskip}
\newlength{\psu@sigafteroptionskip}
\newlength{\psu@intersigspace}
% \newlength{\psu@spacebeforedateofsig}
% \settowidth{\psu@spacebeforedateofsig}{\normalsize Date of Signature}
\setlength{\psu@sigoptionskip}{-0.04in}
\newcommand{\psu@signaturepage}{%
    \footnotesize
    \ifthenelse{\psu@readers = 6}{%
        \setlength{\psu@sigafteroptionskip}{2.65\baselineskip}
        \setlength{\psu@intersigspace}{2.65\baselineskip}
    }%
    {%
        \setlength{\psu@sigafteroptionskip}{3.4\baselineskip}
        \setlength{\psu@intersigspace}{3.4\baselineskip}
    }
    \enlargethispage*{0.5in}
    \thispagestyle{empty}
    \vspace*{-0.5in}
    \noindent {\normalsize We approve the thesis of \psu@author.}\\[0.1in]
    \mbox{}\hspace{4.37in} {\normalsize Date of Signature}\\[3\baselineskip]
    \signature\psu@advisor\\[1mm]
         \psu@advisortitle
         \ifthenelse{\equal{\psu@advisoroption}{}}%
                    {\\[\psu@intersigspace]}%
                    {\\[\psu@sigoptionskip]
                        \psu@advisoroption \\[\psu@sigafteroptionskip]}
\ifcase \psu@readers
\or
     \signature\psu@readerone\\[1mm]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readeroneoption}
\or
     \signature\psu@readerone\\[1mm]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readertwo\\[1mm]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readertwooption}
\or
     \signature{\psu@readerone}\\[1mm]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
     \signature{\psu@readertwo}\\[1mm]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
     \signature{\psu@readerthree}\\[1mm]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readerthreeoption}
\or
     \signature\psu@readerone\\[1mm]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readertwo\\[1mm]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerthree\\[1mm]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerthreeoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerfour\\[1mm]
          \psu@readerfourtitle
          \ifthenelse{\equal{\psu@readerfouroption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readerfouroption}
\or
     \signature\psu@readerone\\[1mm]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readertwo\\[1mm]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerthree\\[1mm]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerthreeoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerfour\\[1mm]
          \psu@readerfourtitle
          \ifthenelse{\equal{\psu@readerfouroption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerfouroption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerfive\\[1mm]
          \psu@readerfivetitle
          \ifthenelse{\equal{\psu@readerfiveoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readerfiveoption}
\or
     \signature\psu@readerone\\[1mm]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readertwo\\[1mm]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerthree\\[1mm]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerthreeoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerfour\\[1mm]
          \psu@readerfourtitle
          \ifthenelse{\equal{\psu@readerfouroption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerfouroption \\[\psu@sigafteroptionskip]}
     \signature\psu@readerfive\\[1mm]
          \psu@readerfivetitle
          \ifthenelse{\equal{\psu@readerfiveoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerfiveoption \\[\psu@sigafteroptionskip]}
     \signature\psu@readersix\\[1mm]
          \psu@readersixtitle
          \ifthenelse{\equal{\psu@readersixoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readersixoption}
\fi
\newpage
\normalsize
}

% Here is the committee page.
\newcommand{\psucommitteepage}{%
    \setlength{\textheight}{8in}
    \ifthenelse{\psu@readers = 6}{%
        \setlength{\psu@sigafteroptionskip}{1.0\baselineskip}
        \setlength{\psu@intersigspace}{1.0\baselineskip}
    }%
    {%
        \setlength{\psu@sigafteroptionskip}{1.5\baselineskip}
        \setlength{\psu@intersigspace}{1.5\baselineskip}
    }
    \thispagestyle{plain}
    \vspace*{-0.5in}
    \noindent {\normalsize The thesis of \psu@author\ was reviewed by the following:}\\[3\baselineskip]
%and approved$^{*}$ add this part in when it is reviewed and approved. Also uncomment the \parbox command below.
\mbox{}\hfill
\parbox{\textwidth - 0.5in}{
         \psu@advisor\\[\psu@sigoptionskip]
         \psu@advisortitle
         \ifthenelse{\equal{\psu@advisoroption}{}}%
                    {\\[\psu@intersigspace]}%
                    {\\[\psu@sigoptionskip]
                        \psu@advisoroption \\[\psu@sigafteroptionskip]}
\ifcase \psu@readers
\or
          \psu@readerone\\[\psu@sigoptionskip]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readeroneoption}
\or
          \psu@readerone\\[\psu@sigoptionskip]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
          \psu@readertwo\\[\psu@sigoptionskip]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readertwooption}
\or
          {\psu@readerone}\\[\psu@sigoptionskip]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
          {\psu@readertwo}\\[\psu@sigoptionskip]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
          {\psu@readerthree}\\[\psu@sigoptionskip]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readerthreeoption}
\or
          \psu@readerone\\[\psu@sigoptionskip]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
          \psu@readertwo\\[\psu@sigoptionskip]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
          \psu@readerthree\\[\psu@sigoptionskip]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerthreeoption \\[\psu@sigafteroptionskip]}
          \psu@readerfour\\[\psu@sigoptionskip]
          \psu@readerfourtitle
          \ifthenelse{\equal{\psu@readerfouroption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readerfouroption}
\or
          \psu@readerone\\[\psu@sigoptionskip]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
          \psu@readertwo\\[\psu@sigoptionskip]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
          \psu@readerthree\\[\psu@sigoptionskip]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerthreeoption \\[\psu@sigafteroptionskip]}
          \psu@readerfour\\[\psu@sigoptionskip]
          \psu@readerfourtitle
          \ifthenelse{\equal{\psu@readerfouroption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerfouroption \\[\psu@sigafteroptionskip]}
          \psu@readerfive\\[\psu@sigoptionskip]
          \psu@readerfivetitle
          \ifthenelse{\equal{\psu@readerfiveoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readerfiveoption}
\or
          \psu@readerone\\[\psu@sigoptionskip]
          \psu@readeronetitle
          \ifthenelse{\equal{\psu@readeroneoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readeroneoption \\[\psu@sigafteroptionskip]}
          \psu@readertwo\\[\psu@sigoptionskip]
          \psu@readertwotitle
          \ifthenelse{\equal{\psu@readertwooption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readertwooption \\[\psu@sigafteroptionskip]}
          \psu@readerthree\\[\psu@sigoptionskip]
          \psu@readerthreetitle
          \ifthenelse{\equal{\psu@readerthreeoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerthreeoption \\[\psu@sigafteroptionskip]}
          \psu@readerfour\\[\psu@sigoptionskip]
          \psu@readerfourtitle
          \ifthenelse{\equal{\psu@readerfouroption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerfouroption \\[\psu@sigafteroptionskip]}
          \psu@readerfive\\[\psu@sigoptionskip]
          \psu@readerfivetitle
          \ifthenelse{\equal{\psu@readerfiveoption}{}}%
                     {\\[\psu@intersigspace]}%
                     {\\[\psu@sigoptionskip]
                               \psu@readerfiveoption \\[\psu@sigafteroptionskip]}
          \psu@readersix\\[\psu@sigoptionskip]
          \psu@readersixtitle
          \ifthenelse{\equal{\psu@readersixoption}{}}%
                     {}%
                     {\\[\psu@sigoptionskip] \psu@readersixoption}
\fi
}


%\mbox{}\vfill

%\noindent
%\parbox{\textwidth}{$^{*}$Signatures are on file in the Graduate School.}

\newpage
}
%



\newcommand{\psusigpage}{%\setlength{\textheight}{8.0in}
{\Huge\thispagestyle{empty}
\sffamily\bfseries
\mbox{}\vfill
\noindent
The following page is the Signature Page. The Signature Page needs to be given to the Grad School, but it should not be bound with the thesis.
\begin{center}
\tiny Don't bind this page either!
\end{center}
\vfill
}
\newpage
\psu@signaturepage}



\newcommand{\thesisabstract}[1]{%
\pagestyle{plain}
\chapter{Introduction}
    \begin{doublespace}
        \input{#1}
    \end{doublespace}
\newpage
}


\renewcommand{\contentsname}{Table of Contents}
\setcounter{secnumdepth}{10}
\setcounter{tocdepth}{4}
\newcommand{\thesistableofcontents}{%
\begin{singlespace}
\if@twocolumn
\@restonecoltrue\onecolumn
\else
\@restonecolfalse
\fi
\chapter*{\contentsname
\@mkboth{%
\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
\@starttoc{toc}%
\if@restonecol\twocolumn\fi%
\end{singlespace}
\clearpage
}

\renewcommand{\listfigurename}{List of Figures}
\newcommand{\thesislistoffigures}{%
\begin{doublespace}
\if@twocolumn
\@restonecoltrue\onecolumn
\else
\@restonecolfalse
\fi
\chapter{\listfigurename
\@mkboth{%
\MakeUppercase\listfigurename}{\MakeUppercase\listfigurename}}%
\@starttoc{lof}%
\if@restonecol\twocolumn\fi
\end{doublespace}
\clearpage
}

\renewcommand{\listtablename}{List of Tables}
\newcommand{\thesislistoftables}{%
\begin{singlespace}
\if@twocolumn
\@restonecoltrue\onecolumn
\else
\@restonecolfalse
\fi
\chapter{\listtablename
\@mkboth{%
\MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
\@starttoc{lot}%
\if@restonecol\twocolumn\fi
\end{singlespace}
\clearpage
}


\newcommand{\thesislistofsymbols}[1]{%
\chapter{List of Symbols}
%\addcontentsline{toc}{chapter}{List of Symbols}
\begin{singlespace}
    \input{#1}
\end{singlespace}
}



\newcommand{\thesisacknowledgments}[1]{%
\chapter{Acknowledgments}
%\addcontentsline{toc}{chapter}{Acknowledgments}
\begin{doublespace}
    \input{#1}
\end{doublespace}
}


\newcommand{\thesisdedication}[2]{%
\chapter*{#2}
\begin{singlespace}
    \input{#1}
\end{singlespace}
}




\newcommand{\Appendix}[1]{%
\ifthenelse{\value{chapter} = 0}
{
\ifthenelse{\boolean{psu@toc}}
{%
\addtocontents{toc}{\protect\addtolength{\cftchapnumwidth}{-\mylength}}
\addtocontents{toc}{\string\renewcommand{\string\cftchappresnum}{Appendix }}
\addtocontents{toc}{\protect\addtolength{\cftchapnumwidth}{\mylonglength}}
}%
{%
\addtocontents{toc}{\string\renewcommand{\string\cftchappresnum}{Appendix }}
}}{}%
\chapter{#1}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareRobustCommand{\thesismainmatter}{%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\mainmatter
\pagestyle{empty}
\renewcommand{\@oddhead}{\mbox{}\hfill\arabic{page}}
\let\ps@plain = \ps@empty
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \SetSinglespace{1.2}
\newcommand{\vita}[1]{%
\begin{singlespace}
\thispagestyle{empty}
\begin{center}
    \textbf{{\large Vita} \\[0.1in] \psu@author}
\end{center}
\input{#1}
\end{singlespace}
}


%%
%% End of file `psuthesis.cls'.
