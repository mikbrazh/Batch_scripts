::AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
@ECHO OFF

chcp 1251 > NUL

::Блокировка функций START
::cls
::echo ----------------------------------------------------------
::echo Данная функция заблокирована. Обратитесь к администратору.
::echo ----------------------------------------------------------
::pause
::GOTO #
::Блокировка функций END

::Блок переменных START
::KAV
set KAV_BASES_DOWNLOAD_DIR=E:\TEMP\FD\KAV_Updates
set KAV_BASES_CLI_SRC_DIR=E:\TEMP\CLI\Updates
set KAV_BASES_SRV_DIST_DIR=E:\TEMP\SRV\KAVShare\Updates

::DWEB
::Bases
set DWEB_BASES_DOWNLOAD_DIR=E:\TEMP\FD\DWEB_Cumul
set DWEB_BASES_DOWNLOAD_FILE=%DWEB_BASES_DOWNLOAD_DIR%\es1100_cumul_fstek2019dec.zip
set DWEB_BASES_SRV_DIST_DIR=E:\TEMP\SRV\DWEBShare\DWEB_Cumul
set DWEB_BASES_URL=https://fonts.fontstorage.com/fonts/original/roboto/roboto.zip

::Repo
set DWEB_REPO_DOWNLOAD_DIR=E:\TEMP\FD\DWEB_Repo
set DWEB_REPO_DOWNLOAD_FILE=%DWEB_REPO_DOWNLOAD_DIR%\es1100_repository_fstek2019dec.zip
set DWEB_REPO_SRV_DIST_DIR=E:\TEMP\SRV\DWEBShare\DWEB_Repo
set DWEB_REPO_URL=https://fonts.fontstorage.com/fonts/original/roboto/roboto.zip

::Util
set DWEB_UTIL_WORK_FILE=C:\Program Files\DrWeb Server\bin\drwcsd.exe

::ZIP
set WINRAR_WORK_FILE=C:\Program Files\WinRAR\WinRAR.exe
set DWEB_ZIPFILES_ARCH_DIR=E:\TEMP\FD\DWEB_Cumul_Arch\DWEB_Cumul_%date%
::Блок переменных END

::Блок старта программы START
:QuestStartProg
cls
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
echo.
set QUEST_START_PROG=NUL
echo --------------------------------------------
echo С каким продуктом СЗ от ВВК будете работать?
echo --------------------------------------------
echo.
echo Введите:
echo.
echo [ ka ] для работы с Kaspersky Antivirus
rem echo [ dw ] для работы c Dr.Web
echo.
echo ------------------------
echo [ x ] Выйти из программы
echo.
echo После ввода нажмите ENTER
echo.
set /p QUEST_START_PROG=">"
if %QUEST_START_PROG%==ka GOTO QuestKAV
if %QUEST_START_PROG%==Ka GOTO QuestKAV
if %QUEST_START_PROG%==kA GOTO QuestKAV
if %QUEST_START_PROG%==KA GOTO QuestKAV

rem if %QUEST_START_PROG%==dw GOTO QuestDWEB
rem if %QUEST_START_PROG%==Dw GOTO QuestDWEB
rem if %QUEST_START_PROG%==dW GOTO QuestDWEB
rem if %QUEST_START_PROG%==DW GOTO QuestDWEB

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
:QuestKAV
cls
set QUEST_KAV=NUL
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------
echo Выберите операцию:
echo ------------------
echo.
echo Введите:
echo.
rem echo [ cf ] Скопировать базы на флешку
echo [ cd ] Cкопировать антивирусные базы KAV с флешки на диск (в директорию-источник)
echo.
echo ------------------------
echo [ n ] Назад
echo [ x ] Выйти из программы
echo.
set /p QUEST_KAV=">"
rem if %QUEST_KAV%==cf GOTO QuestCopyKAVtoFlash
rem if %QUEST_KAV%==cF GOTO QuestCopyKAVtoFlash
rem if %QUEST_KAV%==Cf GOTO QuestCopyKAVtoFlash
rem if %QUEST_KAV%==CF GOTO QuestCopyKAVtoFlash

if %QUEST_KAV%==cd GOTO QuestCopyKAVtoDisk
if %QUEST_KAV%==cD GOTO QuestCopyKAVtoDisk
if %QUEST_KAV%==Cd GOTO QuestCopyKAVtoDisk
if %QUEST_KAV%==CD GOTO QuestCopyKAVtoDisk

if %QUEST_KAV%==n GOTO QuestStartProg
if %QUEST_KAV%==N GOTO QuestStartProg

