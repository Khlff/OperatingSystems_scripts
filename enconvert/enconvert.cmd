@echo off
setLocal enableextensions enabledelayedexpansion
if "%~1"=="" (
    echo To output the help, pass the argument "/?".
    goto exit
)

if "%~1"=="/?" (
    echo This program changes the encoding of all .txt files from cp866 to UTF-8 in the folder and subfolders in the passed directory.
    echo For example: H:\test
    goto exit
)

mkdir C:\Temp

for /R %~1 %%B in (*.txt) do (
    set "pathHelpful=%%~dB%%~pB"
    set "path=!pathHelpful:~0,-1!"
    if not exist C:\Temp\%%~nB%%~xB (
        win_iconv -f cp866 -t UTF-8 "%%~dB%%~pB%%~nB%%~xB" > "C:\Temp\%%~nB%%~xB"
        replace C:\Temp\%%~nB%%~xB !path!

    ) else (
        replace C:\Temp\%%~nB%%~xB !path!
    )
)
del /q/f/s C:\Temp\*
rmdir C:\Temp
:exit