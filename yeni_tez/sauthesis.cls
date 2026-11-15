%% sauthesis.cls
%% Sakarya Universitesi Fen Bilimleri Enstitusu Lisansustu (Yuksek Lisans / Doktora) Tez Sinifi
%% Enstitunun resmi Word sablonu (sau-lisansustu-tez-sablonu) ve
%% "Lisansustu Tez Yazim Kilavuzu" (Senato 04.08.2022, 621-9) esas alinarak hazirlanmistir.
%% Derleme: LuaLaTeX (latexmk -lualatex tez.tex)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sauthesis}[2026/11/15 v1.0 SAU FBE Lisansustu Tez Sinifi]

%------------------------------------------------------------------ secenekler
\newif\ifsau@wordline \sau@wordlinetrue   % Word satir kirma/satir yuksekligi modeli
\newif\ifsau@notlar   \sau@notlartrue     % sablondaki kirmizi aciklama notlari
\newif\ifsau@doktora  \sau@doktoratrue
\newif\ifsau@wordbirebir \sau@wordbirebirfalse % Word sablonunun altbilgi tuhafliklarini da taklit et
\DeclareOption{wordline}{\sau@wordlinetrue}
\DeclareOption{texline}{\sau@wordlinefalse}
\DeclareOption{notlar}{\sau@notlartrue}
\DeclareOption{notsuz}{\sau@notlarfalse}
\DeclareOption{doktora}{\sau@doktoratrue}
\DeclareOption{yukseklisans}{\sau@doktorafalse}
\DeclareOption{wordbirebir}{\sau@wordbirebirtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[12bp,a4paper,twoside,openright]{report}

\RequirePackage{iftex}
\RequireLuaTeX

%------------------------------------------------------------------ sayfa duzeni
% Kilavuz Sekil 2.1-2.2: ust 2.5 cm, alt 2.5 cm, cilt tarafi (ic) 4 cm, dis 2.5 cm.
% Word sablonu: pgMar top=1418 bottom=1418 left=2268 right=1418 + mirrorMargins.
% Sayfa numarasi: alt-orta, 12 pt koyu; taban cizgisi sayfa altindan 51.1 pt yukarida
% (Word ciktisinda govde sayfalarindaki konum; kilavuz: "alttan 1,5 cm").
% Word'de son satirin yalnizca alt cikintisi (2.58 bp) alt kenar boslugunu asamaz; TeX'te ise
% son taban cizgisi metin blogunun altina oturur. Bu yuzden metin blogu 2.58 bp kisa tutulur.
% Ana metin: sayfa no taban cizgisi y=790.9 bp (Word ciktisi; alttan 1.8 cm)
% On kisim (Word sablonunda): metin alani y=741.1 bp'de biter, sayfa no taban cizgisi y=764.3 bp
\RequirePackage[a4paper,inner=4cm,outer=2.5cm,top=2.5cm,bottom=73.45bp,
  headheight=0bp,headsep=0bp,footskip=30.93bp]{geometry}
% Kilavuz 3.5: sayfa numarasi alttan 1,5 cm (taban cizgisi y = 841.89-42.52 = 799.37 bp);
% metin blogu alti y=768.44 bp -> footskip = 30.93 bp. On kisim da ayni metin alanini kullanir
% (Word sablonunda on kisimda altbilgideki bos paragraf metin alanini kisaltiyordu).
\newcommand\sau@onkisimgeometri{}
\newcommand\sau@anametingeometri{\restoregeometry}
% [wordbirebir] Word sablonunda 1. bolum ile ilk yatay sayfa arasindaki altbilgi (footer6) sayfa
% numarasinin altinda iki satirlik bos sekme paragrafi tasir: numara y=743.6 bp'ye cikar ve
% metin alani kisalir (son satirin tamami y=732.4 bp'nin ustunde kalir). 1. bolumun ilk sayfasi
% "farkli ilk sayfa" oldugundan altbilgisizdir ve tam metin alanini kullanir; kisa alan 2. sayfada
% baslar (sayfa sonu degistirilemedigi icin boyutlar ilk sayfa basildiktan hemen sonra degistirilir).
\newcommand\sau@kisaaltbilgibaslat{}% (kullanilmiyor: kilavuz 3.5 tek tip numara konumu ister)
\newif\ifsau@kisaaltbilgi
\setlength{\parindent}{0bp}

%------------------------------------------------------------------ yazi tipleri
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\defaultfontfeatures{Ligatures=NoCommon,Kerning=Off}
\IfFontExistsTF{Times New Roman}{%
  \setmainfont{Times New Roman}[Ligatures=NoCommon,Kerning=Off]%
}{%
  \ClassWarning{sauthesis}{Times New Roman bulunamadi, TeX Gyre Termes kullaniliyor}%
  \setmainfont{TeX Gyre Termes}[Ligatures=NoCommon,Kerning=Off]%
}
\IfFontExistsTF{Cambria Math}{%
  \setmathfont{Cambria Math}%
}{%
  \IfFontExistsTF{STIX Two Math}{\setmathfont{STIX Two Math}}{\setmathfont{TeX Gyre Termes Math}}%
}
\IfFontExistsTF{Symbol}{\newfontfamily\sau@symbolfont{Symbol}}{\let\sau@symbolfont\relax}

%------------------------------------------------------------------ dil
\RequirePackage[turkish,shorthands=:!]{babel}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{longtable}
\RequirePackage{pdflscape}
\RequirePackage{amsmath}
\RequirePackage{eso-pic}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage[bottom]{footmisc}
\RequirePackage{caption}
\RequirePackage{calc}
\RequirePackage[hidelinks,unicode,bookmarksnumbered]{hyperref}

%------------------------------------------------------------------ Word satir modeli
% Word "Times New Roman 12bp": tek satir = 13.8 pt, 1.5 satir = 20.7 pt,
% ilk taban cizgisi satir kutusunun 11.22 pt altinda (ascent + linegap).
\newdimen\sauLineHeight
\newdimen\sauAscent
\newattribute\sauLineAttr
\newattribute\sauAscAttr
\sauAscent=11.22bp
\newcommand\sau@single{13.8bp}
\newcommand\sau@onehalf{20.7bp}
\ifsau@wordline
  \directlua{sau = require("sauwordline")}
  \newcommand\sau@setline[1]{%
    \sauLineHeight=#1\relax
    \sauLineAttr=\number\dimexpr#1\relax
    \baselineskip=0bp\relax
    \lineskiplimit=\maxdimen\relax
    \lineskip=0bp\relax}
  \newcommand\sauWordLineOn{\directlua{sau.enabled=true}}
  \newcommand\sauWordLineOff{\directlua{sau.enabled=false}}
\else
  \newcommand\sau@setline[1]{\sauLineHeight=#1\relax\baselineskip=#1\relax}
  \newcommand\sauWordLineOn{}
  \newcommand\sauWordLineOff{}
\fi
% tek satir araligi / 1.5 satir araligi (Word: "Tek", "1,5 satir")
\newcommand\teksatir{\sau@setline{\sau@single}}
\newcommand\birbucuksatir{\sau@setline{\sau@onehalf}}
% \fontsize'in ikinci argumani yalnizca \strut kutusunu belirler (0.3x = 2.58 bp derinlik);
% satir araligi \sau@setline ile Word modeline gore verilir.
\newcommand\sau@asc[1]{\sauAscent=#1\relax\sauAscAttr=\number\dimexpr#1\relax}
\renewcommand\normalsize{\fontsize{12bp}{8.6bp}\selectfont\sau@asc{11.22bp}\birbucuksatir}
\renewcommand\small{\fontsize{10bp}{7.17bp}\selectfont\sau@asc{9.35bp}\sau@setline{11.5bp}}
\renewcommand\footnotesize{\fontsize{10bp}{7.17bp}\selectfont\sau@asc{9.35bp}\sau@setline{11.5bp}}
\renewcommand\large{\fontsize{14bp}{10.03bp}\selectfont\sau@asc{13.09bp}\sau@setline{16.1bp}}
\normalsize
\setlength{\topskip}{11.22bp}
\setlength{\parskip}{6bp}            % Word: once 6 nk / sonra 6 nk (cakisan araliklar birlesir)
\setlength{\maxdepth}{30bp}
\renewcommand\footnoterule{\kern-3bp\hrule width 144bp\kern2.6bp}
% Word: dipnot girintisiz, isaretten sonra bir bosluk
\renewcommand\@makefntext[1]{\footnotesize\noindent\@makefnmark\ #1\par}% \@parboxrestore'dan sonra tek satir (kilavuz 3.4)
\setlength{\footnotesep}{11.5bp}
\setlength{\skip\footins}{13.8bp plus 2bp}
\raggedbottom
\widowpenalty=10000 \clubpenalty=10000   % Word: dul/yetim satir denetimi acik
\hyphenpenalty=10000 \exhyphenpenalty=10000
\tolerance=10000 \emergencystretch=3em
\frenchspacing
\AtBeginDocument{\normalsize}

%------------------------------------------------------------------ sayfa numaralari
% Word/kilavuz: sayfa numarasi alt-orta, Times New Roman 12 pt koyu.
\def\ps@plain{%
  \def\@oddhead{}\def\@evenhead{}%
  \def\@oddfoot{\hfil\normalfont\bfseries\thepage\hfil}%
  \let\@evenfoot\@oddfoot}
\def\ps@sauempty{\def\@oddhead{}\def\@evenhead{}\def\@oddfoot{}\def\@evenfoot{}}
% [wordbirebir] Yatay sayfalar: Word'de numara elle konmus dikey metin kutusudur (koyu degil);
% altbilgideki numara beyaz kutuyla ortulur. Konum Word s.44: yatay sayfanin metin blogu
% ortasinda (y=318.9 bp), sol kenardan 64.3 bp (taban cizgisi).
% Yatay sayfalar (kilavuz 3.5: "metnin okuma yonunde sayfanin alt-ortasina", alttan 1,5 cm, koyu):
% sayfa dikey A4 olarak uretilip 90 derece dondurulerek gosterilir; numara, okuma yonundeki alt
% kenarin (dikey sayfanin sag uzun kenari) ortasina, icerikle ayni yonde konur.
\def\sau@yatayno{\AddToShipoutPictureFG*{\setlength\unitlength{1bp}%
  \put(552.76,420.94){\rotatebox{90}{\raisebox{0bp}[0bp][0bp]{\makebox[0bp][c]{\normalfont\bfseries\thepage}}}}}}
\def\ps@sauyatay{\def\@oddhead{}\def\@evenhead{}%
  \def\@oddfoot{\sau@yatayno\hfil}\let\@evenfoot\@oddfoot}
\pagestyle{plain}
% bos arka sayfalar (\cleardoublepage) de numarali (kilavuz 3.5: tum sayfalar aralıksız numaralanir)
\renewcommand\cleardoublepage{\clearpage\if@twoside\ifodd\c@page\else
  \hbox{}\thispagestyle{plain}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%------------------------------------------------------------------ bilgiler
\newcommand\sau@def[2]{\expandafter\newcommand\csname #1\endcsname[1]{\expandafter\def\csname sau@#1\endcsname{##1}}%
  \expandafter\def\csname sau@#1\endcsname{#2}}
\sau@def{tezbasligi}{TEZ BAŞLIĞI BURAYA YAZILIR\\GEREKLİ İSE İKİNCİ VE ÜÇÜNCÜ SATIR KULLANILABİLİR\\ ÜÇ SATIRA SIĞDIRINIZ}
\sau@def{tezbasligitr}{TÜRKÇE TEZ BAŞLIĞI BURAYA YAZILIR}
\sau@def{tezbasligien}{THESIS TITLE IN ENGLISH IS WRITTEN HERE}
\sau@def{tezbasligibeyan}{TEZ BAŞLIĞI YAZILACAK}
\sau@def{teztipi}{YÜKSEK LİSANS/DOKTORA TEZİ}
\sau@def{yazar}{Öğrenci Adı SOYADI}
\sau@def{yazarbeyan}{Öğrencinin Adı Soyadı}
\sau@def{anabilimdali}{\sau@gri{Bir öğe seçin.}}
\sau@def{bilimdali}{\sau@gri{Bir öğe seçin.}}
\sau@def{danisman}{Unvan Ad SOYAD}
\sau@def{ortakdanisman}{Unvan Ad SOYAD}
\sau@def{kapaktarihi}{AY YIL}
\sau@def{kapaktarihiornek}{ \sau@kirmizi{(OCAK 2022)}}
\sau@def{savunmatarihi}{16.06.2022}
\sau@def{tesekkurimza}{Ad Soyad}
\sau@def{onayyazar}{\sau@gri{Metin girmek için burayı tıklatın.}}
\sau@def{onaybaslik}{\sau@gri{Metin girmek için burayı tıklatın.}}
\sau@def{onayteztipi}{\sau@gri{Bir öğe seçin.}}

%------------------------------------------------------------------ mutlak konumlandirma
% \sau@put{x}{y}{l|c|r}{metin}: (x,y) sayfa sol-ust kosesinden pt; y taban cizgisi.
\newcommand\sau@put[4]{%
  \AddToShipoutPictureFG*{\setlength\unitlength{1bp}%
    \put(#1,\fpeval{841.89-#2}){\makebox[0bp][#3]{\normalfont\strut@none #4}}}}
\def\strut@none{}
\newcommand\sau@ogrencino{\sau@gri{Öğrenci Numarası (Örnek: D205001001)}}
\newcommand\ogrencino[1]{\renewcommand\sau@ogrencino{#1}}
\newcommand\sau@kirmizi[1]{\ifsau@notlar\textcolor[HTML]{FF0000}{#1}\else#1\fi}
\newcommand\sau@mavi[1]{\ifsau@notlar\textcolor[HTML]{3366FF}{#1}\else#1\fi}
\newcommand\notrenk[2]{\ifsau@notlar\textcolor[HTML]{#1}{#2}\else#2\fi}  % sablon notlari (notsuz: siyah)
\newcommand\sau@gri[1]{\textcolor[HTML]{808080}{#1}}   % Word icerik denetimi yer tutucusu

%------------------------------------------------------------------ dis kapak / ic kapak
% Dikey konumlar Word ciktisindan olculmustur (satir ust kenari kilavuzdaki 15/16/20/21/23/26 cm).
% Kilavuz 3.8.1.1: dis kapaktaki yazilar kapagin dis kenarina gore ortalanir (x = 595.28/2 = 297.64);
% ic kapak normal sayfadir, yazi bloguna gore ortalanir (x = 318.9). Tez basligi dis kapakta 14 pt,
% ic kapakta 12 pt (3.8.1.2).
\newcommand\sau@kx{318.9}
\newcommand\sau@kapakortak[1]{% #1: 1=dis kapak, 0=ic kapak
  \ifnum#1=1 \def\sau@kx{297.64}\def\sau@kbaslik{\large}\else\def\sau@kx{318.9}\def\sau@kbaslik{}\fi
  \sau@put{\sau@kx}{96.6}{c}{\bfseries T.C.}%
  \sau@put{\sau@kx}{110.4}{c}{\bfseries SAKARYA ÜNİVERSİTESİ}%
  \sau@put{\sau@kx}{124.2}{c}{\bfseries FEN BİLİMLERİ ENSTİTÜSÜ}%
  \sau@put{\sau@kx}{269.2}{c}{\parbox[t]{414bp}{\centering\sau@kbaslik\bfseries \sau@tezbasligi}}%
  \sau@put{\sau@kx}{470.8}{c}{\bfseries \sau@yazar}%
  \sau@put{\sau@kx}{584.3}{c}{\sau@anabilimdali\ \textbf{Anabilim Dalı}}%
}
\newcommand\diskapak{%
  \begingroup
  \thispagestyle{sauempty}%
  \sau@kapakortak{1}%
  \sau@put{297.64}{438.6}{c}{\bfseries \sau@teztipi}%
  \sau@put{297.64}{612.7}{c}{\sau@bilimdali\ \textbf{Bilim Dalı \sau@kirmizi{(Varsa)}}}%
  \sau@put{297.64}{754.4}{c}{\bfseries \sau@kapaktarihi\sau@kapaktarihiornek}%
  \ifsau@notlar
    \AddToShipoutPictureFG*{\setlength\unitlength{1bp}%
      \put(131.84,\fpeval{841.89-569.2}){%
        \fcolorbox{red}{white}{\parbox[b][87.3bp][c]{350.8bp}{\hspace*{12.9bp}\parbox{326bp}{%
          \normalsize\teksatir
          Tez bu şablon kullanılarak yazılabilir. Eğer bu şablon üzerinden tez yazılacak ise
          açıklamaların çıktılarda görünmemesi için çıktı almadan önce
          \textbf{\textbackslash documentclass[notsuz]\{sauthesis\}} seçilmeli daha sonra çıktı alınmalıdır.
          \textcolor[HTML]{FF0000}{\textbf{Bu bir nottur, çıktı almadan önce siliniz.}}}}}}}%
  \fi
  \null\clearpage
  \thispagestyle{sauempty}\null\clearpage   % dis kapak arkasi: numarasiz
  \endgroup}
\newcommand\ickapak{%
  \begingroup
  \thispagestyle{sauempty}%
  \sau@kapakortak{0}%
  \sau@put{318.9}{442.5}{c}{\bfseries \sau@teztipi}%
  \sau@put{318.9}{484.6}{c}{\bfseries \sau@ogrencino}%
  \sau@put{318.9}{612.8}{c}{\sau@bilimdali\ \textbf{Bilim Dalı} \textbf{\sau@kirmizi{(Varsa)}}}%
  \sau@put{318.9}{672.0}{c}{\bfseries Tez Danışmanı: \sau@danisman}%
  \sau@put{318.9}{699.0}{c}{\bfseries \sau@kirmizi{(Varsa)} Ortak Danışman: \sau@ortakdanisman}%
  \sau@put{318.9}{754.4}{c}{\bfseries \sau@kapaktarihi}%
  \null\clearpage
  \thispagestyle{sauempty}\null\clearpage   % ic kapak arkasi (ii): numarasiz
  \endgroup}

%------------------------------------------------------------------ onay (juri) sayfasi
\newcommand\sau@juri[5]{% y, unvan/ad (kalin), ek, kurum, etiket
  \sau@put{113.8}{#1}{l}{\textbf{#5}}%
  \sau@put{220.1}{#1}{l}{#2}%
  \sau@put{432.9}{#1}{l}{..............................}%
  \sau@put{220.1}{\fpeval{#1+13.8}}{l}{#4}}
\newcommand\sau@juriek[3]{% y, ad, kurum (Gerekliyse satiri)
  \sau@put{113.8}{#1}{l}{\textbf{Jüri Üyesi :}}%
  \sau@put{220.1}{#1}{l}{\textbf{#2}}%
  \sau@put{432.9}{#1}{l}{..............................}%
  \sau@put{113.8}{\fpeval{#1+13.8}}{l}{\textbf{\sau@mavi{(Gerekliyse)}}}%
  \sau@put{220.1}{\fpeval{#1+13.8}}{l}{#3}}
\newcommand\onaysayfasi{%
  \cleardoublepage\sau@onkisimgeometri
  \pagenumbering{roman}\setcounter{page}{3}%
  \thispagestyle{plain}%
  \begingroup\teksatir
  \vspace*{\dimexpr 70.8bp-\topskip\relax}%
  \yazar@onaymetni\par
  \endgroup
  \sau@put{318.9}{295.0}{c}{\textbf{Tez Jürisi}}%
  \sau@juri{351.8}{\textbf{Unvan Adı SOYADI}}{}{Sakarya Üniversitesi}{Jüri Başkanı :}%
  \sau@juri{409.3}{\textbf{Unvan Adı SOYADI} \sau@kirmizi{(Danışman)}}{}{Sakarya Üniversitesi}{Jüri Üyesi :}%
  \sau@juri{465.2}{\textbf{Unvan Adı SOYADI} \sau@kirmizi{(Ortak Danışman)}}{}{Sakarya Üniversitesi}{Jüri Üyesi :}%
  \sau@juri{521.8}{\textbf{Unvan Adı SOYADI}}{}{……\ \ \ \ Üniversitesi}{Jüri Üyesi :}%
  \sau@juriek{578.6}{Unvan Adı SOYADI}{……\ \ \ \ Üniversitesi}%
  \sau@juriek{635.3}{Unvan Adı SOYADI}{……\ \ \ \ Üniversitesi}%
  \clearpage}
\newcommand\yazar@onaymetni{%
  \sau@onayyazar\ tarafından hazırlanan “\sau@onaybaslik” adlı tez çalışması \sau@savunmatarihi\
  tarihinde aşağıdaki jüri tarafından oy birliği/oy çokluğu ile Sakarya Üniversitesi Fen
  Bilimleri Enstitüsü \sau@anabilimdali\ \ Anabilim \sau@kirmizi{Dalı} \sau@bilimdali\sau@kirmizi{\ Bilim }Dalı’nda
  \sau@kirmizi{(varsa)} \sau@onayteztipi\ olarak kabul edilmiştir.}

%------------------------------------------------------------------ basliklar
% Birinci derece: once 72 nk, sonra 18 nk, tek satir, koyu, BUYUK harf, "1. " numara,
%   ikinci satir 21.6 pt asili girinti (Word numaralandirma: ind left=432 hanging=432)
% Ikinci derece:  once 18 nk, sonra 12 nk, koyu, "1.1. " (asili 28.8 pt)
% Ucuncu/dorduncu derece: once 12 nk, sonra 6 nk, koyu (asili 36 / 43.2 pt)
% Not: Word ardisik paragraf araliklarini birlestirir (max(sonra,once)); LaTeX'te
%      \parskip (6bp) her paragraf arasinda eklendiginden degerler buna gore ayarlidir.
\renewcommand\thechapter{\arabic{chapter}}
\renewcommand\thesection{\thechapter.\arabic{section}}
\renewcommand\thesubsection{\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection{\thesubsection.\arabic{subsubsection}}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\newcommand\sau@hang[3]{\hangindent=#1\relax\hangafter=1\relax #2 #3}
\newcommand\sau@headline{\teksatir\bfseries\normalfont\bfseries\raggedright\sauWordLineOn}

\titleformat{\chapter}[block]{\teksatir\normalfont\bfseries}{}{0bp}{\sau@hang{21.6bp}{\thechapter.}}
\titleformat{name=\chapter,numberless}[block]{\teksatir\normalfont\bfseries}{}{0bp}{}
\titlespacing*{\chapter}{0bp}{\sau@chapbefore}{\sau@chapafter}
\newcommand\sau@chapbefore{48.8bp}   % sayfa basi: ilk taban cizgisi metin blogunun 77.2 pt altinda
\newcommand\sau@chapafter{12bp}      % 18 nk - 6 nk(parskip)
\titleformat{\section}[block]{\teksatir\normalfont\bfseries}{}{0bp}{\sau@hang{28.8bp}{\thesection.}}
\titlespacing*{\section}{0bp}{12bp}{6bp}
\titleformat{\subsection}[block]{\teksatir\normalfont\bfseries}{}{0bp}{\sau@hang{36bp}{\thesubsection.}}
\titlespacing*{\subsection}{0bp}{6bp}{0bp}
\titleformat{\subsubsection}[block]{\teksatir\normalfont\bfseries}{}{0bp}{\sau@hang{43.2bp}{\thesubsubsection.}}
\titlespacing*{\subsubsection}{0bp}{6bp}{0bp}
% Besinci derece (numarasiz, koyu)
\newcommand\baslikbes[1]{\par\addvspace{0bp}{\teksatir\bfseries #1\par}\nobreak\@afterheading}
% Bolum basliklari daima sag (tek numarali) sayfadan baslar
% Ana metinde numarali bolumlerin (1., 2., 3., ...) ilk sayfasi numarasizdir (sayfa yine sayilir).
% KAYNAKLAR, EKLER, OZGECMIS (\bolumsuz) Word'deki gibi numaralidir.
% \bolumilksayfanosuz bir sonraki \chapter* sayfasini da numarasiz yapar.
\newif\ifsau@ilksayfanosuz
\newcommand\bolumilksayfanosuz{\global\sau@ilksayfanosuztrue}
\newif\ifsau@anametinde
\renewcommand\chapter{\cleardoublepage
  \ifsau@ilksayfanosuz\thispagestyle{sauempty}\global\sau@ilksayfanosuzfalse\else\thispagestyle{plain}\fi
  \global\@topnum\z@\@afterindentfalse
  \@ifstar{\@schapter}{\ifsau@anametinde\thispagestyle{sauempty}\fi\@dblarg\@chapter}}

% Numarasiz birinci derece baslik (KAYNAKLAR, EKLER, OZGECMIS, on kisim basliklari) - icindekilere girer
\newcommand\bolumsuz[1]{\chapter*{#1}\phantomsection\addcontentsline{toc}{chapter}{#1}\markboth{#1}{#1}}

%------------------------------------------------------------------ icindekiler
% Word "T1..T4" stilleri: tek satir, aralik 0; T1 koyu; sag sekme 411 pt'de noktali
% T2 girinti 11.35 pt, T3 24.1 pt, T4 36 pt; numara ile metin arasinda bir bosluk.
\renewcommand\contentsname{İÇİNDEKİLER}
\renewcommand\listtablename{TABLO LİSTESİ}
\renewcommand\listfigurename{ŞEKİL LİSTESİ}
\renewcommand\bibname{KAYNAKLAR}
\renewcommand\figurename{Şekil}
\renewcommand\tablename{Tablo}
\renewcommand\appendixname{EK}
\addto\captionsturkish{\def\contentsname{İÇİNDEKİLER}\def\listtablename{TABLO LİSTESİ}%
  \def\listfigurename{ŞEKİL LİSTESİ}\def\bibname{KAYNAKLAR}\def\figurename{Şekil}\def\tablename{Tablo}%
  \def\appendixname{EK}}
\newcommand\sau@tocdots{\hskip3bp\leaders\hbox to 3bp{\hss.\hss}\hfill\hskip3bp}
\newcommand\sau@tocpage[1]{\nobreak\sau@tocdots\nobreak\hbox{#1}}
\newcommand\sau@tocend[1]{\sau@tocpage{#1}\endgraf}
\contentsmargin{0bp}
\titlecontents{chapter}[0bp]{\teksatir\bfseries\hangindent=63.8bp\hangafter=1}
  {\thecontentslabel.\ }{}{\sau@tocend{\thecontentspage}}
\titlecontents{section}[11.35bp]{\teksatir\normalfont}
  {\thecontentslabel.\ }{}{\sau@tocend{\thecontentspage}}
\titlecontents{subsection}[24.1bp]{\teksatir\normalfont}
  {\thecontentslabel.\ }{}{\sau@tocend{\thecontentspage}}
\titlecontents{subsubsection}[36bp]{\teksatir\normalfont}
  {\thecontentslabel.\ }{}{\sau@tocend{\thecontentspage}}
% "\titlecontents" girintisi sol kenardan olculur; Word'de devam satirlari ayni girintide baslar.
\titlecontents{figure}[0bp]{\teksatir\normalfont\hangindent=51.05bp\hangafter=1}
  {\textbf{Şekil \thecontentslabel.}\ }{}{\sau@tocend{\thecontentspage}}
\titlecontents{table}[0bp]{\teksatir\normalfont\hangindent=51.05bp\hangafter=1}
  {\textbf{Tablo \thecontentslabel.}\ }{}{\sau@tocend{\thecontentspage}}
\setlength{\parskip}{6bp}

\newcommand\sau@sayfa[1]{\par{\teksatir\raggedleft\textbf{\uline{Sayfa}}\par}}
\renewcommand\tableofcontents{%
  \sau@onbaslik{\contentsname}%
  \vspace{6bp}{\teksatir\parskip=0bp\raggedleft\textbf{\uline{Sayfa}}\par\mbox{}\par}%
  {\parskip=0bp\@starttoc{toc}}}
\renewcommand\listoftables{%
  \sau@onbaslik{\listtablename}%
  \vspace{6bp}{\birbucuksatir\parskip=0bp\raggedleft\textbf{\uline{Sayfa}}\par}\vspace{6bp}% kilavuz 4.5: girisler once 6 / sonra 6 nk
  {\parskip=6bp\let\addvspace\@gobble\@starttoc{lot}}}
\renewcommand\listoffigures{%
  \sau@onbaslik{\listfigurename}%
  \vspace{6bp}{\birbucuksatir\parskip=0bp\raggedleft\textbf{\uline{Sayfa}}\par}\vspace{6bp}% kilavuz 4.5: girisler once 6 / sonra 6 nk
  {\parskip=6bp\let\addvspace\@gobble\@starttoc{lof}}}
% On kisim basligi: numarasiz birinci derece baslik + icindekilere giris
\newcommand\sau@onbaslik[1]{\chapter*{#1}\phantomsection\addcontentsline{toc}{chapter}{#1}}

%------------------------------------------------------------------ kisaltmalar / simgeler
% Word "Semboller ve Kisaltmalar" stili: tek satir, 6/6 nk, sekme 70.9 pt (1418 tw)
\newenvironment{kisaltmalar}{\sau@onbaslik{KISALTMALAR}\begingroup\teksatir}{\par\endgroup}
\newenvironment{simgeler}{\sau@onbaslik{SİMGELER}\begingroup\teksatir}{\par\endgroup}
\newcommand\kisaltma[2]{\par\hangindent=70.9bp\hangafter=1\noindent
  \makebox[70.9bp][l]{\textbf{#1}}: #2\par}
\let\simge\kisaltma

%------------------------------------------------------------------ beyanname / ithaf / tesekkur
\newcommand\beyanname{%
  \cleardoublepage\pagenumbering{roman}\setcounter{page}{5}%
  \chapter*{ETİK İLKE VE KURALLARA UYGUNLUK BEYANNAMESİ}% kilavuz 4.4: icindekiler Tesekkur ile baslar
  Sakarya Üniversitesi Fen Bilimleri Enstitüsü Lisansüstü Eğitim-Öğretim Yönetmeliğine ve
  Yükseköğretim Kurumları Bilimsel Araştırma ve Yayın Etiği Yönergesine uygun olarak hazırlamış
  olduğum “\sau@kirmizi{\sau@tezbasligibeyan}” başlıklı tezin bana ait, özgün bir
  çalışma olduğunu; çalışmamın tüm aşamalarında yukarıda belirtilen yönetmelik ve yönergeye uygun
  davrandığımı, tezin içerdiği yenilik ve sonuçları başka bir yerden almadığımı, tezde
  kullandığım eserleri usulüne göre kaynak olarak gösterdiğimi, bu tezi başka bir bilim kuruluna
  akademik amaç ve unvan almak amacıyla vermediğimi ve 20.04.2016 tarihli Resmi Gazete’de
  yayımlanan Lisansüstü Eğitim ve Öğretim Yönetmeliğinin 9/2 ve 22/2 maddeleri gereğince Sakarya
  Üniversitesi’nin abonesi olduğu intihal yazılım programı kullanılarak Enstitü tarafından
  belirlenmiş ölçütlere uygun rapor alındığını, \sau@kirmizi{etik kurul onay belgesi aldığımı
  (etik onayı gerekmiyorsa bu cümle metinden çıkartılır)},
  çalışmamla ilgili yaptığım bu beyana aykırı bir durumun ortaya çıkması halinde doğabilecek her
  türlü hukuki sorumluluğu kabul ettiğimi beyan ederim.\par
  {\raggedleft (……/……/20…..).\par}
  {\raggedleft (imza)\hspace*{35.35bp}\par}
  {\raggedleft \sau@yazarbeyan\par}%
  \clearpage}

\newcommand\ithaf[1]{%
  \cleardoublepage
  \thispagestyle{plain}%
  \vspace*{\dimexpr 350.3bp\relax}%
  {\raggedleft\bfseries\itshape #1\par}%
  \clearpage}

\newenvironment{tesekkur}{%
  \cleardoublepage
  \sau@onbaslik{TEŞEKKÜR}\begingroup\teksatir}{%
  \par\endgroup
  {\birbucuksatir\mbox{}\par\mbox{}\par\mbox{}\par\raggedleft \sau@tesekkurimza\par}\clearpage}

%------------------------------------------------------------------ ozet / summary
% Word: tez basligi (once 72 nk, sonra 18 nk) + "OZET" (ortali) + tek satir aralikli metin
\newcommand\sau@ozetbaslik[2]{%
  \cleardoublepage
  \thispagestyle{plain}%
  \phantomsection\addcontentsline{toc}{chapter}{#2}%
  \vspace*{\dimexpr\sau@chapbefore\relax}%
  {\teksatir\centering\bfseries #1\par}\vspace{12bp}%
  {\teksatir\centering\bfseries #2\par}\vspace{12.1bp}}
\newenvironment{ozet}{\sau@ozetbaslik{\sau@tezbasligitr}{ÖZET}\begingroup\teksatir}{\par\endgroup}
\newenvironment{summary}{\sau@ozetbaslik{\sau@tezbasligien}{SUMMARY}\begingroup\teksatir}{\par\endgroup}

%------------------------------------------------------------------ ana metin baslangici
\newcommand\anametin{%
  \cleardoublepage   % kilavuz 3.5: on kisim aralıksız numaralanir (bos arka sayfa da)
  \sau@anametingeometri\ifsau@wordbirebir\sau@kisaaltbilgibaslat\fi
  \pagenumbering{arabic}\setcounter{page}{1}\global\sau@anametindetrue}
% [wordbirebir] kisa altbilgi bolgesi ilk yatay sayfada biter; yatay sayfalarda Word numarasi
\AddToHook{env/landscape/before}{\ifsau@kisaaltbilgi\clearpage\global\sau@kisaaltbilgifalse\restoregeometry\fi}
\AddToHook{env/landscape/begin}{\clearpage\pagestyle{sauyatay}}

%------------------------------------------------------------------ sekil ve tablolar
% Sekil basligi: seklin altinda, once 6 nk sonra 12 nk, tek satir; tek satira sigarsa ortali,
%   sigmazsa iki yana yasli + asili girinti (Word "Resim Yazisi": hanging 964 tw = 48.2 pt).
% Tablo basligi: tablonun ustunde, once 12 nk sonra 6 nk (Word "Altyazi": hanging 709 tw).
% "Sekil 2.1." ve "Tablo 2.1." koyu; numaradan sonra nokta.
\renewcommand\thefigure{\thechapter.\arabic{figure}}
\renewcommand\thetable{\thechapter.\arabic{table}}
\renewcommand\theequation{\thechapter.\arabic{equation}}
\@addtoreset{figure}{chapter}\@addtoreset{table}{chapter}\@addtoreset{equation}{chapter}
\DeclareCaptionLabelSeparator{sau}{.\hspace{\fontdimen2\font}}% esnemeyen bosluk: 2. satir hizasi tam
\DeclareCaptionFont{sauline}{\teksatir}
\captionsetup{labelsep=sau,labelfont=bf,textfont=sauline,font=sauline,format=hang,
  justification=justified,singlelinecheck=true,skip=0bp,position=below}
\newlength\sau@capw
\DeclareCaptionFormat{sauhang}{\teksatir\settowidth\sau@capw{#1#2}\hangindent=\sau@capw\hangafter=1 #1#2#3\par}
\DeclareCaptionFormat{sauhangt}{\teksatir\settowidth\sau@capw{#1#2}\hangindent=\sau@capw\hangafter=1 #1#2#3\par}
\captionsetup[figure]{indention=0bp,format=sauhang,aboveskip=3.5bp,belowskip=-12.9bp}
\captionsetup[table]{indention=0bp,format=sauhangt,position=above,aboveskip=-0.7bp,belowskip=0bp}
\setlength{\abovecaptionskip}{0bp}
\setlength{\belowcaptionskip}{0bp}
\setlength{\intextsep}{12bp}
\setlength{\floatsep}{0bp}
\setlength{\textfloatsep}{0bp}
% Word'de sekiller metin icinde (satir icinde) durdugundan H yerlesimi kullanilir
\floatplacement{figure}{H}
\floatplacement{table}{H}
\newcommand\devami{\textbf{(Devamı)}:}
% Tablolar (Word: hucre ic kenar boslugu 108 tw = 5.4 bp, cizgi 0.72 bp)
\setlength{\arrayrulewidth}{0.72bp}
\setlength{\doublerulesep}{1.5bp}
\setlength{\tabcolsep}{5.4bp}
\renewcommand\arraystretch{1}
% Hucreler tek satir aralikli yazilir; satir yuksekligi strut ile verilir:
%  \Ns : Word "Normal" stilli hucre (1.5 satir + once/sonra 6 nk) -> satir 32.7 bp
%  \Ts : tek satir aralikli, araliksiz hucre -> satir 19.3 bp
\newcommand\Ns{\rule[-14.9bp]{0bp}{32.7bp}}
\newcommand\Ts{\rule[-5.33bp]{0bp}{19.3bp}}
\newcommand\Tsd{\rule[-7.73bp]{0bp}{24.1bp}}  % Tablo 2.4 (Devami) satirlari
% Word bos paragrafi: [tek] satir araligi + once/sonra 6 nk
\newcommand\bosparagraf[1][13.8bp]{{\sau@setline{#1}\mbox{}\par}}
\newcolumntype{C}[1]{>{\teksatir\centering\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\teksatir\raggedright\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\teksatir\raggedleft\arraybackslash}p{#1}}
% Word: tablo basligi -> ust cizgi 9.0 bp; alt cizgi -> sonraki paragraf 23.6 bp
\AtEndEnvironment{table}{\vspace{-5.9bp}}

%------------------------------------------------------------------ denklemler
% Denklemler 1.5 satir aralikli, once/sonra 6 nk, ortali; numara (3.1) sag kenarda, normal yazi.
\setlength{\abovedisplayskip}{6bp}
\setlength{\belowdisplayskip}{6bp}
\setlength{\abovedisplayshortskip}{6bp}
\setlength{\belowdisplayshortskip}{6bp}
\AtBeginDocument{%
  \setlength{\abovedisplayskip}{6bp}\setlength{\belowdisplayskip}{6bp}%
  \setlength{\abovedisplayshortskip}{6bp}\setlength{\belowdisplayshortskip}{6bp}}
\renewcommand\tagform@[1]{\maketag@@@{\normalfont(\ignorespaces#1\unskip\@@italiccorr)}}

%------------------------------------------------------------------ uzun alinti
% Kilavuz: 40 kelimeden uzun alintilar 2 punto kucuk (10 pt); Word: sol girinti 36 bp, 1.5 satir (17.25 bp)
\newenvironment{alinti}{\par\begingroup\fontsize{10bp}{7.17bp}\selectfont\sau@asc{9.35bp}%
  \sau@setline{17.25bp}\leftskip=36bp\relax}{\par\endgroup}

%------------------------------------------------------------------ denklem (Word denklem tablosu karsiligi)
% Word: onceki metin -> denklem taban cizgisi 38.8 bp, denklem -> denklem 44.6 bp,
% denklem -> sonraki metin 38.7 bp. Denklem ortali, numara (3.1) sag kenarda, normal yazi.
\newcommand\sau@denklemsonu{6.2bp}
\newenvironment{denklem}{\par
  \ifdim\lastskip=\sau@denklemsonu\vskip-\sau@denklemsonu\relax\fi
  \vskip6bp\relax
  \refstepcounter{equation}%
  \setbox\z@\hbox\bgroup\rule[-9.28bp]{0bp}{32.6bp}$\displaystyle}{$\egroup
  \noindent\hbox to\linewidth{\hfil\box\z@\hfil\llap{\normalfont(\theequation)}}\par
  \vskip6bp\relax\vskip\sau@denklemsonu\relax}
% \noindent\hbox ... \par paragraf olusturur; parskip etkisini nötrlemek icin:
\AtBeginEnvironment{denklem}{\parskip=0bp\relax}

%------------------------------------------------------------------ numarali kaynak listesi
% Word: [1] bicimi, tek satir, metin girintisi 1037 tw (51.85 bp), asili 680 tw
\newenvironment{kaynaklistesi}{\begin{enumerate}[label={[\arabic*]},leftmargin=51.85bp,
  labelwidth=34bp,labelsep=0bp,align=left,itemsep=13.8bp,topsep=6bp]\teksatir}{\end{enumerate}}

%------------------------------------------------------------------ kaynaklar
% Word "KAYNAKLAR" stili: tek satir, 6/6 nk, asili girinti 1.25 cm (709 tw)
\newenvironment{kaynaklar}{\bolumsuz{KAYNAKLAR}\begingroup\teksatir}{\par\endgroup}
\newcommand\kaynak[1]{\par{\teksatir\hangindent=35.45bp\hangafter=1\noindent #1\par}}
\newcommand\kaynakgrubu[1]{\par{\noindent\textbf{#1}\par}}

%------------------------------------------------------------------ ekler
\newcommand\ekler{%
  \bolumsuz{EKLER}\setcounter{chapter}{0}\teksatir   % kilavuz 3.4: ekler 1 satir aralikli
  \renewcommand\thefigure{\Alph{chapter}.\arabic{figure}}%
  \renewcommand\thetable{\Alph{chapter}.\arabic{table}}%
  \renewcommand\theequation{\Alph{chapter}.\arabic{equation}}}
\newcommand\ek[1]{\par\stepcounter{chapter}\setcounter{figure}{0}\setcounter{table}{0}\setcounter{equation}{0}%
  {\noindent\textbf{EK \Alph{chapter}. #1}\par}}   % kilavuz 4.10: "Ek A. Ekin adı"

%------------------------------------------------------------------ ozgecmis
\newenvironment{ozgecmis}{\bolumsuz{ÖZGEÇMİŞ}\begingroup\teksatir}{\par\endgroup}

%------------------------------------------------------------------ listeler
\RequirePackage{enumitem}
\setlist{nosep,topsep=6bp,itemsep=6bp,parsep=0bp}
\setlist[itemize]{label=\textbullet,leftmargin=18bp}

%------------------------------------------------------------------ yardimci
\newcommand\sablonnotu[1]{\ifsau@notlar\textcolor{red}{#1}\fi}
\newcommand\renklimavi[1]{\textcolor[HTML]{0070C0}{#1}}
\endinput
