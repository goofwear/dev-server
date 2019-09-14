@echo off
set "aria2=%~dp0files\aria2c\aria2c.exe"
set "a7z=%~dp0files\7za.exe"
set "php=%~dp0files\php\php.exe"
set "scriptDir=%~dp0"

pushd "%scriptDir%"
set "tmpfile=tmp%random%.txt"

del "%scriptDir%tmp*.txt" 2>NUL
rmdir /Q /S "%scriptDir%tmp" 2>NUL
rmdir /Q /S "%scriptDir%src" 2>NUL
rmdir /Q /S "%scriptDir%src-jsonapi" 2>NUL

echo Downloading updated archives...

rem website-master
echo https://github.com/uup-dump/website/archive/master.zip>"%scriptDir%\%tmpfile%"
echo   out=website-master.zip>>"%scriptDir%\%tmpfile%"
echo.>>"%scriptDir%\%tmpfile%"

rem api-master
echo https://github.com/uup-dump/api/archive/master.zip>>"%scriptDir%\%tmpfile%"
echo   out=api-master.zip>>"%scriptDir%\%tmpfile%"
echo.>>"%scriptDir%\%tmpfile%"

rem json-api-master
echo https://github.com/uup-dump/json-api/archive/master.zip>>"%scriptDir%\%tmpfile%"
echo   out=json-api-master.zip>>"%scriptDir%\%tmpfile%"
echo.>>"%scriptDir%\%tmpfile%"

rem autodl_files-master
echo https://github.com/uup-dump/autodl_files/archive/master.zip>>"%scriptDir%\%tmpfile%"
echo   out=autodl_files-master.zip>>"%scriptDir%\%tmpfile%"
echo.>>"%scriptDir%\%tmpfile%"

rem fileinfo-master
echo https://github.com/uup-dump/fileinfo/archive/master.zip>>"%scriptDir%\%tmpfile%"
echo   out=fileinfo-master.zip>>"%scriptDir%\%tmpfile%"
echo.>>"%scriptDir%\%tmpfile%"

rem packs-master
echo https://github.com/uup-dump/packs/archive/master.zip>>"%scriptDir%\%tmpfile%"
echo   out=packs-master.zip>>"%scriptDir%\%tmpfile%"

"%aria2%" -x16 -s16 -d"%scriptDir%tmp" -i"%scriptDir%\%tmpfile%"
if %ERRORLEVEL% NEQ 0 echo Failed to download one of files. & pause & exit /b 1
del /F /Q "%scriptDir%\%tmpfile%"

echo.
echo Extracting data...
"%a7z%" x -o"%scriptDir%tmp\extracted" "%scriptDir%tmp\website-master.zip"
"%a7z%" x -o"%scriptDir%tmp\extracted" "%scriptDir%tmp\api-master.zip"
"%a7z%" x -o"%scriptDir%tmp\extracted" "%scriptDir%tmp\json-api-master.zip"
"%a7z%" x -o"%scriptDir%tmp\extracted" "%scriptDir%tmp\autodl_files-master.zip"
"%a7z%" x -o"%scriptDir%tmp\extracted" "%scriptDir%tmp\fileinfo-master.zip"
"%a7z%" x -o"%scriptDir%tmp\extracted" "%scriptDir%tmp\packs-master.zip"

echo.
echo Copying data to target directory...

mkdir "%scriptDir%\src"
mkdir "%scriptDir%\src-jsonapi"
for /D %%i in ("%scriptDir%tmp\extracted\website-master*") do (
	del /F /Q "%%i\.gitmodules"
	xcopy /cherkyq "%%i\*" "%scriptDir%\src"
)

for /D %%i in ("%scriptDir%tmp\extracted\json-api-master*") do (
	xcopy /cherkyq "%%i\*" "%scriptDir%\src-jsonapi"
)

for /D %%i in ("%scriptDir%tmp\extracted\api-master*") do (
	del /F /Q "%%i\readme.md"
	xcopy /cherkyq "%%i\*" "%scriptDir%\src\api"
	xcopy /cherkyq "%%i\*" "%scriptDir%\src-jsonapi\api"
)

for /D %%i in ("%scriptDir%tmp\extracted\autodl_files-master*") do (
	del /F /Q "%%i\readme.md"
	xcopy /cherkyq "%%i\*" "%scriptDir%\src\autodl_files"
)

mkdir "%scriptDir%\src\fileinfo"
mkdir "%scriptDir%\src-jsonapi\fileinfo"

for /D %%i in ("%scriptDir%tmp\extracted\fileinfo-master*") do (
	xcopy /cherkyq "%%i\*" "%scriptDir%\src\fileinfo"
	xcopy /cherkyq "%%i\*" "%scriptDir%\src-jsonapi\fileinfo"
)

mkdir "%scriptDir%\src\packs"
mkdir "%scriptDir%\src-jsonapi\packs"

for /D %%i in ("%scriptDir%tmp\extracted\packs-master*") do (
	xcopy /cherkyq "%%i\*" "%scriptDir%\src\packs"
	xcopy /cherkyq "%%i\*" "%scriptDir%\src-jsonapi\packs"
)

rmdir /Q /S "%scriptDir%tmp" 2>NUL
echo.

pushd "%scriptDir%src"
"%php%" -c "%scriptDir%files\php\php.ini" "%scriptDir%files\listid.php" >NUL
popd

pushd "%scriptDir%src-jsonapi"
mkdir "cache"
copy "..\src\cache\*" "cache"
popd

echo.
echo Done.
pause

popd
exit /b
