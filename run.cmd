@echo off
rem Set autorun to 0 if you do not want to start your browser automatically
set "autorun=1"

set "php=%~dp0files\php\php.exe"
set "scriptDir=%~dp0"
set serverPort=44400

cd /D "%scriptDir%"

echo UUP dump Development Server v1.0.0
echo This server is powered by PHP internal web server.
echo.
echo.
echo To browse UUP dump use your web browser.
echo.
echo Address of local UUP dump instance:
echo http://127.0.0.1:%serverPort%
echo.
echo.
echo Close this window to stop the server (may freeze)
echo.

if %autorun% EQU 1 start "" "http://127.0.0.1:%serverPort%"

:phprun
echo ----- PHP log -----
"%php%" -c "%scriptDir%files\php\php.ini" -S 0.0.0.0:%serverPort% -t "%scriptDir%src"

goto :phprun
