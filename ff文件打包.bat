@echo off & title MW3 .ff构建快捷脚本
REM 原始命令【linker.exe -v --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/patch_survival.ff" --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/common_survival.ff" --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/common.ff" --load "D:/Call of Duty - Modern Warfare 3/zone/chinese/common_mp.ff" patch_survival】
color 0A
SETLOCAL ENABLEDELAYEDEXPANSION

::环境变量 --------------------------------------------------
set "BASE_DIR=D:\Call of Duty - Modern Warfare 3"
set "LINKER=%BASE_DIR%\MW3tools\Linker.exe"
set "ZONE_NAME=patch_survival"
:: 打包时需参考的.ff
set "REFERENCE_ZONES[0]=%BASE_DIR%\zone\chinese\patch_survival.ff"
set "REFERENCE_ZONES[1]=%BASE_DIR%\zone\chinese\common_survival.ff"
set "REFERENCE_ZONES[2]=%BASE_DIR%\zone\chinese\common.ff"
set "REFERENCE_ZONES[3]=%BASE_DIR%\zone\chinese\common_mp.ff"

:: -------------------------------------------------
if not exist "%LINKER%" (
    echo [CRITICAL] 未找到 Linker.exe
    echo 请确认路径: %LINKER%
    pause
    exit /b 1
)

:: 检查所有参考文件是否存在
set "MISSING_FILES=0"
set "LOAD_OPTIONS="

for /f "tokens=2 delims==" %%G in ('set REFERENCE_ZONES[') do (
    if not exist "%%G" (
        echo [WARNING] 未找到参考文件: %%G
        set /a "MISSING_FILES+=1"
    ) else (
        set "LOAD_OPTIONS=!LOAD_OPTIONS! --load "%%G""
    )
)

if %MISSING_FILES% equ 4 (
    echo [WARNING] 未找到任何参考.ff文件
    set "LOAD_OPTIONS="
)

:: 执行部分 -------------------------------------------------
echo [%time%] 开始处理 %ZONE_NAME%
echo 使用的参考.ff文件:
for /f "tokens=2 delims==" %%G in ('set REFERENCE_ZONES[') do (
    if exist "%%G" echo %%G
)
echo ------------------------------------------------

:: 调试信息 - 显示实际执行的命令
echo 执行命令:
echo "%LINKER%" -v %LOAD_OPTIONS% %ZONE_NAME%
echo.

:: 实际执行命令
"%LINKER%" -v %LOAD_OPTIONS% %ZONE_NAME%

:: -------------------------------------------------
if %errorlevel% equ 0 (
    echo ------------------------------------------------
    echo [%time%] 成功完成
    echo 生成文件位置:
    dir "%BASE_DIR%\MW3tools\zone_out\%ZONE_NAME%.ff" /s/b
    
    echo.
    set /p =按任意键将文件复制到游戏zone目录...<nul
    pause >nul
    
    rem 复制文件到游戏zone目录
    xcopy "%BASE_DIR%\MW3tools\zone_out\%ZONE_NAME%\%ZONE_NAME%.ff*" "%BASE_DIR%\zone\chinese\" /y
    echo 文件已复制到游戏zone目录
) else (
    echo ------------------------------------------------
    echo [%time%] 处理失败！请检查
)

pause