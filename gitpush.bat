@echo off

setlocal enabledelayedexpansion

choice /C YN /M "Do you want to proceed?"
if !errorlevel! equ 1 (
	echo Proceeding...
) else (
	echo Exiting...
	timeout /t 4 /nobreak > nul
	exit 0
)

REM Push to a branch with the same name as the directory
git init
git add .
if "%~1" == "" (
    set commitMsg="commit msg"
) else (
    set commitMsg=%~1
)

git commit -m %commitMsg%
git push origin master
git status
git pull origin master
git status
timeout /t 4 /nobreak > nul
exit 0

REM if there is a bad status warn and stop
REM else