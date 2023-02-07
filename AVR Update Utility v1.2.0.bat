::AVR Update Utility v1.2.0, Script by Mikhail Brazhnik, 02/2023
@ECHO OFF

chcp 1251 > NUL

::Блок переменных START
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
set WINRAR_WORK_FILE=C:\Program Files (x86)\WinRAR\WinRAR.exe
set ZIP_ARCH_DIR=C:\DWEB_Cumul_%date%
::Блок переменных END

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
if %QUEST_COPY_KAV%==y GOTO CopyKAV
if %QUEST_COPY_KAV%==Y GOTO CopyKAV
if %QUEST_COPY_KAV%==n GOTO QuestStartProg
if %QUEST_COPY_KAV%==N GOTO QuestStartProg
if %QUEST_COPY_KAV%==x GOTO Quit
if %QUEST_COPY_KAV%==X GOTO Quit
echo.
:CopyKAV
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
echo Работа с антивирусными базами Dr.Web:
echo.
echo [ lb ] Скачать антивирусные базы Dr.Web
echo [ ub ] Разархивировать скаченные антивирусные базы Dr.Web и удалить файл архива
echo [ cb ] Копировать антивирусные базы Dr.Web с флешки в директорию–источник
echo.
echo Работа с репозиторием Dr.Web:
echo.
echo [ lr ] Скачать репозиторий Dr.Web
echo [ cr ] Копировать репозиторий Dr.Web с флешки в директорию–источник
echo [ re ] Восстановить репозиторий из директории–источника на сервере Dr.Web
echo.
echo -------------------------
echo [ n ]  Назад
echo [ x ]  Выйти из программы
echo.
set /p QUEST_DWEB=">"
if %QUEST_DWEB%==lb GOTO DownloadDWEBBases
if %QUEST_DWEB%==Lb GOTO DownloadDWEBBases
if %QUEST_DWEB%==lB GOTO DownloadDWEBBases
if %QUEST_DWEB%==LB GOTO DownloadDWEBBases

if %QUEST_DWEB%==ub GOTO QuestUnzipDWEBBases
if %QUEST_DWEB%==Ub GOTO QuestUnzipDWEBBases
if %QUEST_DWEB%==uB GOTO QuestUnzipDWEBBases
if %QUEST_DWEB%==UB GOTO QuestUnzipDWEBBases

if %QUEST_DWEB%==lr GOTO DownloadDWEBRepo
if %QUEST_DWEB%==Lr GOTO DownloadDWEBRepo
if %QUEST_DWEB%==lR GOTO DownloadDWEBRepo
if %QUEST_DWEB%==LR GOTO DownloadDWEBRepo

if %QUEST_DWEB%==cb GOTO CopyBasesDWEB
if %QUEST_DWEB%==Cb GOTO CopyBasesDWEB
if %QUEST_DWEB%==cB GOTO CopyBasesDWEB
if %QUEST_DWEB%==CB GOTO CopyBasesDWEB

if %QUEST_DWEB%==cr GOTO CopyRepoDWEB
if %QUEST_DWEB%==Cr GOTO CopyRepoDWEB
if %QUEST_DWEB%==cR GOTO CopyRepoDWEB
if %QUEST_DWEB%==CR GOTO CopyRepoDWEB

if %QUEST_DWEB%==re GOTO RestoreDWEB
if %QUEST_DWEB%==Re GOTO RestoreDWEB
if %QUEST_DWEB%==rE GOTO RestoreDWEB
if %QUEST_DWEB%==RE GOTO RestoreDWEB

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

:DownloadDWEBBases
cls
if exist %DWEB_BASES_TARGET_DIR% (rd %DWEB_BASES_TARGET_DIR% /s /q)
if not exist %DWEB_BASES_TARGET_DIR% (md %DWEB_BASES_TARGET_DIR%)
echo.
echo -------------------------------------------
echo Начинается скачивание, пожалуйста, ждите...
echo -------------------------------------------
echo.
curl -o "%DWEB_BASES_TARGET_FILE%" "%DWEB_BASES_URL%"
echo.
pause
GOTO QuestUnzipDWEBBases

:QuestUnzipDWEBBases
cls
set QUEST_UNZIP_DWEB_BASES=NUL
echo ----------------------------------------
echo Распаковать архив и удалить файл архива?
echo ----------------------------------------
echo.
echo Введите:
echo.
echo [ y ] Да
echo [ n ] Нет
echo.
echo ------------------------
echo [ x ] Выйти из программы
echo.
echo После ввода нажмите ENTER
echo.
set /p QUEST_UNZIP_DWEB_BASES=">"

if %QUEST_UNZIP_DWEB_BASES%==y GOTO UnzipDWEBBases
if %QUEST_UNZIP_DWEB_BASES%==Y GOTO UnzipDWEBBases
if %QUEST_UNZIP_DWEB_BASES%==n GOTO QuestDWEB
if %QUEST_UNZIP_DWEB_BASES%==N GOTO QuestDWEB
if %QUEST_UNZIP_DWEB_BASES%==x GOTO Quit
if %QUEST_UNZIP_DWEB_BASES%==X GOTO Quit

GOTO UnzipDWEBBases

:UnzipDWEBBases
cls
echo.
echo --------------------------------------------------
echo Начинается распаковка архива, пожалуйста, ждите...
echo --------------------------------------------------
echo.
"%WINRAR_WORK_FILE%" x %DWEB_BASES_TARGET_FILE% %DWEB_BASES_TARGET_DIR%
rem "%WINRAR_WORK_FILE%" x -ibck %DWEB_BASES_TARGET_FILE% %DWEB_BASES_TARGET_DIR%
rem Ключь -ibck перемещает окно прогресса в трей
if not exist %ZIP_ARCH_DIR% (md %ZIP_ARCH_DIR%)
echo.
move /y %DWEB_BASES_TARGET_FILE% %ZIP_ARCH_DIR%\
pause
GOTO QuestDWEB

:DownloadDWEBRepo
cls
if exist %DWEB_REPO_TARGET_DIR% (rd %DWEB_REPO_TARGET_DIR% /s /q)
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

:CopyRepoDWEB
cls
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

:RestoreDWEB
cls
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