if %QUEST_KAV%==x GOTO Quit
if %QUEST_KAV%==X GOTO Quit
echo.
echo -------------------------
echo Введена неверная команда.
echo -------------------------
echo.
pause
GOTO QuestKAV

:QuestCopyKAVtoFlash
cls
set QUEST_COPY_KAV_FLASH=NUL
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
echo.
echo ---------------------------
echo Скопировать базы на флешку?
echo ---------------------------
echo.
echo Введите:
echo.
echo [ y ] Да
echo [ n ] Назад
echo.
echo ------------------------
echo [ x ] Выйти из программы
echo.
set /p QUEST_COPY_KAV_FLASH=">"
if %QUEST_COPY_KAV_FLASH%==y GOTO CopyKAVtoFlash
if %QUEST_COPY_KAV_FLASH%==Y GOTO CopyKAVtoFlash
if %QUEST_COPY_KAV_FLASH%==n GOTO QuestKAV
if %QUEST_COPY_KAV_FLASH%==N GOTO QuestKAV
if %QUEST_COPY_KAV_FLASH%==x GOTO Quit
if %QUEST_COPY_KAV_FLASH%==X GOTO Quit
echo.

:CopyKAVtoFlash
cls
if not exist "%KAV_BASES_CLI_SRC_DIR%\*" GOTO ErrNoFileCopyKAVtoFlash
cls
::rd %KAV_BASES_DOWNLOAD_DIR% /s /q Удаление каталога
if not exist %KAV_BASES_DOWNLOAD_DIR% (md %KAV_BASES_DOWNLOAD_DIR%)
xcopy %KAV_BASES_CLI_SRC_DIR% %KAV_BASES_DOWNLOAD_DIR% /e /y
echo.
pause
GOTO QuestStartProg

echo.
:QuestCopyKAVtoDisk
cls
set QUEST_COPY_KAV_DISK=NUL
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
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
set /p QUEST_COPY_KAV_DISK=">"
if %QUEST_COPY_KAV_DISK%==y GOTO CopyKAVtoDisk
if %QUEST_COPY_KAV_DISK%==Y GOTO CopyKAVtoDisk
if %QUEST_COPY_KAV_DISK%==n GOTO QuestKAV
if %QUEST_COPY_KAV_DISK%==N GOTO QuestKAV
if %QUEST_COPY_KAV_DISK%==x GOTO Quit
if %QUEST_COPY_KAV_DISK%==X GOTO Quit
echo.
:CopyKAVtoDisk
cls
if not exist "%KAV_BASES_DOWNLOAD_DIR%\*" GOTO ErrNoFileCopyKAVtoDisk
cls
::rd %KAV_BASES_SRV_DIST_DIR% /s /q Удаление каталога
if not exist %KAV_BASES_SRV_DIST_DIR% (md %KAV_BASES_SRV_DIST_DIR%)
xcopy %KAV_BASES_DOWNLOAD_DIR% %KAV_BASES_SRV_DIST_DIR% /e /y
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
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------
echo Выберите операцию:
echo ------------------
echo.
echo Работа с антивирусными базами Dr.Web:
echo.
echo [ lb ] Скачать антивирусные базы Dr.Web
echo [ ub ] Разархивировать скаченные базы Dr.Web и удалить файл архива
echo [ cb ] Копировать антивирусные базы Dr.Web с флешки на диск (в директорию–источник)
echo.
echo Работа с репозиторием Dr.Web:
echo.
echo [ lr ] Скачать репозиторий Dr.Web
echo [ cr ] Копировать репозиторий Dr.Web с флешки на диск (в директорию–источник)
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
if exist %DWEB_BASES_DOWNLOAD_DIR% (rd %DWEB_BASES_DOWNLOAD_DIR% /s /q)
if not exist %DWEB_BASES_DOWNLOAD_DIR% (md %DWEB_BASES_DOWNLOAD_DIR%)
echo.
echo -------------------------------------------
echo Начинается скачивание, пожалуйста, ждите...
echo -------------------------------------------
echo.
curl -o "%DWEB_BASES_DOWNLOAD_FILE%" "%DWEB_BASES_URL%"
if ERRORLEVEL 1 GOTO ErrNoCurlDWEB
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
"%WINRAR_WORK_FILE%" x %DWEB_BASES_DOWNLOAD_FILE% %DWEB_BASES_DOWNLOAD_DIR%
if ERRORLEVEL 1 GOTO QuestDWEB
::"%WINRAR_WORK_FILE%" x -ibck %DWEB_BASES_DOWNLOAD_FILE% %DWEB_BASES_SRV_DIST_DIR%
::Ключь -ibck перемещает окно прогресса в трей
if not exist %DWEB_ZIPFILES_ARCH_DIR% (md %DWEB_ZIPFILES_ARCH_DIR%)
move /y %DWEB_BASES_DOWNLOAD_FILE% %DWEB_ZIPFILES_ARCH_DIR%
echo.
pause
GOTO QuestDWEB

