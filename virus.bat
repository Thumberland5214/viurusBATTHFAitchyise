@echo off
:: Hide the batch window using VBS
echo Set w = CreateObject("WScript.Shell") > hide.vbs
echo w.Run """" ^& WScript.Arguments(0) ^& """", 0, False >> hide.vbs
cscript //nologo hide.vbs "%~f0"
exit

:: From here on, code runs silently

:start
:: Fake error popup
echo x=msgbox("WARNING: System Error Detected!", 16, "System Alert") > %temp%\popup.vbs
start %temp%\popup.vbs

:: Open Notepad
start notepad.exe

:: Flash Caps Lock (simulate strange behavior)
set /a count=0
:toggle
set /a count+=1
if %count% GEQ 10 goto end
set "vbs=%temp%\keytoggle.vbs"
echo Set WshShell = CreateObject("WScript.Shell") > %vbs%
echo WshShell.SendKeys "{CAPSLOCK}" >> %vbs%
cscript //nologo %vbs%
timeout /t 1 >nul
goto toggle

:end
:: End prank
del %temp%\popup.vbs >nul 2>&1
del %temp%\keytoggle.vbs >nul 2>&1
exit
