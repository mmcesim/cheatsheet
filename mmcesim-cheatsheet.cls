%% mmcesim-cheatsheet.cls
%%
%% Author:   Wuqiong Zhao
%% License:  MIT
%% Git Repo: https://github.com/mmcesim/cheatsheet
%%
%% Note:
%% Use XeLaTeX or LuaLaTeX to compile.

\NeedsTeXFormat {LaTeX2e}
\RequirePackage {l3keys2e}
\ProvidesExplClass {mmcesim-cheatsheet}
  {2022/01/06} {0.1} {Class for mmCEsim Cheatsheet}

\str_const:Nn \c__mmcesim_cheatsheet_base_class_str { article }

\keys_define:nn { mmcesim-cheatsheet }
  {
    , cols .tl_set:N  = \l__mmcesim_cheatsheet_cols_tl
    , cols .initial:n = { 5 }
    , font .tl_set:N  = \l__mmcesim_cheatsheet_font_tl
    , font .initial:n = { libertine }
    , unknown .code:n =
        {
          \iow_term:x
            {
              Passing~option~\CurrentOption \c_space_tl to~
              \str_use:N \c__mmcesim_cheatsheet_base_class_str
            }
          \PassOptionsToClass { \CurrentOption } { \c__mmcesim_cheatsheet_base_class_str }
        }
  }
\ProcessKeysOptions { mmcesim-cheatsheet }
\LoadClass { \c__mmcesim_cheatsheet_base_class_str }

\NewDocumentCommand \mmCEsim@cols { } { \tl_use:N \l__mmcesim_cheatsheet_cols_tl }

%% Page Settings
\RequirePackage { geometry }
\geometry { margin=1cm, landscape, a3paper }
\pagenumbering{ gobble } % remove page numbering
\RequirePackage { flowfram }

\newlength { \colwidth }
\newlength { \colsep }
\newlength { \twocol }
\newlength { \titleheight }

\setlength { \colsep } { 10pt }
\setlength { \colwidth }
  {
    \dimexpr \fp_eval:n { 1 / \mmCEsim@cols }\textwidth -
    \fp_eval:n { 1 - 1 / \mmCEsim@cols }\colsep \relax
  }
\setlength { \twocol } { \dimexpr 2\colwidth + \colsep \relax }
\setlength { \titleheight } { 32mm }
\int_set:Nn \l_tmpa_int { 0 }
\int_new:N \l_cols_int
\int_set:Nn \l_cols_int { \mmCEsim@cols }
\int_do_while:nn { \l_tmpa_int < \l_cols_int }
  {
    \newflowframe [1,2] { \colwidth }
      {
        \dimexpr \textheight
        \bool_if:nT { \int_compare_p:nNn { \int_use:N \l_tmpa_int } < 2 }
          { -\titleheight }
        \relax
      }
      {
        \dimexpr \int_use:N \l_tmpa_int\colwidth + \int_use:N \l_tmpa_int\colsep \relax
      } { 0pt }
    \int_incr:N \l_tmpa_int
  }
\newstaticframe[1] { \twocol } { \titleheight }
  { 0pt } { \dimexpr \textheight-\titleheight \relax } [ title ]

%% Font Settings
\tl_if_empty:NF { \l__mmcesim_cheatsheet_font_tl }
  { \RequirePackage { \tl_use:N \l__mmcesim_cheatsheet_font_tl } }
\RequirePackage { fontspec }
\setmonofont [ Scale=MatchLowercase ] { inconsolata }

%% Figure Environemts
\RequirePackage { graphicx }
\graphicspath { { ./fig } }

%% Title Set Up
\RequirePackage [ usenames, dvipsnames ] { xcolor }
\DeclareDocumentCommand \maketitle { }
  {
    \begin{staticcontents*}{title}
      \begin{tabular}{ll}
        \smash{\raisebox{-.4\titleheight}{
          \includegraphics[height=\titleheight]{img/logo/mmCEsim_logo_256.png}
        }} & {\fontsize{32}{36}\selectfont\bfseries\color{Violet} mmCEsim~Cheatsheet} \\[2mm]
        {} & \large by~\textsc{Wuqiong~Zhao}~(\today)
      \end{tabular}
    \end{staticcontents*}
  }

% Hyperref

\RequirePackage { hyperref }
\hypersetup
  {
    , colorlinks = true
    , urlcolor   = blue
    , linkcolor  = purple
    , citecolor  = red
    , pdfauthor  = {Wuqiong~Zhao}
    , pdftitle   = {mmCEsim~Cheatsheet}
    , pdfsubject = {mmCEsim}
    , pdfcreator = {LaTeX~with~mmcesim-cheatsheet~Class}
  }

\endinput
