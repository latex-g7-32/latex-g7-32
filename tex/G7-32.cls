% This package designed and commented in russian utf-8 encoding.
%
% Класс документов по ГОСТ 7.32-2001 "Отчёт о научно-исследовательской работе"
% на основе ГОСТ 2.105-95
% Автор - Алексей Томин, с помощью списка рассылки latex-gost-request@ice.ru,
%  "extreport.cls", "lastpage.sty" и конференции RU.TEX
% Лицензия GPL
% Все вопросы, замечания и пожелания сюда: mailto:alxt@yandex.ru
% Дальнейшая разработка и поддержка - Михаил Конник,
% связаться можно по адресу mydebianblog@gmail.com

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
\ProvidesClass{G7-32}[2003/07/01 v1.0 Non Standard LaTeX document class]

\RequirePackage{G2-105}
\RequirePackage[left=20mm,right=10mm,top=20mm,bottom=20mm,headsep=0pt]{geometry}
\RequirePackage{G7-32}

\endinput
% End of file `G7-32.cls'.