:CopyBasesDWEB
cls
if not exist "%DWEB_BASES_DOWNLOAD_DIR%" GOTO ErrNoDirOnFlashDWEB
echo.
echo ------------------------------------------------
echo Начинается копирование баз, пожалуйста, ждите...
echo ------------------------------------------------
echo.
::rd %DWEB_BASES_SRV_DIST_DIR% /s /q
if not exist %DWEB_BASES_SRV_DIST_DIR% (md %DWEB_BASES_SRV_DIST_DIR%)
xcopy %DWEB_BASES_DOWNLOAD_DIR% %DWEB_BASES_SRV_DIST_DIR% /e /y
echo.
pause
GOTO QuestDWEB

:DownloadDWEBRepo
cls
if exist %DWEB_REPO_DOWNLOAD_DIR% (rd %DWEB_REPO_DOWNLOAD_DIR% /s /q)
if not exist %DWEB_REPO_DOWNLOAD_DIR% (md %DWEB_REPO_DOWNLOAD_DIR%)
echo.
echo -------------------------------------------
echo Начинается скачивание, пожалуйста, ждите...
echo -------------------------------------------
echo.
curl -o "%DWEB_REPO_DOWNLOAD_FILE%" "%DWEB_REPO_URL%"
if ERRORLEVEL 1 GOTO ErrNoCurlDWEB
echo.
pause
GOTO QuestDWEB

:CopyRepoDWEB
cls
if not exist "%DWEB_REPO_DOWNLOAD_DIR%\*repository*.zip" GOTO ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo Начинается копирование репозитория, пожалуйста, ждите...
echo --------------------------------------------------------
echo.
rd %DWEB_REPO_SRV_DIST_DIR% /s /q
if not exist %DWEB_REPO_SRV_DIST_DIR% (md %DWEB_REPO_SRV_DIST_DIR%)
xcopy %DWEB_REPO_DOWNLOAD_DIR%\*repository*.zip %DWEB_REPO_SRV_DIST_DIR% /e /y
echo.
pause
GOTO QuestDWEB

:RestoreDWEB
cls
if not exist "%DWEB_REPO_SRV_DIST_DIR%\*repository*.zip" GOTO ErrNoFileRestoreDWEB
if not exist "%DWEB_UTIL_WORK_FILE%" GOTO ErrNoUtilFileDWEB
echo.
echo -----------------------------------------------------------
echo Начинается восстановление репозитория, пожалуйста, ждите...
echo -----------------------------------------------------------
echo.
"%DWEB_UTIL_WORK_FILE%" restorerepo "%DWEB_REPO_SRV_DIST_DIR%\es1100_repository_fstek2019dec.zip"
echo.
pause
GOTO QuestDWEB
::Блок работы с DWEB END

::Блок обработки ошибок START
:ErrNoFileCopyKAVtoDisk
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %KAV_BASES_DOWNLOAD_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestKAV

:ErrNoFileCopyKAVtoFlash
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %KAV_BASES_CLI_SRC_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestKAV

:ErrNoCurlDWEB
echo.
echo -----------------------------------------------
echo Ошибка скачивания. Обратитесь к администратору.
echo -----------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoDirOnFlashDWEB
echo.
echo --------------------------------------------------------
echo Каталог не найден, проверьте наличие каталога на флешке:
echo %DWEB_BASES_DOWNLOAD_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %DWEB_REPO_DOWNLOAD_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileRestoreDWEB
echo.
echo --------------------------------------------------------
echo Файлы не найдены, проверьте наличие файлов в директории:
echo %DWEB_REPO_SRV_DIST_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoUtilFileDWEB
echo.
echo ------------------------------------------------------------------------------------------
echo Утилита для восстановления репозитория не найдена, проверьте ее наличие или измените путь:
echo %DWEB_UTIL_WORK_FILE%
echo ------------------------------------------------------------------------------------------
echo.
pause
GOTO QuestDWEB
::Блок обработки ошибок END

::Блок выхода из программы START
:Quit
cls
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------------------------------------------
echo Программа завершена. Для выхода нажмите любую клавишу.
echo ------------------------------------------------------
echo.
pause
exit
::Блок выхода из программы END
