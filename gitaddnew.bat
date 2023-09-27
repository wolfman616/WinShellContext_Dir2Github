@echo off

setlocal enabledelayedexpansion

choice /C YN /M "Do you want to proceed?"
if !errorlevel! equ 1 (
	echo Proceeding...
	REM Add your code to execute when the user selects "Y" here
) else (
	echo Exiting...
	timeout /t 4 /nobreak > nul
	exit 0
)

current_dir=$(pwd)

directory_name=$(basename "$current_dir")


if "%~1" == "" (
	set repoName=%directory_name%
) else (
	set repoName=%~1
)
if "%~2" == "" (
	set commitMsg="Initial commit msg"
) else (
	set commitMsg=%~2
)
REM requires Github terminal to create fresh repo with gh https://github.com/settings/tokens
gh repo create %repoName% --public
git init
git remote add origin https://github.com/wolfman616/%repoName%
git add .
git commit -m %commitMsg%
git push --set-upstream origin master 
git status
timeout /t 8 /nobreak > nul
exit 0
rem if there is a bad status warn and stop
rem else


