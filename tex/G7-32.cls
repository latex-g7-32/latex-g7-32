% This package designed and commented in Russian (utf-8 encoding).
%
% Класс документов по ГОСТ 7.32-2001 "Отчёт о научно-исследовательской работе"
% на основе ГОСТ 2.105-95
% Автор - Алексей Томин, с помощью списка рассылки latex-gost-request@ice.ru,
%  "extreport.cls", "lastpage.sty" и конференции RU.TEX
% Лицензия GPL
% Все вопросы, замечания и пожелания сюда: mailto:alxt@yandex.ru
% Дальнейшая разработка и поддержка - Михаил Конник,
% связаться можно по адресу mydebianblog@gmail.com
%
% Further tweaks and development (according to the requirements of
% ГОСТ 7.32-2001 ред. 2009 года.pdf and some other random wishes)
% -- Ivan Zakharyaschev <imz@altlinux.org>.

% Параметры:
%  a4paper, a5paper - размер бумаги. По-умолчанию- a4paper.
%  econom - одинарный интервал. По-умолчанию нет.
%  10pt, 12pt, 14pt - шрифт. По-умолчанию- 14pt
%  draft, final - как обычно. По-умолчанию- final
%  usehyperref - в DVI/PDF все ссылки будут активны. По-умолчанию нет.
%  usepscyr    - использовать шрифтовой пакет PsCyr. По-умолчанию нет.
%  cp866,koi8-r,cp1251 - кодировка текста. По-умолчанию koi8-r.

% В дополнение к стандартным типам заголовков \subsection{} и \subsubsection{}
% есть \nsubsection и \nsubsubsection (именно без параметров),
% которые ставят номер, делают отступ, но не заносятся в оглавление -
% пункты и подпункты без заголовков, в терминах ГОСТ

% Уже подключены пакеты:
% hyperref    - перекрёстные ссылки активны, с параметром unicode (если usehyperref)
% mathtext    - для русских букв в формулах
% fontenc     - кодировка шрифтов - T2A
% inputenc    - входная кодировка - задаётся параметром
% babel       - настройки языков - русский и английский
% geometry    - устанавливает размер полей
% fancyhdr    - устанавливает колонтитулы
% indentfirst - начинать абзацы с красной строки
% footmisc    - установливает сноски всегда внизу страницы
% caption2    - настройка вида заголовков таблиц и рисунков
% amssymb     - для русских "меньше или равно" "больше или равно"
% Используются группа пакетов extsizes.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{G7-32}[2015/11/01 v2.0 Non Standard LaTeX document class]

\RequirePackage{G2-105}
% minimal values from ГОСТ 7.32-2001 ред. 2009 года.pdf item 6.1.2
% (a4paper is already selected as the default by GostBase.clo)
\RequirePackage[right=10mm,top=20mm,bottom=20mm,left=30mm,headsep=0pt,includefoot]{geometry}
% includefoot or includeall should be used-- 
% It's not very clear whether the standard allows to put the page
% numbers (and other stuff) on the bottom margin, but it's probably safer not to do so
% (so that the minimal bottom margin size is not violated in any
% case).
% 
% TODO: drop any stuff in the head that occupies space and use includeall.

\RequirePackage{G7-32}


\gosttitle{Gost7-32}% use GOST7.32-2001 title by default

\endinput
% End of file `G7-32.cls'.
