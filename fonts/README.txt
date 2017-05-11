Установка шрифтов для ОС Linux:

1. Скопировать шрифты из каталога fonts в /home/user/.local/share/fonts или /home/user/.fonts в зависимости от дистрибутива
2. $ fc-cache -f -v
3. $ luaotfload-tool -u -f

Команды 2 и 3 выполняются с правами пользователя.
