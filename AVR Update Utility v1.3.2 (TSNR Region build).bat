::AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
@ECHO OFF

chcp 1251 > NUL

rem ���������� ������� START
rem cls
rem echo ----------------------------------------------------------
rem echo ������ ������� �������������. ���������� � ��������������.
rem echo ----------------------------------------------------------
rem echo.
rem pause
rem GOTO #
rem ���������� ������� END

::���� ���������� START
::KAV
set KAV_BASES_DOWNLOAD_DIR=E:\TEMP\FD\Updates
set KAV_BASES_CLI_SRC_DIR=\\S40mkav02\_antivirus\Updates
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
::���� ���������� END

::���� ������ ��������� START
:QuestStartProg
cls
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
echo.
set QUEST_START_PROG=NUL
echo --------------------------------------------
echo � ����� ��������� �� �� ��� ������ ��������?
echo --------------------------------------------
echo.
echo �������:
echo.
echo [ ka ] ��� ������ � Kaspersky Antivirus
echo [ dw ] ��� ������ c Dr.Web
echo.
echo ------------------------
echo [ x ] ����� �� ���������
echo.
echo ����� ����� ������� ENTER
echo.
set /p QUEST_START_PROG=">"
if %QUEST_START_PROG%==ka GOTO QuestKAV
if %QUEST_START_PROG%==Ka GOTO QuestKAV
if %QUEST_START_PROG%==kA GOTO QuestKAV
if %QUEST_START_PROG%==KA GOTO QuestKAV

if %QUEST_START_PROG%==dw GOTO QuestDWEB
if %QUEST_START_PROG%==Dw GOTO QuestDWEB
if %QUEST_START_PROG%==dW GOTO QuestDWEB
if %QUEST_START_PROG%==DW GOTO QuestDWEB

if %QUEST_START_PROG%==x GOTO Quit
if %QUEST_START_PROG%==X GOTO Quit
echo.
echo -------------------------
echo ������� �������� �������.
echo -------------------------
echo.
pause
GOTO QuestStartProg
::���� ������ ��������� END

::���� ������ � KAV START
:QuestKAV

rem ���������� ������� START
rem cls
rem echo ----------------------------------------------------------
rem echo ������ ������� �������������. ���������� � ��������������.
rem echo ----------------------------------------------------------
rem echo.
rem pause
rem GOTO QuestStartProg
rem ���������� ������� END

cls
set QUEST_KAV=NUL
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
echo.
echo ------------------
echo �������� ��������:
echo ------------------
echo.
echo �������:
echo.
echo [ cf ] ����������� ������������ ���� KAV �� ������
rem echo [ cd ] C���������� ������������ ���� KAV � ������ �� ���� (� ����������-��������)
echo.
echo ------------------------
echo [ n ] �����
echo [ x ] ����� �� ���������
echo.
set /p QUEST_KAV=">"
if %QUEST_KAV%==cf GOTO QuestCopyKAVtoFlash
if %QUEST_KAV%==cF GOTO QuestCopyKAVtoFlash
if %QUEST_KAV%==Cf GOTO QuestCopyKAVtoFlash
if %QUEST_KAV%==CF GOTO QuestCopyKAVtoFlash

rem if %QUEST_KAV%==cd GOTO QuestCopyKAVtoDisk
rem if %QUEST_KAV%==cD GOTO QuestCopyKAVtoDisk
rem if %QUEST_KAV%==Cd GOTO QuestCopyKAVtoDisk
rem if %QUEST_KAV%==CD GOTO QuestCopyKAVtoDisk

if %QUEST_KAV%==n GOTO QuestStartProg
if %QUEST_KAV%==N GOTO QuestStartProg

if %QUEST_KAV%==x GOTO Quit
if %QUEST_KAV%==X GOTO Quit
echo.
echo -------------------------
echo ������� �������� �������.
echo -------------------------
echo.
pause
GOTO QuestKAV

:QuestCopyKAVtoFlash
cls
set QUEST_COPY_KAV_FLASH=NUL
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
echo.
echo ---------------------------
echo ����������� ���� �� ������?
echo ---------------------------
echo.
echo �������:
echo.
echo [ y ] ��
echo [ n ] �����
echo.
echo ------------------------
echo [ x ] ����� �� ���������
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
::rd %KAV_BASES_DOWNLOAD_DIR% /s /q �������� ��������
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
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
echo.
echo -----------------------------------------------
echo C���������� ���� � ������ � ������� ����������?
echo -----------------------------------------------
echo.
echo �������:
echo.
echo [ y ] ��
echo [ n ] �����
echo.
echo ------------------------
echo [ x ] ����� �� ���������
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
::rd %KAV_BASES_SRV_DIST_DIR% /s /q �������� ��������
if not exist %KAV_BASES_SRV_DIST_DIR% (md %KAV_BASES_SRV_DIST_DIR%)
xcopy %KAV_BASES_DOWNLOAD_DIR% %KAV_BASES_SRV_DIST_DIR% /e /y
echo.
pause
GOTO QuestStartProg
::���� ������ � KAV END

