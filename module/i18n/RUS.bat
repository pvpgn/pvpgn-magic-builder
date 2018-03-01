@echo off
:: -----------------------------------------------
:: Language:    Russian
:: Author:      HarpyWar (harpywar@gmail.com)
:: -----------------------------------------------
:: Code Page:   866
:: Encoding:    OEM 866


set PHRASE_0_0=^^!^^!^^! ВНИМАНИЕ ^^!^^!^^!
set PHRASE_0_1=Magic Builder должен размещаться по пути без пробелов, русских символов и специальных символов (_.- разрешены).
set PHRASE_0_2=Например: %2

set PHRASE_1_0=  Visual Studio не установлена
set PHRASE_1_1=Выберите версию Visual Studio для компиляции PvPGN:
set PHRASE_1_2=%2 выбрана в качестве компилятора
set PHRASE_1_3=Скачать/заменить последние исходники PvPGN из Git (в папку %2)?
set PHRASE_1_3_1=Выберите ветку для загрузки исходников из GitHub:
set PHRASE_1_4=   PvPGN будет обновлен из Git ветки %2
set PHRASE_1_5=   PvPGN не будет обновлен
set PHRASE_1_6=Выберите интерфейс для PvPGN: 
set PHRASE_1_7=   1) Консольный (по-умолчанию)
set PHRASE_1_8=   2) Оконный
set PHRASE_1_9=Введите номер
set PHRASE_1_10=   Для PvPGN выбран консольный интерфейс
set PHRASE_1_11=   Для PvPGN выбран оконный интерфейс
set PHRASE_1_12=Выберите тип базы данных: 
set PHRASE_1_13=   1) Текстовые файлы / CDB (по-умолчанию)
set PHRASE_1_14=
set PHRASE_1_15=   PvPGN будет собран без поддержки базы данных
set PHRASE_1_16=При конфигурации CMake возникли ошибки

set PHRASE_2_1=Доступные версии %2 (можно добавить свою в %3):
set PHRASE_2_2=   Введите номер
set PHRASE_2_3=   Неправильный номер... попробуйте ещё раз
set PHRASE_2_4=   PvPGN будет скомпилирован с поддержкой %2 v%3
set PHRASE_2_5=Изменить сейчас настройки для %2 (bnetd.conf ^> storage_path)?
set PHRASE_2_6=    Адрес сервера (хост)
set PHRASE_2_7=    Пользователь
set PHRASE_2_8=    Пароль
set PHRASE_2_9=    Название базы данных
set PHRASE_2_10=    Префикс для таблиц (по-умолчанию %2):
set PHRASE_2_11=Конфигурация %2 сохранена в %2.conf.bat

set PHRASE_3_1=Проверка обновлений ...
set PHRASE_3_2="v%2" ваша версия
set PHRASE_3_3="v%2" последняя версия
set PHRASE_3_4= У вас последний PvPGN Magic Builder
set PHRASE_3_5=Версия PvPGN Magic Builder на сервере не совпадает с вашей. Хотите автоматически обновиться до последней версии?
set PHRASE_3_6= Обновление отменено пользователем
set PHRASE_3_6_1= Нет соединения с сервером обновлений
set PHRASE_3_7=Начинаю обновление ...
set PHRASE_3_8= Загрузка файла %2 ...
set PHRASE_3_9=Обновление завершено
set PHRASE_3_10=Информацию об изменениях можно посмотреть в файле %2

set PHRASE_4_1=Включить поддержку Lua скриптов?
set PHRASE_4_2=   PvPGN будет скомпилирован с Lua
set PHRASE_4_3=   PvPGN будет скомпилирован без Lua

set PHRASE_9_1=Выберите версию D2GS:
set PHRASE_9_2=Установите пароль админа для Telnet соединения (работает на порту 8888), будет сохранен в d2gs.reg
set PHRASE_9_3=Хеш пароля будет сохранен в файле %2
set PHRASE_9_4=Вы хотите загрузить MPQ файлы, необходимые для работы сервера? (размер 1ГБ)
set PHRASE_9_9=^^!^^!^^! Для завершения установки D2GS измените d2gs.reg и запустите install.bat ^^!^^!^^!

:: the following two lines must have fixed length of 99 characters from first to last sharp symbol(#)
::              #                                                                             #
set PHRASE_10_0_0=#   Этот скрипт создает файлы проектов и pvpgn.sln, которые можно открывать   #
set PHRASE_10_0_1=#   через Visual Studio и использовать для разработки и отладки PvPGN.        #

set PHRASE_10_1=Ошибка: Сначала скомпилируйте PvPGN через build_pvpgn.bat
set PHRASE_10_2=Файлы проектов будут созданы/заменены в папке %2. Подтвердите запуск.
set PHRASE_10_3=Готово^^! Все проекты размещены в папке %2.
set PHRASE_10_4= Ярлык %2 ссылается на %3
set PHRASE_10_5= Рабочая папка для всех проектов %2
