Стиль LaTeX для оформления отчетов о НИР, расчётно-пояснительной записки к курсовым и дипломным работам (ГОСТ 7.32-2001 и ГОСТ РВ 15.110-2003)
===========

Ориентирован на студентов IT специальностей, научных работников и др. кому необходимо составлять документы по ГОСТ 7.32-2001 или ГОСТ РВ 15.110-2003.

Изначально был написан в расчёте на `pdfLaTeX`, с коммита `23b1612` добавлена поддержка `XeLaTeX`. Помимо стилей содержит "рыбу" РПЗ (в той же папке `tex`). 

Также имеются необходимые макеты (layout) для [LyX](http://ru.wikipedia.org/wiki/LyX) (редактор, редактирование в котором больше похоже на работу в `Microsoft Word`, чем на написание `LaTeX` кода, но результат получается такой же хороший, как в `LaTeX`). Для использования `LyX` также нужно скопировать стили LaTeX (из папки `tex`).

## Результат
См. вкладку [Релизы](https://github.com/rominf/latex-g7-32/releases).

### Попробовать online
Спасибо [@KMax](https://github.com/rominf/latex-g7-32/issues/11), теперь [можно попробовать](https://www.sharelatex.com/project/54885f204b9308be064f025e) шаблон в ShareLaTeX.

## Участие в проекте

Стиль распространяется "как есть". В случае обнаружения несостыковок с ГОСТом, обнаружении багов, а также если есть вопросы по использованию, не отражённые в документации, заводите, пожалуйста, issue. Pull requests принимаются.

## Установка

Скачать последнюю версию.

C помощью git:
```
git clone https://github.com/latex-g7-32/latex-g7-32
```
Или скачать zip:
```
https://github.com/latex-g7-32/latex-g7-32/archive/master.zip:
```

Или взять из [релизов](https://github.com/rominf/latex-g7-32/releases).
Однако, релизы формируются с течением времени и могут содержать существенно устаревшую версию.

Скопировать файлы: 
`G2-105.sty  G7-32.cls  G7-32.sty  GostBase.clo  gosttitleGostRV15-110mipt.sty  gosttitleGostRV15-110.sty  local-minted.sty` в локальный texmf.
Для линукс это будет `$HOME/texmf/`.
Для Виндовс `C:\Users\USERNAME\texmf\`.
Проверить это можно командой `kpsewhich -var-value=TEXMFHOME`.
Относительно texmf путь будет `texmf/tex/latex/latex-g7-32/`.


### Зависимости

#### Основные для стилевого файла

##### LaTeX пакеты
```
amssymb amsmath caption flafter footmisc hyperref icomma iftex graphicx longtable underscore etoolbox lastpage titlesec flafter amssymb amsmath color mfirstuc nomencl 
```
###### openSUSE
```
texlive-latex texlive-iftex 
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
inkscape dia graphviz python pygments
```

#### LyX
```
lyx
```

#### Установочный скрипт
```
python3.4
```
На текущий момент не работает см. [#26](https://github.com/rominf/latex-g7-32/issues/11).

Копирует (или перемещает) файлы со стилями в общую `texmf` папку, макеты `LyX` в папку с настройками `LyX`. Для получения помощи вызовите `install.py --help`.

## Использование РПЗ
После изменения РПЗ создайте директорию build в корне проекта, затем `cd ./build & cmake .. && make`. В ней появится файл РПЗ - rpz.pdf. Cmake по умолчанию собирает с xelatex.

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
7. [babun](http://babun.github.io/) — не обязательно.
8. [cmake](https://cmake.org/download/) — не обязательно при использовании 
   `babun`, обязательно при работе без него. В случае с `babun` нужно 
   использовать `pact install cmake`, а не самостоятельную установку из 
   установщика на сайте. В любом случае необходимо либо иметь babun+make, либо 
   babun+cmake, либо cmake.

   Внимание: CMake не собирает ничего сам, он генерирует скрипты для make (и 
   ряда других программ), только он умеет использовать разные диалекты: nmake 
   (из Visual Studio), mingw32-make, MSYS make, … Поэтому что‐то из этого нужно 
   также установить. На данный момент сборка проверялась для `babun+cmake`, 
   `babun+make` и просто нативного `cmake`. В последнем случае использовалась 
   утилита `make` из пакета WinAVR, идентифицирующаяся как GNU make.
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

Нативный CMake:

1. Откройте `cmd.exe`.
2. Войдите в каталог с проектом с помощью:

   1. `D:`, где `D:` — буква диска, на котором лежит проект. Данная часть 
      предназначена для переключения текущего диска: в `cmd.exe` у каждого диска 
      свой текущий каталог, текущий каталог `cmd.exe` является текущим каталогом 
      текущего диска.

      Под `D:` здесь понимается буквально: “введите команду `D:` и нажмите 
      ввод”.
   2. `cd D:\path\to\latex-g7-32`.

3. Создайте каталог `build`: `mkdir build`.
4. Войдите в него: `cd build`.
5. Запустите `cmake ..`. Т.к. в отличие от \*nix систем (cygwin (babun) можно 
   считать относящимся к таковым в определённой степени) на Windows нет 
   «стандартного make», то вполне возможно, что просто `cmake ..` сделает не то, 
   что нужно. Для GNU make из WinAVR, использовавшегося автором нужно было 
   использовать команду `cmake .. -G "Unix Makefiles"`. Список возможных 
   генераторов можно получить либо [на сайте CMake][cgens], либо указав `cmake` 
   заведомо несуществующий генератор: к примеру, `cmake -G 
   xxx_nonexistent_generator_xxx` (внимание, поведение может измениться в новой 
   версии CMake). На сайте информация предоставлена более подробно.
6. Запустите `make`. В зависимости от того, какой генератор есть у вас в системе 
   вместо `make` может оказаться `nmake` (распространяется с Visual Studio, 
   соответствует `cmake .. -G "NMake Makefiles"`) или `mingw32-make` 
   (распространяется с компилятором mingw32, соответствует `cmake .. -G "MinGW 
   Makefiles"`).

   PDF файл появится в текущем каталоге (т.е. `D:\path\to\latex-g7-32\build`) 
   под названием `rpz.pdf`.

[cgens]: https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html

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

## Шрифты

По умолчанию используются шрифт СMU для pdfLaTeX и XeLaTeX, но можно использовать свободный аналог Times New Roman - PT Astra, они находятся в репозитории в каталоге fonts. При установке в системе будут использоваться они.
На линуксе устанавливаются в `$HOME/.fonts/` затем выполнить команды `fc-cache -f -v` и `luaotfload-tool -u -f`.

Если у вас подписан лицензионный договор с правообладателем шрифта Times New Roman – компанией Monotype Imaging Inc, то возможно использовать его указав опцию `times`.


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

### 6a. Сборка под при помощи Сmake, Windows+cygwin, CMakeLists.txt, а также сборка с docker
[Николай Павлов](https://github.com/ZyX-I)
### 6b. Сборка при помощи [latexmkmod](https://github.com/dvarubla/latexmkmod), Windows+Linux,
[dvarubla](https://github.com/dvarubla)


## Благодарности
[Ростислав Листеренко](https://github.com/kaedvann) (сообщения об ошибках)

Стиль разрабатывается при поддержке ["Дизайн-центр МФТИ"](http://miptdesigncenter.tilda.ws), [НТКТеХЛАБ](http://ntktechlab.org). 

## См. также
### Статьи
[Записки дебианщика](http://mydebianblog.blogspot.nl/2008/11/latex.html)

### Репозитории
[@qrilka: порт второй версии на `XeLaTeX`](https://github.com/qrilka/G7-32)

[@petethepig: порт урезанной третьей версии ("под себя") на `XeLaTeX`](https://github.com/petethepig/diploma)

### Классы LaTeX для написания диссертаций
[Russian-Phd-LaTeX-Dissertation-Template](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template)

[Класс для диссертаций disser](https://github.com/polariton/disser)
