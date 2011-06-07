@echo off
:: Gets localization strings depending user's system locale
:: Batch files encoding should be "OEM 866"
::  Language abbreveations: http://blogs.msdn.com/b/jeffreyzeng/archive/2008/04/30/language-code-and-abbreviation.aspx

set Key="HKEY_CURRENT_USER\Control Panel\International"
for /F "tokens=3" %%a in ('reg query %Key%  ^| find /i "sLang"') do set LANGUAGE=%%a




:: default is English
goto ENU

:switch_lang
:: switch to another language, if found
if [%LANGUAGE%]==[RUS] goto RUS
if [%LANGUAGE%]==[NLD] goto NLD
if [%LANGUAGE%]==[PLK] goto PLK
if [%LANGUAGE%]==[CSY] goto CSY
if [%LANGUAGE%]==[ESN] goto ESN
if [%LANGUAGE%]==[FRA] goto FRA
if [%LANGUAGE%]==[DEU] goto DEU
if [%LANGUAGE%]==[PTB] goto PTB
if [%LANGUAGE%]==[PTG] goto PTG
if [%LANGUAGE%]==[CHS] goto CHS
if [%LANGUAGE%]==[CHT] goto CHT
if [%LANGUAGE%]==[SRB] goto SRB

:echo_phrase
if not [%1]==[] echo !PHRASE_%1!


goto :eof

:: English
:ENU
	set MOTD_LANGUAGE=enUS

	set PHRASE_1_0=  Visual Studio is not installed
	set PHRASE_1_1=Select a Visual Studio version to build PvPGN:
	set PHRASE_1_2=%2 chosen as a build environment
	set PHRASE_1_3=Do you want to download/update the latest PvPGN source from the SVN (into %2 directory)?
	set PHRASE_1_4=   PvPGN will update from the SVN
	set PHRASE_1_5=   PvPGN will not update
	set PHRASE_1_6=Select a PvPGN interface: 
	set PHRASE_1_7=   1) Console (defaut)
	set PHRASE_1_8=   2) GUI
	set PHRASE_1_9=Choose a number
	set PHRASE_1_10=   Set PvPGN interface as Console
	set PHRASE_1_11=   Set PvPGN interface as GUI (Graphical User Interface)
	set PHRASE_1_12=Select a database type: 
	set PHRASE_1_13=   1) Plain (default)
	set PHRASE_1_14=
	set PHRASE_1_15=   PvPGN will build without database support
	set PHRASE_1_16=CMake configuration failed

	set PHRASE_2_1=Available %2 versions (you can add your own into %3):
	set PHRASE_2_2=   Choose a number
	set PHRASE_2_3=   Wrong choice... try again
	set PHRASE_2_4=   PvPGN will compile with support %2 v%3
	set PHRASE_2_5=Do you want to configure settings for %2 now?
	set PHRASE_2_6=    Connection host
	set PHRASE_2_7=    Connection user
	set PHRASE_2_8=    Connection password
	set PHRASE_2_9=    Database name
	set PHRASE_2_10=    Tables prefix (default is %2)
	set PHRASE_2_11=%2 configuration saved

	set PHRASE_3_1=Checking for update ...
	set PHRASE_3_2="v%2" is your version
	set PHRASE_3_3="v%2" is remote version
	set PHRASE_3_4= You have the latest PvPGN Magic Builder
	set PHRASE_3_5=Remote version of PvPGN Magic Builder is not equals with yours. Do you want to automatically update to the new version?
	set PHRASE_3_6= Update was cancelled by user
	set PHRASE_3_6_1= Can not connect to update server
	set PHRASE_3_7=Starting update ...
	set PHRASE_3_8= Downloading file %2 ...
	set PHRASE_3_9=Update finished
	set PHRASE_3_10=Please, check file %2 for more information about changes

	set PHRASE_4_1=Do you want to apply patch(es) to your PvPGN source code?
	set PHRASE_4_2=Please, first put your patch files to the %2 directory. You could download patches from the url: %3
	set PHRASE_4_3=*** WARNING ***
	set PHRASE_4_4=Paths into your *.patch files should set to relative of the root to the source code (it placed in the SVN at %2)
	set PHRASE_4_5=For example: you want to apply patch to %2, so path to this file should be %3
	set PHRASE_4_6=Are you ready to patch?
	set PHRASE_4_7=Applying patch %2 ...
	set PHRASE_4_8=Finished. Please, check for conflicts.
	set PHRASE_4_9=Do you want to continue building a PvPGN?

	goto switch_lang

