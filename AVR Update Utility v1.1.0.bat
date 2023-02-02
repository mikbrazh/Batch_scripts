::AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
@ECHO OFF

chcp 1251 > NUL

set KAV_INIT_DIR=E:\Updates
set KAV_TARGET_DIR=C:\TEMP\KAVShare\Updates
set DWEB_INIT_DIR=E:\DWEB_Repo
set DWEB_TARGET_DIR=C:\TEMP\DWEB_Repo
set DWEB_UTIL_DIR=C:\Program Files\DrWeb Server\bin\drwcsd.exe
set DWEB_BASES_URL=http://www2.portal.cbr.ru/avir_bases/drweb/11.00/es11_fstek2019dec/update/es1100_cumul_fstek2019dec.zip
set DWEB_REPO_URL=http://www2.portal.cbr.ru/avir_bases/drweb/11.00/es11_fstek2019dec/update/es1100_repository_fstek2019dec.zip
set DWEB_BASES_TARGET_DIR=C:\TEMP\DWEB_Cumul
set DWEB_REPO_TARGET_DIR=C:\TEMP\DWEB_Repo
set DWEB_BASES_TARGET_FILE=%DWEB_BASES_TARGET_DIR%\es1100_cumul_fstek2019dec.zip
set DWEB_REPO_TARGET_FILE=%DWEB_REPO_TARGET_DIR%\es1100_repository_fstek2019dec.zip



::Блок старта программы START
:QuestStartProg
cls
echo.
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
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
echo.
echo ------------------------
echo [ x ] Выйти из программы
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
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
echo.
echo -----------------------------------------------
echo Cкопировать базы с флешки в рабочую директорию?
echo -----------------------------------------------
echo.
echo Введите:
echo.
echo [ y ] Да
echo [ n ] Назад
echo.
echo ------------------------
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
if not exist "%KAV_INIT_DIR%\*" GOTO ErrNoFileCopyKAV ::Проверка наличия файлов
cls
rd %KAV_TARGET_DIR% /s /q
if not exist %KAV_TARGET_DIR% (md %KAV_TARGET_DIR%)
xcopy %KAV_INIT_DIR% %KAV_TARGET_DIR% /e
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
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------
echo Выберите операцию:
echo ------------------
echo.
echo [ lb ] Скачать антивирусные базы Dr.Web
rem echo [ ub ] Разархивировать скаченные антивирусные базы Dr.Web
echo [ lr ] Скачать репозиторий Dr.Web
rem echo [ ur ] Разархивировать скаченный репозиторий базы Dr.Web
echo [ cb ] Копировать антивирусные базы с флешки в рабочую директорию
echo [ cr ] Копировать репозиторий с флешки в рабочую директорию
echo [ re ] Восстановить репозиторий из рабочей директории на сервере Dr.Web
echo [ n ]  Назад
echo.
echo -------------------------
echo [ x ]  Выйти из программы
echo.
set /p QUEST_DWEB=">"
if %QUEST_DWEB%==lb GOTO QuestLoadDWEBBases
if %QUEST_DWEB%==Lb GOTO QuestLoadDWEBBases
if %QUEST_DWEB%==lB GOTO QuestLoadDWEBBases
if %QUEST_DWEB%==LB GOTO QuestLoadDWEBBases

if %QUEST_DWEB%==lr GOTO QuestLoadDWEBRepo
if %QUEST_DWEB%==Lr GOTO QuestLoadDWEBRepo
if %QUEST_DWEB%==lR GOTO QuestLoadDWEBRepo
if %QUEST_DWEB%==LR GOTO QuestLoadDWEBRepo

if %QUEST_DWEB%==cb GOTO PerformCopyBasesDWEB
if %QUEST_DWEB%==Cb GOTO PerformCopyBasesDWEB
if %QUEST_DWEB%==cB GOTO PerformCopyBasesDWEB
if %QUEST_DWEB%==CB GOTO PerformCopyBasesDWEB

if %QUEST_DWEB%==cr GOTO PerformCopyRepoDWEB
if %QUEST_DWEB%==Cr GOTO PerformCopyRepoDWEB
if %QUEST_DWEB%==cR GOTO PerformCopyRepoDWEB
if %QUEST_DWEB%==CR GOTO PerformCopyRepoDWEB

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
rd %DWEB_BASES_TARGET_DIR% /s /q
if not exist %DWEB_BASES_TARGET_DIR% (md %DWEB_BASES_TARGET_DIR%)
echo.
echo -------------------------------------------
echo Начинается скачивание, пожалуйста, ждите...
echo -------------------------------------------
echo.
curl -o "%DWEB_BASES_TARGET_FILE%" "%DWEB_BASES_URL%"
echo.
pause
GOTO QuestDWEB

:QuestLoadDWEBRepo
rd %DWEB_REPO_TARGET_DIR% /s /q
if not exist %DWEB_REPO_TARGET_DIR% (md %DWEB_REPO_TARGET_DIR%)
echo.
echo -------------------------------------------
echo Начинается скачивание, пожалуйста, ждите...
echo -------------------------------------------
echo.
curl -o "%DWEB_REPO_TARGET_FILE%" "%DWEB_REPO_URL%"
echo.
pause
GOTO QuestDWEB

:PerformCopyBasesDWEB
rem ...
rem Написать проверку на наличие директории и создать ее если ее нет

:PerformCopyRepoDWEB
if not exist "%DWEB_INIT_DIR%\*repository*.zip" GOTO ErrNoFileCopyDWEB ::Проверка наличия файлов
echo.
echo --------------------------------------------------------
echo Начинается копирование репозитория, пожалуйста, ждите...
echo --------------------------------------------------------
echo.
rd %DWEB_TARGET_DIR% /s /q
if not exist %DWEB_TARGET_DIR% (md %DWEB_TARGET_DIR%)
xcopy %DWEB_INIT_DIR%\*repository*.zip %DWEB_TARGET_DIR% /e
echo.
pause
GOTO QuestDWEB

:PerformRestoreDWEB
if not exist "%DWEB_TARGET_DIR%\*repository*.zip" GOTO ErrNoFileRestoreDWEB ::Проверка наличия файлов
if not exist "%DWEB_UTIL_DIR%" GOTO ErrNoUtilFileDWEB ::Проверка наличия файлов
echo.
echo -----------------------------------------------------------
echo Начинается восстановление репозитория, пожалуйста, ждите...
echo -----------------------------------------------------------
echo.
"%DWEB_UTIL_DIR%" restorerepo "%DWEB_TARGET_DIR%\es1100_repository_fstek2019dec.zip"
echo.
pause
GOTO QuestDWEB
::Блок работы с DWEB END

::Блок обработки ошибок START
:ErrNoFileCopyKAV
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %KAV_INIT_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestCopyKAV

:ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %DWEB_INIT_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileRestoreDWEB
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %DWEB_TARGET_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoUtilFileDWEB
echo.
echo ------------------------------------------------------------------------------------------
echo Утилита для восстановления репозитория не найдена, проверьте ее наличие или измените путь:
echo %DWEB_UTIL_DIR%
echo ------------------------------------------------------------------------------------------
echo.
pause
GOTO QuestDWEB
::Блок обработки ошибок END

::Блок выхода из программы START
:Quit
cls
echo.
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------------------------------------------
echo Программа завершена. Для выхода нажмите любую клавишу.
echo ------------------------------------------------------
echo.
pause
exit
::Блок выхода из программы END
