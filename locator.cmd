@echo off

if "%~1"=="" (
    echo To output the help, pass the argument "/?".
    goto exit
)

if "%~1"=="/?" (
    echo This program prints the absolute path to external commands. Pass the command name as an argument.
	goto exit
)

help | findstr /B /I "%~1" > nul

if exist "%CD%\%~1\*" (
	echo It`s a folder!
	goto exit
)

if %ERRORLEVEL% == 0 (
	if exist C:\Windows\System32\%~1.* (
		echo External command
		goto exit
	) else (
		echo Internal command
		goto exit
    )
)


if exist %CD%\%~1 (
	echo In this directory
	echo %CD%\%~1
	goto exit
)

for %%K in ("%PATHEXT:;=" "%") do (
	if exist "%CD%\%~1%%~K" (
		echo %CD%\%~1%%~K
		echo In this directory
		goto exit
	)
)

for /D %%B in ("%PATH:;=" "%") do (
	for %%K in ("%PATHEXT:;=" "%") do (
		if exist "%%~B\%~1%%~K" (
			echo %%~B\%~1%%~K
			goto exit
		)
	)
	if exist %%~B\%~1 (
		echo %%~B\%~1
		echo It`s external command
		goto exit
	)
)
echo Error: not found 	
:exit
