@echo off
setlocal enabledelayedexpansion

REM ָ����Ҫ������ļ����
set numbers=1557 1564 1571 1574 mod_friendly_upgrade mod_friendly_health_hud

REM ȷ���ű�Ŀ¼Ϊ��ǰ����Ŀ¼
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

REM ����·������
set "COMPILED_DIR=.\compiled\iw5"
set "DEST_DIR=D:\Call of Duty - Modern Warfare 3\MW3tools\zone_raw\patch_survival"
set "DEST_AITYPE_DIR=%DEST_DIR%\aitype"

REM ��һ��������ָ���ĵ����ļ�
for %%n in (%numbers%) do (
    echo ���ڴ��� %%n.gsc ...
    
    REM ʹ��ԭʼ·��ָʾ
    .\gsctool\gsc-tool -m comp -g iw5 -s pc ".\MW3�޸��ļ�\%%n.gsc"
    
    REM ������
    if errorlevel 1 (
        echo [����]  %%n.gsc ����ʧ��!
    ) else (
        REM �ƶ��������ļ�
        if exist "%COMPILED_DIR%\%%n.gscbin" (
            move /Y "%COMPILED_DIR%\%%n.gscbin" "%DEST_DIR%\" >nul
            echo  %%n.gscbin ���ƶ�
        )
    )
)

REM �ڶ���������aitypeĿ¼�µ�����GSC�ļ�
set "aitype_dir=.\MW3�޸��ļ�\aitype"
if exist "%aitype_dir%" (
    echo.
    echo ���ڴ���aitypeĿ¼�µ�����GSC�ļ�...
    
    REM ȷ��Ŀ��Ŀ¼����
    if not exist "%DEST_AITYPE_DIR%" (
        mkdir "%DEST_AITYPE_DIR%"
    )
    
    for %%f in ("%aitype_dir%\*.gsc") do (
        echo ���ڴ��� %%~nxf ...
        .\gsctool\gsc-tool -m comp -g iw5 -s pc "%%f"
        
        if errorlevel 1 (
            echo [����]  %%~nxf ����ʧ��!
        ) else (
            REM �ƶ��������ļ�
            set "filename=%%~nf.gscbin"
            if exist "%COMPILED_DIR%\!filename!" (
                move /Y "%COMPILED_DIR%\!filename!" "%DEST_AITYPE_DIR%\" >nul
                echo ���ƶ� !filename! �� %DEST_AITYPE_DIR%
            )
        )
    )
)

echo.
echo ִ�����!
echo �ѱ��� %numbers% �б��е��ļ���aitypeĿ¼�µ�����GSC�ļ�
echo ��鿴�����Ϣȷ��ִ��״̬�Ƿ���ȷ

REM �ȴ��û����س���ȷ��
echo.
echo ���س����˳�...
pause >nul