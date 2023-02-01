::AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
@ECHO OFF

chcp 1251 > NUL

set KAV_INIT_PATH=E:\Updates
set KAV_TARGET_PATH=C:\TEMP\KAVShare\Updates
set DWEB_INIT_PATH=E:\DWEB_Repo
set DWEB_TARGET_PATH=C:\TEMP\DWEB_Repo
set DWEB_UTIL_PATH=C:\Program Files\DrWeb Server\bin\drwcsd.exe
set DWEB_BASES_URL=http://www2.portal.cbr.ru/avir_bases/drweb/11.00/es11_fstek2019dec/update/es1100_repository_fstek2019dec.zip
set DWEB_BASES_TARGET_PATH=C:\TEMP\DWEB_Repo\es1100_repository_fstek2019dec.zip
set DWEB_REPO_URL=
set DWEB_REPO_TARGET_PATH=


::Блок старта программы START
:QuestStartProg
cls
echo.
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
set QUEST_START_PROG=NUL
echo --------------------------------------------
echo С каким продуктом СЗ от ВВК будете работать?
echo --------------------------------------------
echo.
echo Введите:
echo.
echo [ ka ] для работы с Kaspersky Antivirus
echo [ dw ] для работы c Dr.Web
echo [ x ]  для выхода из программы
echo.
echo После ввода нажмите ENTER
echo.
set /p QUEST_START_PROG=">"
if %QUEST_START_PROG%==ka GOTO QuestCopyKAV
if %QUEST_START_PROG%==Ka GOTO QuestCopyKAV
if %QUEST_START_PROG%==kA GOTO QuestCopyKAV
if %QUEST_START_PROG%==KA GOTO QuestCopyKAV

if %QUEST_START_PROG%==dw GOTO QuestDWEB
if %QUEST_START_PROG%==Dw GOTO QuestDWEB
if %QUEST_START_PROG%==dW GOTO QuestDWEB
if %QUEST_START_PROG%==DW GOTO QuestDWEB

if %QUEST_START_PROG%==x GOTO Quit
if %QUEST_START_PROG%==X GOTO Quit
echo.
echo -------------------------
echo Введена неверная команда.
echo -------------------------
echo.
pause
GOTO QuestStartProg
::Блок старта программы END

::Блок работы с KAV START
echo.
:QuestCopyKAV
cls
set QUEST_COPY_KAV=NUL
echo.
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
echo -----------------------------------------------
echo Cкопировать базы с флешки в рабочую директорию?
echo -----------------------------------------------
echo.
echo Введите:
echo.
echo [ y ] Да
echo [ n ] Назад
echo [ x ] Выйти из программы
echo.
set /p QUEST_COPY_KAV=">"
if %QUEST_COPY_KAV%==y GOTO PerformCopyKAV
if %QUEST_COPY_KAV%==Y GOTO PerformCopyKAV
if %QUEST_COPY_KAV%==n GOTO QuestStartProg
if %QUEST_COPY_KAV%==N GOTO QuestStartProg
if %QUEST_COPY_KAV%==x GOTO Quit
if %QUEST_COPY_KAV%==X GOTO Quit
echo.
:PerformCopyKAV
if not exist "%KAV_INIT_PATH%\*" GOTO ErrNoFileCopyKAV ::Проверка наличия файлов
cls
rd %KAV_TARGET_PATH% /s /q
if not exist %KAV_TARGET_PATH% (md %KAV_TARGET_PATH%)
xcopy %KAV_INIT_PATH% %KAV_TARGET_PATH% /e
echo.
pause
GOTO QuestStartProg
::Блок работы с KAV END

::Блок работы с DWEB START
echo.
:QuestDWEB
cls
set QUEST_DWEB=NUL
echo.
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
echo ------------------
echo Выберите операцию:
echo ------------------
echo.
echo [ lb ] для cкачивания антивирусных баз Dr.Web
echo [ lr ] для cкачивания антивирусных баз Dr.Web
echo [ cp ] Копировать репозиторий с флешки в рабочую директорию
echo [ re ] Восстановить репозиторий из рабочей директории на сервере Dr.Web
echo [ n ]  Назад
echo [ x ]  Выйти из программы
echo.
set /p QUEST_DWEB=">"
if %QUEST_START_PROG%==lb GOTO QuestLoadDWEBBases
if %QUEST_START_PROG%==Lb GOTO QuestLoadDWEBBases
if %QUEST_START_PROG%==lB GOTO QuestLoadDWEBBases
if %QUEST_START_PROG%==LB GOTO QuestLoadDWEBBases