:: Russian
:RUS
	set MOTD_LANGUAGE=ruRU

	set PHRASE_1_0=  Visual Studio не установлена
	set PHRASE_1_1=Выберите версию Visual Studio для компиляции PvPGN:
	set PHRASE_1_2=%2 выбрана в качестве компилятора
	set PHRASE_1_3=Скачать/обновить последние исходники PvPGN из SVN (в папке %2)?
	set PHRASE_1_4=   PvPGN будет обновлен из SVN
	set PHRASE_1_5=   PvPGN не будет обновлен
	set PHRASE_1_6=Выберите интерфейс для PvPGN: 
	set PHRASE_1_7=   1) Консольный (по-умолчанию)
	set PHRASE_1_8=   2) Оконный
	set PHRASE_1_9=Введите номер
	set PHRASE_1_10=   Для PvPGN выбран консольный интерфейс
	set PHRASE_1_11=   Для PvPGN выбран оконный интерфейс
	set PHRASE_1_12=Выберите тип базы данных: 
	set PHRASE_1_13=   1) Текстовые файлы (по-умолчанию)
	set PHRASE_1_14=
	set PHRASE_1_15=   PvPGN будет собран без поддержки базы данных
	set PHRASE_1_16=При конфигурации CMake возникли ошибки

	set PHRASE_2_1=Доступные версии %2 (можно добавить свою в %3):
	set PHRASE_2_2=   Введите номер
	set PHRASE_2_3=   Неправильный номер... попробуйте ещё раз
	set PHRASE_2_4=   PvPGN будет скомпилирован с поддержкой %2 v%3
	set PHRASE_2_5=Изменить сейчас настройки для %2?
	set PHRASE_2_6=    Адрес сервера (хост)
	set PHRASE_2_7=    Пользователь
	set PHRASE_2_8=    Пароль
	set PHRASE_2_9=    Название базы данных
	set PHRASE_2_10=    Префикс для таблиц (по-умолчанию %2):
	set PHRASE_2_11=Конфигурация %2 сохранена

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

	set PHRASE_4_1=Вы хотите применить патч(и) к исходному коду PvPGN?
	set PHRASE_4_2=Сначала поместите файлы патчей в папку %2. Скачать патчи можно по ссылке: %3
	set PHRASE_4_3=*** ОБРАТИТЕ ВНИМАНИЕ ***
	set PHRASE_4_4=Пути внутри ваших *.patch файлов должны быть установлены относительно корневой папки к исходному коду (в SVN он размещается в %2)
	set PHRASE_4_5=Например: вы хотите применить патч к файлу %2, тогда путь к этому файлу должен быть %3
	set PHRASE_4_6=Вы готовы начать применение патчей?
	set PHRASE_4_7=Применяется патч %2 ...
	set PHRASE_4_8=Завершено. Проверьте наличие конфликтов.
	set PHRASE_4_9=Продолжить построение PvPGN?

	goto echo_phrase