::���� ������ � DWEB START
echo.
:QuestDWEB
cls
set QUEST_DWEB=NUL
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
echo.
echo ------------------
echo �������� ��������:
echo ------------------
echo.
echo ������ � ������������� ������ Dr.Web:
echo.
echo [ lb ] ������� ������������ ���� Dr.Web
echo [ ub ] ��������������� ��������� ���� Dr.Web � ������� ���� ������
rem echo [ cb ] ���������� ������������ ���� Dr.Web � ������ �� ���� (� �������������������)
echo.
rem echo ������ � ������������ Dr.Web:
rem echo.
rem echo [ lr ] ������� ����������� Dr.Web
rem echo [ cr ] ���������� ����������� Dr.Web � ������ �� ���� (� �������������������)
rem echo [ re ] ������������ ����������� �� ������������������� �� ������� Dr.Web
rem echo.
echo -------------------------
echo [ n ]  �����
echo [ x ]  ����� �� ���������
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

rem if %QUEST_DWEB%==lr GOTO DownloadDWEBRepo
rem if %QUEST_DWEB%==Lr GOTO DownloadDWEBRepo
rem if %QUEST_DWEB%==lR GOTO DownloadDWEBRepo
rem if %QUEST_DWEB%==LR GOTO DownloadDWEBRepo

rem if %QUEST_DWEB%==cb GOTO CopyBasesDWEB
rem if %QUEST_DWEB%==Cb GOTO CopyBasesDWEB
rem if %QUEST_DWEB%==cB GOTO CopyBasesDWEB
rem if %QUEST_DWEB%==CB GOTO CopyBasesDWEB

rem if %QUEST_DWEB%==cr GOTO CopyRepoDWEB
rem if %QUEST_DWEB%==Cr GOTO CopyRepoDWEB
rem if %QUEST_DWEB%==cR GOTO CopyRepoDWEB
rem if %QUEST_DWEB%==CR GOTO CopyRepoDWEB

rem if %QUEST_DWEB%==re GOTO RestoreDWEB
rem if %QUEST_DWEB%==Re GOTO RestoreDWEB
rem if %QUEST_DWEB%==rE GOTO RestoreDWEB
rem if %QUEST_DWEB%==RE GOTO RestoreDWEB

if %QUEST_DWEB%==n GOTO QuestStartProg
if %QUEST_DWEB%==N GOTO QuestStartProg

if %QUEST_DWEB%==x GOTO Quit
if %QUEST_DWEB%==X GOTO Quit
echo.
echo -------------------------
echo ������� �������� �������.
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
echo ���������� ����������, ����������, �����...
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
echo ����������� ����� � ������� ���� ������?
echo ----------------------------------------
echo.
echo �������:
echo.
echo [ y ] ��
echo [ n ] ���
echo.
echo ------------------------
echo [ x ] ����� �� ���������
echo.
echo ����� ����� ������� ENTER
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
echo ���������� ���������� ������, ����������, �����...
echo --------------------------------------------------
echo.
"%WINRAR_WORK_FILE%" x %DWEB_BASES_DOWNLOAD_FILE% %DWEB_BASES_DOWNLOAD_DIR%
if ERRORLEVEL 1 GOTO QuestDWEB
::"%WINRAR_WORK_FILE%" x -ibck %DWEB_BASES_DOWNLOAD_FILE% %DWEB_BASES_SRV_DIST_DIR%
::����� -ibck ���������� ���� ��������� � ����
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
echo ���������� ����������� ���, ����������, �����...
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
echo ���������� ����������, ����������, �����...
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
echo ���������� ����������� �����������, ����������, �����...
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
echo ���������� �������������� �����������, ����������, �����...
echo -----------------------------------------------------------
echo.
"%DWEB_UTIL_WORK_FILE%" restorerepo "%DWEB_REPO_SRV_DIST_DIR%\es1100_repository_fstek2019dec.zip"
echo.
pause
GOTO QuestDWEB
::���� ������ � DWEB END

::���� ��������� ������ START
:ErrNoFileCopyKAVtoDisk
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %KAV_BASES_DOWNLOAD_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestKAV

:ErrNoFileCopyKAVtoFlash
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %KAV_BASES_CLI_SRC_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestKAV

:ErrNoCurlDWEB
echo.
echo -----------------------------------------------
echo ������ ����������. ���������� � ��������������.
echo -----------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoDirOnFlashDWEB
echo.
echo --------------------------------------------------------
echo ������� �� ������, ��������� ������� �������� �� ������:
echo %DWEB_BASES_DOWNLOAD_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %DWEB_REPO_DOWNLOAD_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileRestoreDWEB
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %DWEB_REPO_SRV_DIST_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoUtilFileDWEB
echo.
echo ------------------------------------------------------------------------------------------
echo ������� ��� �������������� ����������� �� �������, ��������� �� ������� ��� �������� ����:
echo %DWEB_UTIL_WORK_FILE%
echo ------------------------------------------------------------------------------------------
echo.
pause
GOTO QuestDWEB
::���� ��������� ������ END

::���� ������ �� ��������� START
:Quit
cls
echo.
echo AVR Update Utility v1.3.2, Script by Mikhail Brazhnik, 02/2023 (TSNR Region build)
echo.
echo ------------------------------------------------------
echo ��������� ���������. ��� ������ ������� ����� �������.
echo ------------------------------------------------------
echo.
pause
exit
::���� ������ �� ��������� END
