@echo off
set RESTVAR=
set LASTVAR=
:loop1
if "%1"=="" goto after_loop
	set RESTVAR=%RESTVAR% %LASTVAR%
	set LASTVAR=%1
	shift
goto loop1

:after_loop

if "%LASTVAR%"=="" (
	echo Specify build dir!
	exit /b 1
)
if not exist "%LASTVAR%" mkdir %LASTVAR%
cmd /V /C "cd %LASTVAR% && latexmkmod -r ../.latexmkmodrc ../tex/rpz.tex %RESTVAR%"