:: Dutch - translation by MusicDemon
:NLD
	set MOTD_LANGUAGE=nlNL

	set PHRASE_1_0= Visual Studio is niet geinstaleerd
	set PHRASE_1_1=Selecteer een Visual Studio versie om PvPGN te bouwen:
    set PHRASE_1_2=%2 is gekozen als bouw omgeving
	set PHRASE_1_3=Download/update de laatste PvPGN broncode van de SVN (in de %2 directory)?
	set PHRASE_1_4=   PvPGN zal updaten van de SVN
	set PHRASE_1_5=   PvPGN zal niet worden geupdate
	set PHRASE_1_6=Selecteer PvPGN omgeving:
	set PHRASE_1_7=   1) Console (defaut)
	set PHRASE_1_8=   2) GUI
	set PHRASE_1_9=Kies een nummer
	set PHRASE_1_10=  Zet PvPGN omgeving als Console
	set PHRASE_1_11=  Set PvPGN interface as GUI (Graphical User Interface) Zet PvPGN omgeving als GUI ()
	set PHRASE_1_12=Selecteer een database type:
	set PHRASE_1_13=   1) Normaal (Text) (Standaard)
	set PHRASE_1_14=
	set PHRASE_1_15=  PvPGN zal gebouwen worden zonder database ondersteuning
	set PHRASE_1_16=CMake configuratie mislukt

	set PHRASE_2_1=Beschikbare %2 versies (u kunt uw eigen in %3):
	set PHRASE_2_2=   Kies een nummer
	set PHRASE_2_3=   Verkeerde keuze... Probeer het opnieuw
	set PHRASE_2_4=   PvPGN word gebouwd met %2 ondersteuning op v%3
	set PHRASE_2_5=Wilt u %2 nu configureren?
	set PHRASE_2_6=    Connectie host
	set PHRASE_2_7=    Connectie gebruiker
	set PHRASE_2_8=    Connectie wachtwoord
	set PHRASE_2_9=    Database naam
	set PHRASE_2_10=    Tafel voorvoegsel (Table prefix, standaard is %2)
	set PHRASE_2_11=%2 configuratie opgeslagen

	set PHRASE_3_1=Checken voor updates...
	set PHRASE_3_2=U hebt versie "v%2"
	set PHRASE_3_3=Nieuwe versie is "v%2"
	set PHRASE_3_4= U hebt de laatste versie van PvPGN Magic Builder
	set PHRASE_3_5=Externe versie van PvPGN Magic Builder is niet gelijk aan met de jouwe. Wilt u automatisch bijgewerkt naar de nieuwe versi
	set PHRASE_3_6= Update was geannuleerd door gebruiker
	set PHRASE_3_6_1= Kan geen connectie maken met update server
	set PHRASE_3_7=Starten van update...
	set PHRASE_3_8= Downloaden van bestand %2...
	set PHRASE_3_9=Update voltooid
	set PHRASE_3_10=Controleer het bestand %2 voor meer informatie over wijzigingen
	
	set PHRASE_4_1=Wilt u patches toevoegen aan uw PvPGN bron code?
	set PHRASE_4_2=Gelieve de patch bestanden in %2 te plaatsen. U kunt the patches downloaden vanaf: %3
	set PHRASE_4_3=*** WAARSCHUWING ***
	set PHRASE_4_4=Paden in uw *.patch-bestand(en) moeten relatief zijn naar het begin of naar de bron code (Het is geplaatst in de SVN op %2)
	set PHRASE_4_5=Voorbeeld: U wilt patch %2 toevoegen, dus het patch-bestand moet %3 zijn
	set PHRASE_4_6=Bent u klaar om te patchen?
	set PHRASE_4_7=Patch %2 toevoegen ...
	set PHRASE_4_8=Voltooid. Gelieve na te kijken voor conflicten
	set PHRASE_4_9=Wilt u doorgaan met het bouwen van PvPGN?

	goto echo_phrase

