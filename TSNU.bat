@echo off
color 0a
title Teamspeak No Update

:: ------------- ::
:: Ask for Admin ::
:: ------------- ::

:: Check for admin permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

:: If error flag is set, we do not have admin
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
:: --------------------------------------------------- ::
:: When command prompt has admin priveleges, continue: ::
:: --------------------------------------------------- ::

:: Check if TSNU is currently enabled. (Search the hosts file for the string "TSNU")
echo Checking if TSNU is currently activated...
findstr /c:"TSNU" "C:\Windows\System32\drivers\etc\hosts" >nul 2>&1 && (

:: In the hosts file | find all lines that are not new lines | and do not contain the word teamspeak > and create a new file using those lines
echo Deactivating TSNU...
type C:\Windows\System32\drivers\etc\hosts | findstr /v /r /c:"^$" /c:"^\ *$" | findstr /v "teamspeak" > C:\Windows\System32\drivers\etc\tsnu-hosts

:: Use the new file (without new lines or lines containing "teamspeak" to replace the hosts file
xcopy C:\Windows\System32\drivers\etc\tsnu-hosts C:\Windows\System32\drivers\etc\hosts /Y

:: Delete the now duplicate file
del /f C:\Windows\System32\drivers\etc\tsnu-hosts

echo.
echo TSNU has been removed from your hosts file. It will now ask to update when launched!
timeout /t 10

) || ( 

:: Add a blank link to the bottom of the 'hosts' file.
echo Adding a new line to your hosts file.
echo. >> C:\Windows\System32\drivers\etc\hosts

:: Add a comment to the hosts file describing what this does.
echo Writing a comment in your hosts file.
echo #		[TSNU] This prevents teamspeak from asking if you want to update.  >> C:\Windows\System32\drivers\etc\hosts

:: Prevent teamspeak from ever reaching the update server by rerouting it to localhost.
echo # >> C:\Windows\System32\drivers\etc\hosts
echo Redirecting update.teamspeak.com and versions.teamspeak.com to 127.0.0.1
echo 		127.0.0.1		update.teamspeak.com  >> C:\Windows\System32\drivers\etc\hosts
echo 		127.0.0.1		versions.teamspeak.com  >> C:\Windows\System32\drivers\etc\hosts

echo.
echo TSNU has been added to your hosts file. No more annoying popups!
timeout /t 10
)