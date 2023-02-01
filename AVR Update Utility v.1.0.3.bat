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


::���� ������ ��������� START
:QuestStartProg
cls
echo.
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
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
echo [ x ]  ��� ������ �� ���������
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
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
echo -----------------------------------------------
echo C���������� ���� � ������ � ������� ����������?
echo -----------------------------------------------
echo.
echo �������:
echo.
echo [ y ] ��
echo [ n ] �����
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
if not exist "%KAV_INIT_PATH%\*" GOTO ErrNoFileCopyKAV ::�������� ������� ������
cls
rd %KAV_TARGET_PATH% /s /q
if not exist %KAV_TARGET_PATH% (md %KAV_TARGET_PATH%)
xcopy %KAV_INIT_PATH% %KAV_TARGET_PATH% /e
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
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
echo ------------------
echo �������� ��������:
echo ------------------
echo.
echo [ lb ] ��� c��������� ������������ ��� Dr.Web
echo [ lr ] ��� c��������� ������������ ��� Dr.Web
echo [ cp ] ���������� ����������� � ������ � ������� ����������
echo [ re ] ������������ ����������� �� ������� ���������� �� ������� Dr.Web
echo [ n ]  �����
echo [ x ]  ����� �� ���������
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
echo ������� �������� �������.
echo -------------------------
echo.
pause
GOTO QuestDWEB

:QuestLoadDWEBBases
curl -o "%DWEB_BASES_TARGET_PATH%" "%DWEB_BASES_URL%"

:QuestLoadDWEBRepo
rem ...

:PerformCopyDWEB
if not exist "%DWEB_INIT_PATH%\*repository*.zip" GOTO ErrNoFileCopyDWEB ::�������� ������� ������
echo.
echo --------------------------------------------------------
echo ���������� ����������� �����������, ����������, �����...
echo --------------------------------------------------------
echo.
rd %DWEB_TARGET_PATH% /s /q
if not exist %DWEB_TARGET_PATH% (md %DWEB_TARGET_PATH%)
xcopy %DWEB_INIT_PATH%\*repository*.zip %DWEB_TARGET_PATH% /e
echo.
pause
GOTO QuestDWEB

:PerformRestoreDWEB
if not exist "%DWEB_TARGET_PATH%\*repository*.zip" GOTO ErrNoFileRestoreDWEB ::�������� ������� ������
if not exist "%DWEB_UTIL_PATH%" GOTO ErrNoUtilFileDWEB ::�������� ������� ������
echo.
echo -----------------------------------------------------------
echo ���������� �������������� �����������, ����������, �����...
echo -----------------------------------------------------------
echo.
"%DWEB_UTIL_PATH%" restorerepo "%DWEB_TARGET_PATH%\es1100_repository_fstek2019dec.zip"
echo.
pause
GOTO QuestDWEB
::���� ������ � DWEB END

::���� ��������� ������ START
:ErrNoFileCopyKAV
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %KAV_INIT_PATH%
echo --------------------------------------------------------
echo.
pause
GOTO QuestCopyKAV

:ErrNoFileCopyDWEB
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %DWEB_INIT_PATH%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoFileRestoreDWEB
echo.
echo --------------------------------------------------------
echo ����� �� �������, ��������� ������� ������ � ����������:
echo %DWEB_TARGET_PATH%
echo --------------------------------------------------------
echo.
pause
GOTO QuestDWEB

:ErrNoUtilFileDWEB
echo.
echo ------------------------------------------------------------------------------------------
echo ������� ��� �������������� ����������� �� �������, ��������� �� ������� ��� �������� ����:
echo %DWEB_UTIL_PATH%
echo ------------------------------------------------------------------------------------------
echo.
pause
GOTO QuestDWEB
::���� ��������� ������ END

::���� ������ �� ��������� START
:Quit
cls
echo.
echo AVR Update Utility v.1.0.3, Script by Mikhail Brazhnik, 10/2022
echo.
echo ------------------------------------------------------
echo ��������� ���������. ��� ������ ������� ����� �������.
echo ------------------------------------------------------
echo.
pause
exit
::���� ������ �� ��������� END
