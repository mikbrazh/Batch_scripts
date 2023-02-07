::AVR Update Utility v1.2.0, Script by Mikhail Brazhnik, 02/2023
@ECHO OFF

chcp 1251 > NUL

::���� ���������� START
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
::���� ���������� END

::���� ������ ��������� START
:QuestStartProg
cls
echo.
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
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
echo ������� �������� �������.
echo -------------------------
echo.
pause
GOTO QuestStartProg
::���� ������ ��������� END

::���� ������ � KAV START
echo.
:QuestCopyKAV
cls
set QUEST_COPY_KAV=NUL
echo.
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
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
set /p QUEST_COPY_KAV=">"
if %QUEST_COPY_KAV%==y GOTO CopyKAV
if %QUEST_COPY_KAV%==Y GOTO CopyKAV
if %QUEST_COPY_KAV%==n GOTO QuestStartProg
if %QUEST_COPY_KAV%==N GOTO QuestStartProg
if %QUEST_COPY_KAV%==x GOTO Quit
if %QUEST_COPY_KAV%==X GOTO Quit
echo.
:CopyKAV
if not exist "%KAV_INIT_DIR%\*" GOTO ErrNoFileCopyKAV ::�������� ������� ������
cls
rd %KAV_TARGET_DIR% /s /q
if not exist %KAV_TARGET_DIR% (md %KAV_TARGET_DIR%)
xcopy %KAV_INIT_DIR% %KAV_TARGET_DIR% /e
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
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------
echo �������� ��������:
echo ------------------
echo.
echo ������ � ������������� ������ Dr.Web:
echo.
echo [ lb ] ������� ������������ ���� Dr.Web
echo [ ub ] ��������������� ��������� ������������ ���� Dr.Web � ������� ���� ������
echo [ cb ] ���������� ������������ ���� Dr.Web � ������ � �������������������
echo.
echo ������ � ������������ Dr.Web:
echo.
echo [ lr ] ������� ����������� Dr.Web
echo [ cr ] ���������� ����������� Dr.Web � ������ � �������������������
echo [ re ] ������������ ����������� �� ������������������� �� ������� Dr.Web
echo.
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
echo ������� �������� �������.
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
echo ���������� ����������, ����������, �����...
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
"%WINRAR_WORK_FILE%" x %DWEB_BASES_TARGET_FILE% %DWEB_BASES_TARGET_DIR%
rem "%WINRAR_WORK_FILE%" x -ibck %DWEB_BASES_TARGET_FILE% %DWEB_BASES_TARGET_DIR%
rem ����� -ibck ���������� ���� ��������� � ����
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
echo ���������� ����������, ����������, �����...
echo -------------------------------------------
echo.
curl -o "%DWEB_REPO_TARGET_FILE%" "%DWEB_REPO_URL%"
echo.
pause
GOTO QuestDWEB

:CopyRepoDWEB
cls
if not exist "%DWEB_INIT_DIR%\*repository*.zip" GOTO ErrNoFileCopyDWEB ::�������� ������� ������
echo.
echo --------------------------------------------------------
echo ���������� ����������� �����������, ����������, �����...
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
if not exist "%DWEB_TARGET_DIR%\*repository*.zip" GOTO ErrNoFileRestoreDWEB ::�������� ������� ������
if not exist "%DWEB_UTIL_DIR%" GOTO ErrNoUtilFileDWEB ::�������� ������� ������
echo.
echo -----------------------------------------------------------
echo ���������� �������������� �����������, ����������, �����...
echo -----------------------------------------------------------
echo.
"%DWEB_UTIL_DIR%" restorerepo "%DWEB_TARGET_DIR%\es1100_repository_fstek2019dec.zip"
echo.
pause
GOTO QuestDWEB
::���� ������ � DWEB END

::���� ��������� ������ START
:ErrNoFileCopyKAV
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %KAV_INIT_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestCopyKAV

:ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %DWEB_INIT_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileRestoreDWEB
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %DWEB_TARGET_DIR%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoUtilFileDWEB
echo.
echo ------------------------------------------------------------------------------------------
echo ������� ��� �������������� ����������� �� �������, ��������� �� ������� ��� �������� ����:
echo %DWEB_UTIL_DIR%
echo ------------------------------------------------------------------------------------------
echo.
pause
GOTO QuestDWEB
::���� ��������� ������ END

::���� ������ �� ��������� START
:Quit
cls
echo.
echo AVR Update Utility v1.1.0, Script by Mikhail Brazhnik, 02/2023
echo.
echo ------------------------------------------------------
echo ��������� ���������. ��� ������ ������� ����� �������.
echo ------------------------------------------------------
echo.
pause
exit
::���� ������ �� ��������� END
