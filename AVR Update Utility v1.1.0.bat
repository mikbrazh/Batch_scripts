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
if %QUEST_COPY_KAV%==y GOTO PerformCopyKAV
if %QUEST_COPY_KAV%==Y GOTO PerformCopyKAV
if %QUEST_COPY_KAV%==n GOTO QuestStartProg
if %QUEST_COPY_KAV%==N GOTO QuestStartProg
if %QUEST_COPY_KAV%==x GOTO Quit
if %QUEST_COPY_KAV%==X GOTO Quit
echo.
:PerformCopyKAV
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
echo [ lb ] ������� ������������ ���� Dr.Web
rem echo [ ub ] ��������������� ��������� ������������ ���� Dr.Web
echo [ lr ] ������� ����������� Dr.Web
rem echo [ ur ] ��������������� ��������� ����������� ���� Dr.Web
echo [ cb ] ���������� ������������ ���� � ������ � ������� ����������
echo [ cr ] ���������� ����������� � ������ � ������� ����������
echo [ re ] ������������ ����������� �� ������� ���������� �� ������� Dr.Web
echo [ n ]  �����
echo.
echo -------------------------
echo [ x ]  ����� �� ���������
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
echo ������� �������� �������.
echo -------------------------
echo.
pause
GOTO QuestDWEB

:QuestLoadDWEBBases
rd %DWEB_BASES_TARGET_DIR% /s /q
if not exist %DWEB_BASES_TARGET_DIR% (md %DWEB_BASES_TARGET_DIR%)
echo.
echo -------------------------------------------
echo ���������� ����������, ����������, �����...
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
echo ���������� ����������, ����������, �����...
echo -------------------------------------------
echo.
curl -o "%DWEB_REPO_TARGET_FILE%" "%DWEB_REPO_URL%"
echo.
pause
GOTO QuestDWEB

:PerformCopyBasesDWEB
rem ...
rem �������� �������� �� ������� ���������� � ������� �� ���� �� ���

:PerformCopyRepoDWEB
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

:PerformRestoreDWEB
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