:: Polish - translation by Grzegorz Nakonieczny (Naki-BoT)
:PLK
	set MOTD_LANGUAGE=plPL

	set PHRASE_1_0=  Program Visual Studio nie jest zainstalowany na komputerze
	set PHRASE_1_1=Wybierz wersje programu Visual Studio przy uzyciu ktorej chcesz skompilowac PvPGN:
	set PHRASE_1_2=Wybrano %2 jako srodowisko programistyczne
	set PHRASE_1_3=Czy chcesz pobrac/zaktualizowac PvPGN do najnowszej wersji z repozytorium SVN (w katalogu %2)?
	set PHRASE_1_4=   PvPGN zostanie zaktualizowany do najnowszej wersji z repozytorium SVN
	set PHRASE_1_5=   PvPGN nie zostanie zaktualizowany
	set PHRASE_1_6=Wybierz interfejs PvPGN jaki chcesz uzywac: 
	set PHRASE_1_7=   1) Konsola - Wiersz polecen (domyslnie)
	set PHRASE_1_8=   2) GUI - Interfejs graficzny
	set PHRASE_1_9=Podaj liczbe
	set PHRASE_1_10=   Wybrany interfejs: Wiersz polecen
	set PHRASE_1_11=   Wybrany interfejs: Interfejs graficzny
	set PHRASE_1_12=Wybierz typ bazy danych: 
	set PHRASE_1_13=   1) Pliki (domyslnie)
	set PHRASE_1_14=
	set PHRASE_1_15=   PvPGN zostanie skompilowany bez obslugi bazy danych
	set PHRASE_1_16=Blad podczas konfiguracji CMake

	set PHRASE_2_1=Dostepne wersje %2 (mozesz dodac wlasne w katalogu %3):
	set PHRASE_2_2=   Podaj liczbe
	set PHRASE_2_3=   Bledny wybor... sprobuj ponownie
	set PHRASE_2_4=   PvPGN zostanie skompilowany z obsluga %2 v%3
	set PHRASE_2_5=Czy chcesz teraz dokonac konfiguracji %2?
	set PHRASE_2_6=    Adres serwera bazy danych
	set PHRASE_2_7=    Nazwa uzytkownika bazy danych
	set PHRASE_2_8=    Haslo do bazy danych
	set PHRASE_2_9=    Nazwa bazy danych
	set PHRASE_2_10=    Prefiks tabel w bazie danych (domyslny %2)
	set PHRASE_2_11=Konfiguracja %2 zapisana

	set PHRASE_3_1=Sprawdzanie aktualizacji ...
	set PHRASE_3_2=Twoja wersja "v%2"
	set PHRASE_3_3=Aktualna wersja "v%2"
	set PHRASE_3_4= Posiadasz najnowsza wersje PvPGN Magic Builder
	set PHRASE_3_5=Aktualna wersja PvPGN Magic Builder jest inna niz Twoja, czy chcesz dokonac aktualizacji?
	set PHRASE_3_6= Aktualizacja zostala anulowana przez uzytkownika
	set PHRASE_3_6_1= Brak polaczenia z serwerem
	set PHRASE_3_7=Trwa aktualizacja ...
	set PHRASE_3_8= Pobieranie pliku %2 ...
	set PHRASE_3_9=Aktualizacja zakonczona
	set PHRASE_3_10=Aby dowiedziec sie wiecej o wprowadzonych zmianach sprawdz plik %2

	set PHRASE_4_1=Czy chcesz zastosowac dodatkowe latki do kodu zrodlowego PvPGN?
	set PHRASE_4_2=Umiesc latki w katalogu %2. Latki mozesz pobrac ze strony: %3
	set PHRASE_4_3=*** UWAGA ***
	set PHRASE_4_4=Sciezki w plikach *.patch powinny byc relatywne do katalogu glownego kodu zrodlowego (w repozytorium SVN znajduje sie on w %2)
	set PHRASE_4_5=Przykladowo: jesli chcesz zastosowac latke do pliku %2, sciezka do niego powinna byc %3
	set PHRASE_4_6=Czy jestes gotowy zastosowac latki?
	set PHRASE_4_7=Nakladanie latki %2 ...
	set PHRASE_4_8=Zakonczono. Prosze sprawdzic czy nie wystapily konflikty.
	set PHRASE_4_9=Czy chcesz kontynuowac kompilowanie PvPGN?

	goto echo_phrase
	
