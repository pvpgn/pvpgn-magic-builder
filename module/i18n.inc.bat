@echo off
:: Gets localization strings depending user's system locale
:: Batch files encoding should be "OEM 866"


set Key="HKEY_CURRENT_USER\Control Panel\International"
for /F "tokens=3" %%a in ('reg query %Key%  ^| find /i "sLang"') do set LANGUAGE=%%a




:: default is English
goto ENG

:switch_lang
:: switch languages
if [%LANGUAGE%]==[RUS] goto RUS
if [%LANGUAGE%]==[NLD] goto NLD
::if [%LANGUAGE%]==[POL] goto POL

:echo_phrase
if not [%1]==[] echo !PHRASE_%1!


goto :eof

:ENG
	set PHRASE_1_1= Visual Studio is not installed
	set PHRASE_1_2= Visual Studio C++ environment was not found!
	set PHRASE_1_3=Download/update the latest PvPGN source from the SVN (in "source" directory)?
	set PHRASE_1_4=  PvPGN will update from the SVN
	set PHRASE_1_5=  PvPGN will not update
	set PHRASE_1_6=Select a PvPGN interface: 
	set PHRASE_1_7=   1) Console (defaut)
	set PHRASE_1_8=   2) GUI
	set PHRASE_1_9=Choose a number
	set PHRASE_1_10=  Set PvPGN interface as Console
	set PHRASE_1_11=  Set PvPGN interface as GUI (Graphical User Interface)
	set PHRASE_1_12= Select a database type: 
	set PHRASE_1_13=   1) Plain (default)
	set PHRASE_1_14=   2) MySQL
	set PHRASE_1_15=  PvPGN will build without database support
	set PHRASE_1_16=CMake configuration failed
	
	set PHRASE_2_1=Available %2 versions (you can add your own into modules\include\%2):
	set PHRASE_2_2=   Choose a number
	set PHRASE_2_3=   Wrong choice... try again
	set PHRASE_2_4=   PvPGN will compile with support %2 v%3
	
	set PHRASE_3_1=Checking for update ...
	set PHRASE_3_2="v%2" is your version
	set PHRASE_3_3="v%2" is remote version
	set PHRASE_3_4= You have the latest PvPGN Magic Builder
	set PHRASE_3_5=Remote version of PvPGN Magic Builder is not equals with yours. Do you want to automatically update to the new version?
	set PHRASE_3_6= Update was cancelled by user
	set PHRASE_3_7=Starting update ...
	set PHRASE_3_8= Downloading file "%2" ...
	set PHRASE_3_9=Update finished
	set PHRASE_3_10=Please, check file "version-history.txt" for more information about changes

	goto switch_lang
	
:RUS
	set PHRASE_1_1=  Visual Studio не установлен
	set PHRASE_1_2=  Среда Visual Studio C++ не найдена
	set PHRASE_1_3=Скачать/обновить последние исходники PvPGN из SVN (в папке "source")?
	set PHRASE_1_4=   PvPGN будет обновлен из SVN
	set PHRASE_1_5=   PvPGN не будет обновлен
	set PHRASE_1_6=Выберите интерфейс для PvPGN: 
	set PHRASE_1_7=    1) Консольный (по-умолчанию)
	set PHRASE_1_8=    2) Оконный
	set PHRASE_1_9=Введите номер
	set PHRASE_1_10=   Для PvPGN выбран консольный интерфейс
	set PHRASE_1_11=   Для PvPGN выбран оконный интерфейс
	set PHRASE_1_12= Выберите тип базы данных: 
	set PHRASE_1_13=    1) Текстовые файлы (по-умолчанию)
	set PHRASE_1_14=    2) MySQL
	set PHRASE_1_15=   PvPGN будет собран без поддержки базы данных
	set PHRASE_1_16=При конфигурации CMake возникли ошибки

	set PHRASE_2_1=Доступные версии %2 (можно добавить свою в modules\include\%2):
	set PHRASE_2_2=   Введите номер
	set PHRASE_2_3=   Неправильный номер... попробуйте ещё раз
	set PHRASE_2_4=   PvPGN будет скомпилирован с поддержкой %2 v%3
	
	set PHRASE_3_1=Проверка обновлений ...
	set PHRASE_3_2="v%2" ваша версия
	set PHRASE_3_3="v%2" последняя версия
	set PHRASE_3_4= У вас последний PvPGN Magic Builder
	set PHRASE_3_5=Версия PvPGN Magic Builder на сервере не совпадает с вашей. Хотите автоматически обновиться до последней версии?
	set PHRASE_3_6= Обновление отменено пользователем
	set PHRASE_3_7=Начинаю обновление ...
	set PHRASE_3_8= Загрузка файла "%2" ...
	set PHRASE_3_9=Обновление завершено
	set PHRASE_3_10=Информацию об изменениях можно посмотреть в файле "version-history.txt"
	
	goto echo_phrase
	
:: translation by MusicDemon
:NLD
	set PHRASE_1_1= Visual Studio is niet geinstaleerd
	set PHRASE_1_2= Visual Studio C++ omgeving was niet gevonden!
	set PHRASE_1_3=Download/update de laatste PvPGN broncode van de SVN (in de "source" directory)?
	set PHRASE_1_4=  PvPGN zal updaten van de SVN
	set PHRASE_1_5=  PvPGN zal niet worden geupdate
	set PHRASE_1_6=Selecteer PvPGN omgeving:
	set PHRASE_1_7=   1) Console (defaut)
	set PHRASE_1_8=   2) GUI
	set PHRASE_1_9=Kies een nummer
	set PHRASE_1_10=  Zet PvPGN omgeving als Console
	set PHRASE_1_11=  Set PvPGN interface as GUI (Graphical User Interface) Zet PvPGN omgeving als GUI ()
	set PHRASE_1_12= Selecteer een database type:
	set PHRASE_1_13=   1) Normaal (Text) (Standaard)
	set PHRASE_1_14=   2) MySQL
	set PHRASE_1_15=  PvPGN zal gebouwen worden zonder database ondersteuning
	set PHRASE_1_16=CMake configuratie mislukt
   
	set PHRASE_2_1=Beschikbare %2 versies (u kunt uw eigen in modules\includes\%2):
	set PHRASE_2_2=   Kies een nummer
	set PHRASE_2_3=   Verkeerde keuze... Probeer het opnieuw
	set PHRASE_2_4=   PvPGN word gebouwd met %2 ondersteuning op v%3
   
	set PHRASE_3_1=Checken voor updates...
	set PHRASE_3_2=U hebt versie "v%2"
	set PHRASE_3_3=Nieuwe versie is "v%2"
	set PHRASE_3_4= U hebt de laatste versie van PvPGN Magic Builder
	set PHRASE_3_5=Externe versie van PvPGN Magic Builder is niet gelijk aan met de jouwe. Wilt u automatisch bijgewerkt naar de nieuwe versi
	set PHRASE_3_6= Update was geannuleerd door gebruiker
	set PHRASE_3_7=Starten van update...
	set PHRASE_3_8= Downloaden van bestand "%2"...
	set PHRASE_3_9=Update voltooid
	set PHRASE_3_10=Controleer het bestand "version-history.txt" voor meer informatie over wijzigingen
   
	goto echo_phrase   
