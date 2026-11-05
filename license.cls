\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{license}[2026/11/01 Latex class for Dojo Trieste license]


% ========================================%
% OPTIONS                                 %
% ========================================%

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=options,
    prefix=option@
}

\DeclareStringOption{Age}
\DeclareStringOption[10pt]{FontSize}
\DeclareStringOption[12cm]{PaperWidth}
\DeclareStringOption[16cm]{PaperHeight}

\ProcessKeyvalOptions*


% ========================================%
% CLASS EXTENSION                        %
% ========================================%

\PassOptionsToClass{\option@FontSize}{book}

\LoadClass[
    twoside
]{book}


% ========================================%
% PAPER SETTINGS                          %
% ========================================%

% Paper size and margins
\RequirePackage{geometry}
\geometry{
    paperwidth = \option@PaperWidth,
    paperheight = \option@PaperHeight,
    hmargin = 0.75cm,
    vmargin = 1cm,
    footskip = 0.5cm
}

% Font encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Font family
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

% Paragraph settings
\RequirePackage[
	skip = 0pt,
	indent = 0pt
]{parskip}

% Graphics
\RequirePackage{graphicx}
\graphicspath{ {./images} }

% Other packages
\RequirePackage{tabularray}
\RequirePackage{textcomp}


% ========================================%
% FANCY STYLE                             %
% ========================================%

\RequirePackage{fancyhdr}

\fancypagestyle{std}{
    \renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{-- \thepage\ --}
}


%========================================%
% COLORS                                 %
%========================================%

\RequirePackage{xcolor}

\definecolor{main}{RGB}{0, 40, 110}
\definecolor{gold}{RGB}{255, 128, 0}
\color{main}


%========================================%
% TIKZ                                   %
%========================================%

\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}

\renewcommand{\frame}{
    \tikz[remember picture, overlay] \draw
        (current page text area.south west)
        rectangle
        (current page text area.north east);
}


%========================================%
% TABLES                                 %
%========================================%

\newcommand{\StretchNRows}[1]{\dimexpr(
    \textheight 
    - 1.5cm % Title
    - 0.8cm % Header
    - \arrayrulewidth * (#1 + 3) % Horizontal lines
    - 2pt * (#1 + 2) % Vertical space between rows
)/10\relax}

\NewTblrEnviron{logtable}
\SetTblrInner[logtable]{
    width = {\textwidth},
    rowsep = 0pt,
    rows = {
        valign = m,
        abovesep = 2pt
    },
    row{1} = {
        ht = 1.5cm,
        font = {\large\bfseries}
    },
    row{2} = {
        ht = 0.8cm
    },
    row{3-Z} = {
        ht = \StretchNRows{10}
    },
    hlines, vlines
}

\newcommand{\RowNumber}[1]{\inteval{\value{rownum}-2+#1}}


%========================================%
% TOC                                    %
%========================================%

\RequirePackage{tocloft}

\renewcommand{\contentsname}{}
\renewcommand{\cfttoctitlefont}{}
\renewcommand{\cftaftertoctitle}{}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{0pt}


%========================================%
% DOCUMENT BEGIN                         %
%========================================%

\RequirePackage{pagecolor}
\RequirePackage{afterpage}

\AtBeginDocument{
    \frontmatter
    \pagestyle{empty}
    \begin{titlepage}
        \centering
        \vspace*{0.5cm}
        \includegraphics[height = 3cm]{logo.pdf} \\[0.5cm]
        \textbf{\color{black}\Large A.S.D. DOJO Trieste}
        \vfill
        \textbf{\large Libretto personale del} \\[0.5cm]
        \textbf{\Huge SOCIO}
        \ifx\option@Age\@empty
        \else
            \\[0.5cm]
            \textbf{\option@Age}
        \fi
        \vfill\vfill
        \includegraphics[height = 1cm]{fijlkam.pdf} \\
        Associazione sportiva affiliata \\
        alla FIJLKAM e al CONI
        \vspace{0.5cm}
        \tikz[remember picture, overlay] 
            \draw[rounded corners = 5mm, line width = 1mm, color = gold]
                (current page text area.south west)
                rectangle
                (current page text area.north east);
    \end{titlepage}
    \mainmatter{}
    \pagestyle{std}
}


%========================================%
% DOCUMENT END                           %
%========================================%

\AtEndDocument{
    \backmatter
    \tableofcontents
    \vfill
    \begin{center}
        \footnotesize
        Il presente libretto ha validità decennale dalla data di rilazio e deve essere conservato con cura dal socio. \\
        In caso di smarrimento o spazio insufficiente, il socio è tenuto a richiederne un altro.
    \end{center}
    \thispagestyle{empty}
}


%========================================%
% ELEMENTS                               %
%========================================%

\newcommand{\PersonData}{
    \addcontentsline{toc}{chapter}{DATI SOCIO}
    \frame
    \begin{center}
        \textit{Associazione Sportiva Dilettantistica} \\[0.2cm]
        \textbf{\LARGE DOJO TRIESTE}
    \end{center}
    \vfill
    \begin{center}
        \begin{tikzpicture}
            \draw (0,0) rectangle (35mm,45mm) node[midway, text opacity = 0.5] {FOTO};
        \end{tikzpicture}
    \end{center}
    \vfill\vfill
    \begin{tblr}{
        width = {\textwidth},
        colspec = {l X},
        hline{2-Y} = {solid},
        rows = {
            ht = 0.5cm,
            valign = m
        }
    }
        COGNOME & \\
        NOME \\
        DATA DI NASCITA \\
        LUOGO DI NASCITA \\
        CODICE FISCALE \\
        RESIDENZA \\
        DATA DI EMISSIONE
    \end{tblr}
}

\newcommand{\memberships}[1]{%
    \begin{logtable}{
        colspec = {c X[c] X[2, c]},
        column{1} = {
            leftsep = 1.5mm,
            rightsep = 1.5mm
        },
        cell{1}{1} = {c=3}{c},
        cell{3-Z}{1} = {cmd=\RowNumber{#1}}
    }
        ASSOCIAZIONI \\
        N. & {ANNO\\SOCIALE} & TIMBRO E FIRMA \\ \\ \\ \\ \\ \\ \\ \\ \\ \\ \\
    \end{logtable}%
}

\newcommand{\athlete}[1]{%
    \begin{logtable}{
        colspec = {c X[c] X[c] X[2, c]},
        column{1} = {
            leftsep = 1.5mm,
            rightsep = 1.5mm
        },
        cell{1}{1} = {c=4}{c},
        cell{3-Z}{1} = {cmd=\RowNumber{#1}}
    }
        STORICO ATLETA \\
        N. & {ANNO\\SPORTIVO} & SETTORE & TIMBRO E FIRMA \\ \\ \\ \\ \\ \\ \\ \\ \\ \\ \\
    \end{logtable}%
}

\newcommand{\belts}{%
    \begin{logtable}{
        colspec = {c X[2, c] X[3, c]},
        cell{1}{1} = {c=3}{c}
    }
        GRADUAZIONI \\
        CINTURA & DATA & FIRMA \\
        BIANCA \\
        {BIANCA\\GIALLA} \\
        GIALLA \\
        {GIALLA\\ARANCIONE} \\
        ARANCIONE \\
        {ARANCIONE\\VERDE} \\
        VERDE \\
        {VERDE\\BLU} \\
        BLU \\
        MARRONE
    \end{logtable}%
}