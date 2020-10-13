@echo off
set "php=%~dp0files\php\php.exe"
set "scriptDir=%~dp0"
set serverPort=44401

pushd "%scriptDir%"

call files\brand.cmd
echo.
echo UUP dump JSON API development
echo.
echo.
echo UUP dump JSON API instance address:
echo http://127.0.0.1:%serverPort%
echo.
echo.
echo Close this window to stop the server (may freeze)
echo.

:phprun
echo ----- PHP log -----
"%php%" -c "%scriptDir%files\php\php.ini" -S 0.0.0.0:%serverPort% -t "%scriptDir%src-jsonapi"

goto :phprun
