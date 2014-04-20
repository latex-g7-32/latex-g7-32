latex-g7-32
===========

Стиль LaTeX для расчётно-пояснительной записки к курсовым и дипломным работам (ГОСТ 7.32-2001). Ориентирован на студентов IT специальностей.

Изначально был написан в расчёте на `pdfLaTeX`, с коммита `23b1612` добавлена поддержка `XeLaTeX`. Если требуется использование `pdfLaTeX` то в `Makefile` надо поменять в третье строке `xelatex` на `pdflatex`.

## Результат
См. вкладку [Релизы](https://github.com/rominf/latex-g7-32/releases).

## Установка

### Зависимости

#### Основные

##### LaTeX пакеты
```
amssymb amsmath caption flafter footmisc hyperref icomma iftex graphicx longtable underscore 
```

##### Программы
```
inkscape dia pgf context 
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
minted polyglossia xecyr
```
##### Программы
```
python pygments
```

## Использование
После изменения РПЗ запустите `make` в корне. Результатом будет `rpz.pdf`.

### Редактор
Можно исползьзовать любой редактор, например, `Kile`. На комманду `cd .. && make` вешается горячая клавиша и создаётся проект с корректным главным докукментом.

## Авторы

### 1. Первая версия
Алексей Томин

### 2. Доработка "дебианщика"
[Михаил Конник](http://mydebianblog.blogspot.ru/2008/09/732-2001-latex.html)

### 3. Доработка кафедры [ИУ7](http://iu7.bmstu.ru): Makefile, рисунки (обрезка, конвертация dia, dot (графы), svg), листинги, дальнейшая ГОСТификация
|[Всеволод Крищенко](http://sevik.ru/latex/)|
-------------------

[Иван Коротков](https://github.com/tw33dl3dee)

### 4. GitHub, поддержка XeLaTeX
[Роман Инфлянскас](https://github.com/rominf)

## TODO
1. Поддержка `LyX`.
2. Добавление на CTAN?

## См. также
### Статьи
[Записки дебианщика](http://mydebianblog.blogspot.nl/2008/11/latex.html)

### Репозитории
[@qrilka: порт второй версии на `XeLaTeX`](https://github.com/qrilka/G7-32)

[@petethepig: порт урезанной третьей версии ("под себя") на `XeLaTeX`](https://github.com/petethepig/diploma)