:: German - translation by Natalya Lyovkina (SKY777)
:DEU
	set MOTD_LANGUAGE=deDE
	
	set PHRASE_1_0=  Visual Studio ist nicht installiert
	set PHRASE_1_1=Wahlen Sie eine Visual Studio-Version fur die PvPGN-Compilierung:
	set PHRASE_1_2=%2 wurde als Compiler gewahlt
	set PHRASE_1_3=Mochten Sie die letzten PvPGN-Programmcoden aus SVN (im %2-Ordner) herunterladen / aktualisieren?
	set PHRASE_1_4=   PvPGN wird aus SVN aktualisiert werden
	set PHRASE_1_5=   PvPGN wird nicht aktualisieret werden
	set PHRASE_1_6=Wahlen Sie eine Schnittstelle fur PvPGN: 
	set PHRASE_1_7=   1) Konsolenschnittstelle (Standardeinstellung)
	set PHRASE_1_8=   2) Fensterschnittstelle
	set PHRASE_1_9=Geben Sie eine Nummer ein
	set PHRASE_1_10=   Fur PvPGN wurde die Konsolenschnittstelle gewahlt
	set PHRASE_1_11=   Fur PvPGN wurde die Fensterschnittstelle gewahlt
	set PHRASE_1_12=Wahlen Sie den Datenbanktyp: 
	set PHRASE_1_13=   1) Textdateien (Standardeinstellung)
	set PHRASE_1_14=
	set PHRASE_1_15=   PvPGN wird ohne Datenbankunterstutzung gewahlt
	set PHRASE_1_16=Bei der CMake-Konfiguration entstanden die Fehler 
	
	set PHRASE_2_1=Zugangliche %2 -Versionen (man kann seine Version in den %3 hinzufugen):
	set PHRASE_2_2=   Geben Sie eine Nummer ein
	set PHRASE_2_3=   Falsche Nummer... versuchen Sie noch einmal 
	set PHRASE_2_4=   PvPGN wird mit der %2 v%3-Unterstutzung kompiliert
	set PHRASE_2_5=Mochten Sie jetzt die %2-Einstellungen andern?
	set PHRASE_2_6=    Serveradresse (Host)
	set PHRASE_2_7=    Benutzer
	set PHRASE_2_8=    Passwort
	set PHRASE_2_9=    Datenbankname
	set PHRASE_2_10=    Vorsatzkode fur Tabellen (Standardeinstellung %2)
	set PHRASE_2_11=Die %2 -Konfiguration wurde gespeichert

	set PHRASE_3_1=Update-Prufung ...
	set PHRASE_3_2=Ihre "v%2"-Version 
	set PHRASE_3_3=Letzte "v%2"-Version
	set PHRASE_3_4=Sie haben ein letzes PvPGN Magic Builder
	set PHRASE_3_5=Die  PvPGN Magic Builder-Version im Server stimmt mit Ihrer Version nicht uberein. Mochten Sie automatisch bis zur letzten Version aktualisieren?
	set PHRASE_3_6=Das Update wurde vom Benutzer zuruckgesetzt 
	set PHRASE_3_6_1= Keine Verbindung mit dem Update-Server
	set PHRASE_3_7=Das Update start ...
	set PHRASE_3_8= Herunterladen der %2-Datei ...
	set PHRASE_3_9=Das Update wurde beendet 
	set PHRASE_3_10=Die Information uber die Anderungen kann man im %2-Datei sehen
	
	set PHRASE_4_1=Mochten Sie  Patch(es) auf die PvPGN-Programmcode anwenden?
	set PHRASE_4_2=Bringen Sie zuerst die Patch-Dateien in den %2-Order. Die Patches konnen per Link %3 heruntergeladen werden: 
	set PHRASE_4_3=*** BEACHTEN SIE BITTE***
	set PHRASE_4_4=Die Pfade in Ihren Patch-Dateien (*.patch) sollen bezuglich auf den Ordner zur Programmcode eingestellt werden (in SVN wird sie in %2 platziert)
	set PHRASE_4_5=Zum Beispiel: Sie mochten einen Patch auf die %2-Datei anwenden, dann soll der Pfad zu dieser Datei %3 sein
	set PHRASE_4_6=Sind Sie bereit, Patches anzuwenden?
	set PHRASE_4_7=Der Patch %2 wird angewendet ...
	set PHRASE_4_8=Beendet. Prufen Sie, ob es Konflikte gibt.
	set PHRASE_4_9=Mochten Sie die PvPGN-Compilierung fortsetzen?
	
	goto echo_phrase
	
