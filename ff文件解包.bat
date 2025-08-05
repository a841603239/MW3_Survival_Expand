@echo off
chcp 65001 > nul

:: 游戏安装路径
set "GAME_FOLDER=D:\Call of Duty - Modern Warfare 3"

:: Unlinker工具路径
set "UNLINKER_PATH=.\Unlinker.exe"

:: 要解包的文件（与脚本同级）
set "TARGET_FILE=.\patch_survival.ff"

:: 设置参数
set "ARGS=--verbose"
set "ARGS=%ARGS% --search-path "%GAME_FOLDER%/main;%GAME_FOLDER%/zone/chinese""

:: 执行解包命令
echo 正在解包 %TARGET_FILE% ...
"%UNLINKER_PATH%" %ARGS% "%TARGET_FILE%"

:: 暂停查看结果
pause