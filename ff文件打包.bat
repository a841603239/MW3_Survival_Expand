@echo off & title MW3 .ff������ݽű�
REM ԭʼ���linker.exe -v --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/patch_survival.ff" --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/common_survival.ff" --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/common.ff" --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/common_mp.ff" patch_survival��
color 0A
SETLOCAL ENABLEDELAYEDEXPANSION

::�������� --------------------------------------------------
set "BASE_DIR=D:\Call of Duty - Modern Warfare 3"
set "LINKER=%BASE_DIR%\MW3tools\Linker.exe"
set "ZONE_NAME=patch_survival"
:: ���ʱ��ο���.ff
set "REFERENCE_ZONES[0]=%BASE_DIR%\zone\chinese\patch_survival.ff"
set "REFERENCE_ZONES[1]=%BASE_DIR%\zone\chinese\common_survival.ff"
set "REFERENCE_ZONES[2]=%BASE_DIR%\zone\chinese\common.ff"
set "REFERENCE_ZONES[3]=%BASE_DIR%\zone\chinese\common_mp.ff"

:: -------------------------------------------------
if not exist "%LINKER%" (
    echo [CRITICAL] δ�ҵ� Linker.exe
    echo ��ȷ��·��: %LINKER%
    pause
    exit /b 1
)

:: ������вο��ļ��Ƿ����
set "MISSING_FILES=0"
set "LOAD_OPTIONS="

for /f "tokens=2 delims==" %%G in ('set REFERENCE_ZONES[') do (
    if not exist "%%G" (
        echo [WARNING] δ�ҵ��ο��ļ�: %%G
        set /a "MISSING_FILES+=1"
    ) else (
        set "LOAD_OPTIONS=!LOAD_OPTIONS! --load "%%G""
    )
)

if %MISSING_FILES% equ 4 (
    echo [WARNING] δ�ҵ��κβο�.ff�ļ�
    set "LOAD_OPTIONS="
)

:: ִ�в��� -------------------------------------------------
echo [%time%] ��ʼ���� %ZONE_NAME%
echo ʹ�õĲο�.ff�ļ�:
for /f "tokens=2 delims==" %%G in ('set REFERENCE_ZONES[') do (
    if exist "%%G" echo %%G
)
echo ------------------------------------------------

:: ������Ϣ - ��ʾʵ��ִ�е�����
echo ִ������:
echo "%LINKER%" -v %LOAD_OPTIONS% %ZONE_NAME%
echo.

:: ʵ��ִ������
"%LINKER%" -v %LOAD_OPTIONS% %ZONE_NAME%

:: -------------------------------------------------
if %errorlevel% equ 0 (
    echo ------------------------------------------------
    echo [%time%] �ɹ����
    echo �����ļ�λ��:
    dir "%BASE_DIR%\MW3tools\zone_out\%ZONE_NAME%.ff" /s/b
    
    echo.
    set /p =����������ļ����Ƶ���ϷzoneĿ¼...<nul
    pause >nul
    
    rem �����ļ�����ϷzoneĿ¼
    xcopy "%BASE_DIR%\MW3tools\zone_out\%ZONE_NAME%\%ZONE_NAME%.ff*" "%BASE_DIR%\zone\chinese\" /y
    echo �ļ��Ѹ��Ƶ���ϷzoneĿ¼
) else (
    echo ------------------------------------------------
    echo [%time%] ����ʧ�ܣ�����
)

pause