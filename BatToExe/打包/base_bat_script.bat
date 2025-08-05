::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyGExJBcUQwLCGH6uH/VRqMX06++VrA0qVfA5eZ3emueyDddA/krreYUR9HtOrMQpFB5k+PtY6+PRlWxDtW+CJciJvQveQ0WI4U5+EnJ95w==
::fBE1pAF6MU+EWH3eyGExJBcUQwLCGH6uH/VRqMX06++VrA0qVfA5eZ3emueyDddA/krreYUR9HtOrMQpFB5k+PtY6+PRlVlLuFakBYmZqwqB
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSTk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJHqF+E5wJx0UaBGWJSv3RpgT7O3p4aqwo18bVfA6ONzn94PdNO8c5lbYV5c54nV/gM4wJSwNQRCqbQQzu2FXuGC6OsKSpjDzT1iF50g1VWBsggM=
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion

:: Detect system language
for /f "tokens=2 delims==" %%A in ('wmic os get locale /value ^| findstr "Locale"') do (
    set "locale=%%A"
)

:: Set language messages (default to English)
set "err_iw5_not_found=Error: iw5sp.exe not found! Please put this program in the MW3 installation directory."
set "err_iwd_not_found=Error: main\iw_00.iwd not found! Please ensure your game files are complete."
set "err_winrar_failed=Failed to change menu background. Please read the error message."
set "msg_compressing=Adding background_image.iwi to main\iw_00.iwd..."
set "msg_success=Menu background changed successfully!"

:: Override with Chinese messages if system locale is Chinese
if "%locale%"=="0804" (
    set "err_iw5_not_found=错误: 未找到 iw5sp.exe！请将本程序存放至MW3游戏根目录。"
    set "err_iwd_not_found=错误: 未找到 main\iw_00.iwd！请确保你的游戏文件是否完整。"
    set "err_winrar_failed=菜单背景更换失败，请阅读错误信息。"
    set "msg_compressing=正在将 background_image.iwi 添加到 main\iw_00.iwd..."
    set "msg_success=菜单背景更换成功！"
)

:: Check if iw5.exe exists
if not exist "iw5sp.exe" (
    echo !err_iw5_not_found!
    pause
    exit /b 1
)

:: Check if main\iw_00.iwd exists
if not exist "main\iw_00.iwd" (
    echo !err_iwd_not_found!
    pause
    exit /b 1
)

:: Execute compression
echo !msg_compressing!
winrar.exe a .\main\iw_00.iwd background_image.iwi -apimages

if %errorlevel% equ 0 (
    echo !msg_success!
) else (
    echo !err_winrar_failed!
)

pause
