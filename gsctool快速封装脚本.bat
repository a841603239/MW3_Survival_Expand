@echo off
setlocal enabledelayedexpansion

REM 指定需要处理的文件编号
set numbers=1557 1564 1571 1574 mod_friendly_upgrade mod_friendly_health_hud

REM 确保脚本目录为当前工作目录
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

REM 设置路径变量
set "COMPILED_DIR=.\compiled\iw5"
set "DEST_DIR=D:\Call of Duty - Modern Warfare 3\MW3tools\zone_raw\patch_survival"
set "DEST_AITYPE_DIR=%DEST_DIR%\aitype"

REM 第一步：处理指定的单个文件
for %%n in (%numbers%) do (
    echo 正在处理 %%n.gsc ...
    
    REM 使用原始路径指示
    .\gsctool\gsc-tool -m comp -g iw5 -s pc ".\MW3修改文件\%%n.gsc"
    
    REM 检查错误
    if errorlevel 1 (
        echo [错误]  %%n.gsc 编译失败!
    ) else (
        REM 移动编译后的文件
        if exist "%COMPILED_DIR%\%%n.gscbin" (
            move /Y "%COMPILED_DIR%\%%n.gscbin" "%DEST_DIR%\" >nul
            echo  %%n.gscbin 已移动
        )
    )
)

REM 第二步：处理aitype目录下的所有GSC文件
set "aitype_dir=.\MW3修改文件\aitype"
if exist "%aitype_dir%" (
    echo.
    echo 正在处理aitype目录下的所有GSC文件...
    
    REM 确保目标目录存在
    if not exist "%DEST_AITYPE_DIR%" (
        mkdir "%DEST_AITYPE_DIR%"
    )
    
    for %%f in ("%aitype_dir%\*.gsc") do (
        echo 正在处理 %%~nxf ...
        .\gsctool\gsc-tool -m comp -g iw5 -s pc "%%f"
        
        if errorlevel 1 (
            echo [错误]  %%~nxf 编译失败!
        ) else (
            REM 移动编译后的文件
            set "filename=%%~nf.gscbin"
            if exist "%COMPILED_DIR%\!filename!" (
                move /Y "%COMPILED_DIR%\!filename!" "%DEST_AITYPE_DIR%\" >nul
                echo 已移动 !filename! 到 %DEST_AITYPE_DIR%
            )
        )
    )
)

echo.
echo 执行完毕!
echo 已编译 %numbers% 列表中的文件和aitype目录下的所有GSC文件
echo 请查看输出信息确认执行状态是否正确

REM 等待用户按回车键确认
echo.
echo 按回车键退出...
pause >nul