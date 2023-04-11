# G7-32

Стиль $\LaTeX$ для оформления отчетов о НИР, расчетно-пояснительных записок к курсовым и дипломным работам в соответствии с ГОСТ 7.32-2017.

## Опции класса документа

### XeLaTeX

1. `astra` (по умолчанию) — свободные шрифты Astra Sans, Astra Serif, Liberation Mono.
2. `times` — шрифты Times New Roman, Arial, Courier New.
3. `cm` — шрифты CMU, которые обычно включены в TeX Live.

### PdfLaTeX

1. `times` (по умолчанию) — шрифты из пакета cyrtimes: Nimbus Roman и Nimbus Sans.
2. `pscyr` — шрифты из пакета pscyr: Antiqua PSCyr, Textbook PSCyr, ERKurier PSCyr.
3. `cm` — шрифты CM, которые обычно включены в TeX Live.

Если какой-то шрифт не найден, то вместо него будет использоваться соответствующий шрифт CM.

Эти опции нужно задавать в `\documentclass`, например так: 

```latex
\documentclass[utf8x, times, 14pt]{G7-32}
```