if %QUEST_START_PROG%==lr GOTO QuestLoadDWEBRepo
if %QUEST_START_PROG%==Lr GOTO QuestLoadDWEBRepo
if %QUEST_START_PROG%==lR GOTO QuestLoadDWEBRepo
if %QUEST_START_PROG%==LR GOTO QuestLoadDWEBRepo

if %QUEST_DWEB%==cp GOTO PerformCopyDWEB
if %QUEST_DWEB%==Cp GOTO PerformCopyDWEB
if %QUEST_DWEB%==cP GOTO PerformCopyDWEB
if %QUEST_DWEB%==CP GOTO PerformCopyDWEB

if %QUEST_DWEB%==re GOTO PerformRestoreDWEB
if %QUEST_DWEB%==Re GOTO PerformRestoreDWEB
if %QUEST_DWEB%==rE GOTO PerformRestoreDWEB
if %QUEST_DWEB%==RE GOTO PerformRestoreDWEB

if %QUEST_DWEB%==n GOTO QuestStartProg
if %QUEST_DWEB%==N GOTO QuestStartProg

if %QUEST_DWEB%==x GOTO Quit
if %QUEST_DWEB%==X GOTO Quit
echo.
echo -------------------------
echo Введена неверная команда.
echo -------------------------
echo.
pause
GOTO QuestDWEB

:QuestLoadDWEBBases
curl -o "%DWEB_BASES_TARGET_PATH%" "%DWEB_BASES_URL%"

:QuestLoadDWEBRepo
rem ...

:PerformCopyDWEB
if not exist "%DWEB_INIT_PATH%\*repository*.zip" GOTO ErrNoFileCopyDWEB ::Проверка наличия файлов
echo.
echo --------------------------------------------------------
echo Начинается копирование репозитория, пожалуйста, ждите...
echo --------------------------------------------------------
echo.
rd %DWEB_TARGET_PATH% /s /q
if not exist %DWEB_TARGET_PATH% (md %DWEB_TARGET_PATH%)
xcopy %DWEB_INIT_PATH%\*repository*.zip %DWEB_TARGET_PATH% /e
echo.
pause
GOTO QuestDWEB

:PerformRestoreDWEB
if not exist "%DWEB_TARGET_PATH%\*repository*.zip" GOTO ErrNoFileRestoreDWEB ::Проверка наличия файлов
if not exist "%DWEB_UTIL_PATH%" GOTO ErrNoUtilFileDWEB ::Проверка наличия файлов
echo.
echo -----------------------------------------------------------
echo Начинается восстановление репозитория, пожалуйста, ждите...
echo -----------------------------------------------------------
echo.
"%DWEB_UTIL_PATH%" restorerepo "%DWEB_TARGET_PATH%\es1100_repository_fstek2019dec.zip"
echo.
pause
GOTO QuestDWEB
::Блок работы с DWEB END

::Блок обработки ошибок START
:ErrNoFileCopyKAV
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %KAV_INIT_PATH%
echo --------------------------------------------------------
echo.
pause
GOTO QuestCopyKAV

:ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %DWEB_INIT_PATH%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileRestoreDWEB
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %DWEB_TARGET_PATH%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoUtilFileDWEB
echo.
echo ------------------------------------------------------------------------------------------
echo Утилита для восстановления репозитория не найдена, проверьте ее наличие или измените путь:
echo %DWEB_UTIL_PATH%
echo ------------------------------------------------------------------------------------------
echo.
pause
GOTO QuestDWEB
::Блок обработки ошибок END

::Блок выхода из программы START
:Quit
cls
echo.
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
echo ------------------------------------------------------
echo Программа завершена. Для выхода нажмите любую клавишу.
echo ------------------------------------------------------
echo.
pause
exit
::Блок выхода из программы END
