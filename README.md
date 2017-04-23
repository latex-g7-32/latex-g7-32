Стиль LaTeX для расчётно-пояснительной записки к курсовым и дипломным работам (ГОСТ 7.32-2001)
===========

Ориентирован на студентов IT специальностей.

Изначально был написан в расчёте на `pdfLaTeX`, с коммита `23b1612` добавлена поддержка `XeLaTeX`. Помимо стилей содержит "рыбу" РПЗ (в той же папке `tex`). Его можно собрать используя make.

Также имеются необходимые макеты (layout) для [LyX](http://ru.wikipedia.org/wiki/LyX) (редактор, редактирование в котором больше похоже на работу в `Microsoft Word`, чем на написание `LaTeX` кода, но результат получается такой же хороший, как в `LaTeX`). Для использования `LyX` также нужно скопировать стили LaTeX (из папки `tex`).

## Результат
См. вкладку [Релизы](https://github.com/rominf/latex-g7-32/releases).

### Попробовать online
Спасибо [@KMax](https://github.com/rominf/latex-g7-32/issues/11), теперь [можно попробовать](https://www.sharelatex.com/project/54885f204b9308be064f025e) шаблон в ShareLaTeX.

## Участие в проекте

Стиль распространяется "как есть". В случае обнаружения несостыковок с ГОСТом, обнаружении багов, а также если есть вопросы по использованию, не отражённые в документации, заводите, пожалуйста, issue. Pull requests принимаются.

## Установка

### Зависимости

#### Основные

##### LaTeX пакеты
```
amssymb amsmath caption flafter footmisc hyperref icomma iftex graphicx longtable underscore
```
###### openSUSE
```
texlive-latex texlive-iftex 
```

##### Программы
```
inkscape dia graphviz context
```

#### pdfLaTeX-версия
##### LaTeX пакеты
```
cmap babel mathtext pscyr ucs
```

Для придания таймовского вида нужно установить соотв. шрифты (пакет `cyrtimes.sty`), в Debian/Ubuntu это пакет `scalable-cyrfonts-tex`. Если этого пакета нет, оно использует стандартную гарнитуру CM.

#### XeLaTeX-версия
##### LaTeX пакеты
```
cm-unicode-fonts minted polyglossia xecyr
```

###### openSUSE
```
cm-unicode-fonts texlive-minted texlive-polyglossia texlive-xecyr
```

##### Программы
```
python pygments
```

#### LyX
```
lyx
```

#### Установочный скрипт
```
python3.4
```

Копирует (или перемещает) файлы со стилями в общую `texmf` папку, макеты `LyX` в папку с настройками `LyX`. Для получения помощи вызовите `install.py --help`.

## Использование LaTeX
После изменения РПЗ запустите `make` в корне. Результатом будет `rpz.pdf`. Если требуется использование `pdfLaTeX` то в `Makefile` надо поменять в третье строке `xelatex` на `pdflatex`.

### Редактор
Можно использовать любой редактор, например, `Kile`. На комманду `cd .. && make` вешается горячая клавиша и создаётся проект с корректным главным документом.

## Установка и использование под Windows

Для работы в Windows необходимо установить следующие зависимости:

1. [dwimperl](http://dwimperl.com/windows.html)
2. [texlive](https://www.tug.org/texlive/windows.html)
3. [inkscape](https://inkscape.org/ru/download/)
4. [dia](http://dia-installer.de/)
5. [graphviz](http://www.graphviz.org/Download_windows.php)
6. [ghostscript](https://ghostscript.com/download/gsdnld.html)
7. [babun](http://babun.github.io/) — не обязательно, но автор этой части README 
   использовал его.
8. [cmake](https://cmake.org/download/) — не обязательно, при использовании 
   `babun` нужно использовать `pact install cmake`, а не самостоятельную 
   установку. В любом случае необходимо либо иметь babun+make, либо babun+cmake, 
   либо cmake, либо пытаться заморочиться с make из gnuwin32 или MSYS. Автор 
   этой части README использовал babun+cmake и проверял также babun+make.

   В любом случае CMake генерирует скрипты для make, только он умеет 
   использовать разные диалекты: nmake (из Visual Studio), mingw32-make, MSYS 
   make, … Поэтому что‐то из этого нужно также установить.
9. [python](https://www.python.org/downloads/windows/) — при использовании babun 
   не нужно, он уже установлен там.

   После установки python установить его пакет pygments.

После установки всех зависимостей необходимо добавить их в $PATH. Установщики 
некоторых (texlive, cmake и dwimperl) делают это сами (но, возможно, требуется 
установка галочки), для остальных нужно редактировать реестр, либо изменять PATH 
временно. В PATH помещаются каталоги, в которых находятся следующие файлы: 
`inkscape.exe`, `dia.exe`, `dot.exe`, `python.exe`.

Ghostscript предоставляет файлы gswin32.exe и gswin32c.exe, однако для работы 
нужно иметь файл gs.exe или gs.bat где‐то в $PATH. В случае с bat файл должен 
выглядеть так:

```bat
@echo off
P:\ath\to\ghostscript\gswin32c.exe %*
```

(ВНИМАНИЕ: именно `gswin32c.exe`, не `gswin32.exe`.) Можно просто скопировать 
`gswin32c.exe` в `gs.exe` и добавить каталог с ними в `$PATH`.

В случае использования python из babun вам дополнительно нужен в `$PATH` 
`pygmentize.bat` следующего содержания:

```bat
@echo off
C:\Users\{user}\.babun\cygwin\bin\python2.7.exe C:\Users\{user}\.babun\cygwin\bin\pygmentize %*
```

(замените `{user}` на своего пользователя). Что нужно в случае использования 
python без babun я не знаю, но исполняемый файл pygmentize должен быть 
в `$PATH`.

После того, как `$PATH` станет содержать пути ко всем необходимым исполняемым 
файлам можно будет использовать выбранную систему сборки для создания PDF‐файла. 
В случае с babun+[c]make:

1. Откройте babun.
2. Войдите в каталог с проектом с помощью `cd /path/to/latex-g7-32`.
3. При использовании cmake:

   1. Создайте каталог build: `mkdir build`.
   2. Войдите в него: `cd build`.
   3. Соберите проект: `cmake .. && make`. PDF появится 
      в `/path/to/latex-g7-32/build/rpz.pdf` (он же rpz.pdf в текущем каталоге).
   4. При изменении tex файлов и картинок/диаграмм/… можно собирать просто 
      с помощью `make`.
   5. При *добавлении* файлов/картинок/диаграмм нужно опять использовать `cmake 
      ..` перед `make`.
   6. Для очистки от сгенерированных файлов можно просто удалить каталог 
      `build`.

   При использовании `make`:

   1. Проект (пере)собирается просто `make`. PDF появится 
      в `/path/to/latex-g7-32/rpz.pdf`.
   2. Для очистки от сгенерированных файлов можно использовать `make clean`. 
      Проверяйте их наличие с помощью `git status --ignored`, временные файлы не 
      сконцентрированы в одном каталоге в этом случае.

CMake без babun должно быть можно использовать так же если вы успешно решите 
проблему с pygmentize, только вместо команды `make` будет что‐то другое, 
а CMake, возможно, придётся указать генератор: к примеру, `cmake -G 'MinGW 
Makefiles' ..`, затем `mingw32-make`.

## Сборка с использованием Docker

После установки и настройки docker (обратитесь к документации вашего 
дистрибутиве) создайте образ:

```Shell
cd /path/to/latex-g7-32
cd docker
docker build -t somename .
```

Все необходимые зависимости будут установлены внутри образа.

Затем сборку можно будет осуществлять следующим образом:

```Shell
rm -f /path/to/latex-g7-32/results
docker run --volume /path/to/latex-g7-32/:/doc/ somename
```

Созданные файлы появятся в каталоге `/path/to/latex-g7-32/results`, его 
необходимо удалять перед пересборкой. При сборке этим методом шаблон собирается 
четырьмя способами: (make, cmake) × (pdflatex, xelatex), если вам достаточно 
какого‐то одного, то можно изменить `docker/build.sh`.

## Использование LyX
Откройте `lyx/rpz.lyx` и редактируйте.

В первый раз необходимо настроить параметры вызова XeLaTeX, для того, чтобы `minted` работал.

Настроки -> Обработка файлов -> Конверторы -> LaTeX (XeTeX) -> PDF (XeTeX) -> Изменить -> Преобразователь: `xelatex -shell-escape $$i`.

## Авторы

### 1. Первая версия
Алексей Томин

### 2. Доработка "дебианщика"
[Михаил Конник](http://mydebianblog.blogspot.ru/2008/09/732-2001-latex.html)

### 3a. Доработка кафедры [ИУ7](http://iu7.bmstu.ru)
|[Всеволод Крищенко](http://web.archive.org/web/20100424031801/http://sevik.ru/latex/)|
-------------------

[Иван Коротков](https://github.com/tw33dl3dee)

#### Changelog
```
1. Заработали cases и tabular;
2. Добавлена опция utf8;
3. Комментарии в UTF-8;
4. Изменены отступы после тире в description;
5. Добавлен \paragraph;
6. Уменьшены отспупы после заголовков и учеличены --- до (хотя это, возможно, и нарушает 7-32);
7. Сделаны отсупы в оглалвнеии (ГОСТ эту тему обходит, как мы поняли);
8. \normalfont;
9. Добавлен раздел "Приложения".
9. Makefile для автоматизации рутины;
10. Рисунки (обрезка, конвертация dia, dot, svg);
11. Стили для листингов;
12. Разные мелочи.
```

### 3b. Добавление layouts LyX
[Расим (Brotherofken)](http://habrahabr.ru/post/116517/)


### 4. GitHub, поддержка XeLaTeX, LyX
[Роман Инфлянскас](https://github.com/rominf)

### 5. Further fixes, tweaks and development

According to the requirements of
ГОСТ 7.32-2001 ред. 2009 года.pdf and some other random wishes.
-- Ivan Zakharyaschev <imz@altlinux.org>.

(Read the git log... I tried to explain each change clearly.)

### 6. Сборка под Windows+cygwin, CMakeLists.txt, а также сборка с docker
[Николай Павлов](https://github.com/ZyX-I)


#### Благодарности
[Ростислав Листеренко](https://github.com/kaedvann) (сообщения об ошибках)


## См. также
### Статьи
[Записки дебианщика](http://mydebianblog.blogspot.nl/2008/11/latex.html)

### Репозитории
[@qrilka: порт второй версии на `XeLaTeX`](https://github.com/qrilka/G7-32)

[@petethepig: порт урезанной третьей версии ("под себя") на `XeLaTeX`](https://github.com/petethepig/diploma)