:: Serbian - translation by kingW3
:SRB
	set MOTD_LANGUAGE=enUS

	set PHRASE_1_0=  Visual Studio nije instaliran
	set PHRASE_1_1=Izaberi kojom verzijom Visual Studia ces da Napravis pvpgn:
	set PHRASE_1_2=%2 izabran kao kompajler
	set PHRASE_1_3=da li zelis da downloadujes/updejtujes zadnji pvpgn iz svn-a (u %2 folder)?
	set PHRASE_1_4=   PvPGN ce updejtovati iz svn-a
	set PHRASE_1_5=   PvPGN nece updejtovati iz svn-a
	set PHRASE_1_6=Izaberi PvPGN izgled: 
	set PHRASE_1_7=   1) Consola (defaut)
	set PHRASE_1_8=   2) GUI(Graficki prikaz)
	set PHRASE_1_9=Izaberi broj
	set PHRASE_1_10=   izaberi PvPGN izgled as Console
	set PHRASE_1_11=   izaveri PvPGN izgled as GUI (Graficki izgled)
	set PHRASE_1_12=izaberi vrstu baze podataka: 
	set PHRASE_1_13=   1) Plain (default)
	set PHRASE_1_14=   2) MySql
	set PHRASE_1_15=   PvPGN ce praviti bez baze podataka
	set PHRASE_1_16=CMake konfigurisanje nije uspelo

	set PHRASE_2_1=Dostupne %2 verzije (mozes dodati svoju verziju %3):
	set PHRASE_2_2=   izaberi broj
	set PHRASE_2_3=   lose izabrano... probajte opet
	set PHRASE_2_4=   PvPGN ce compilirati pomocu %2 v%3
	set PHRASE_2_5=dali zelite da konfigurisete %2 now?
	set PHRASE_2_6=    host baze podataka
	set PHRASE_2_7=    korisnik baze podataka
	set PHRASE_2_8=    pasvord korisnika
	set PHRASE_2_9=    ime baze podataka
	set PHRASE_2_10=    prefix tabele (default is %2)
	set PHRASE_2_11=%2 konfiguracija sacuvana

	set PHRASE_3_1=Gledanje za updejt ...
	set PHRASE_3_2="v%2" je tvoja verzija
	set PHRASE_3_3="v%2" je zadnja verzija
	set PHRASE_3_4= Imas zadnju verziju PvPGN Magic Builder-a
	set PHRASE_3_5=Verzija PvPGN Magic Builder nije jednaka tvojoj. Dali zelite da automatski updejtuje na zadnju verziju?
	set PHRASE_3_6= Korisnik je zaustavio Updejt
	set PHRASE_3_6_1= Can not connect to Updejt server
	set PHRASE_3_7=pocinje Updejt ...
	set PHRASE_3_8= skidanje fajlova %2 ...
	set PHRASE_3_9=Updejt zavrsen
	set PHRASE_3_10=Molimo vas, proverite fajl %2 za vise informacija oko promena

	set PHRASE_4_1=Dali zelite da primenite patch u sourcu fajl ?
	set PHRASE_4_2=Molimo vas, prvo stavite patch fajl(ove) u %2 directorijum. Mozete skinuti patchs sa ove webstranice: %3
	set PHRASE_4_3=*** Upozorenje ***
	set PHRASE_4_4=Lokacije u vasim *.patch fajlovima treba staviti kao u source codu (its placed in the SVN at %2)
	set PHRASE_4_5=Na primer: dali zelite da primenite patch to %2, tako da lokacija za ovaj fajl treba da bude %3
	set PHRASE_4_6=dali ste spremni da patcujete?
	set PHRASE_4_7=primenjuje patch %2 ...
	set PHRASE_4_8=Zavrseno. Molimo vas, pogledajte da nema sukoba.
	set PHRASE_4_9=Dali zelite da nastavite pravljenjem pvpgn-a?

	goto echo_phrase
	
:: Czech
:CSY
	set MOTD_LANGUAGE=csCZ
	goto echo_phrase
	
:: Spanish
:ESN
	set MOTD_LANGUAGE=esES
	goto echo_phrase
	
:: French
:FRA
	set MOTD_LANGUAGE=frFR
	goto echo_phrase
	

:: Chinese - China
:CHS
	set MOTD_LANGUAGE=zhCN
	goto echo_phrase
	
:: Chinese - Taiwan
:CHT
	set MOTD_LANGUAGE=zhTW
	goto echo_phrase
	
:: Portuguese - Brazil
:PTB
	set MOTD_LANGUAGE=ptBR
	goto echo_phrase
	
:: Portuguese - Portugal
:PTG
	goto PTB

