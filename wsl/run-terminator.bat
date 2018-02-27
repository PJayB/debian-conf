@echo off
tasklist /FI "IMAGENAME eq vcxsrv.exe" 2>NUL | find /I /N "vcxsrv.exe">NUL
if "%ERRORLEVEL%"=="1" (
  cd /d "C:\Program Files\VcXsrv\"
  start vcxsrv.exe :0 -ac -terminate -lesspointer -multiwindow -clipboard -wgl
  timeout 2 > NUL
)

tasklist /FI "IMAGENAME eq bash.exe" 2>NUL | find /I /N "bash.exe">NUL
if "%ERRORLEVEL%"=="1" (
  cd /d "c:\windows\system32\"
  start /min "" bash.exe ~
  timeout 2 > NUL
)

bash ~ -c "DISPLAY=\":0.0\" terminator&"
