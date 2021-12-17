@echo off
setLocal EnableDelayedExpansion
if "%~1"=="" (
    echo To output the help, pass the argument "/?".
    goto exit
)

if "%~1"=="/?" (
    echo This program prints the absolute path to external commands. Pass the command name as an argument.
	goto exit
)

help | findstr /B /I "%~1\>" 
if %ERRORLEVEL% == 0 (
    if not exist C:\Windows\System32\%~1 (
		echo Internal command
        goto exit
	)
) else (
	if exist %CD%\%~1 (
		echo %CD%\%~1
		echo It`s external command
		goto exit
	) else (
		for %%K in ("%PATHEXT:;=" "%") do (
			if exist "%CD%\%~1%%~K" (
				echo %CD%\%~1%%~K
				echo It`s external command
				goto exit
				)
			)
		)
	
	for /D %%B in ("%PATH:;=" "%") do (
		if exist %%~B\%~1 (
			echo %%~B\%~1
			echo It`s external command
			goto exit
		) else (
			for %%K in ("%PATHEXT:;=" "%") do (
				if exist "%%~B\%~1%%~K" (
					echo %%~B\%~1%%~K
					echo It`s external command
					goto exit
				)
			)
		)
	)
	echo Error: not found 	
)

:exit