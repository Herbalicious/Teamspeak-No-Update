@ECHO OFF
COLOR 0a
TITLE Teamspeak No Update
NET STOP BEEP

:GETADMIN
	>NUL 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
	
	IF '%errorlevel%' NEQ '0' (
		ECHO Requesting administrative privileges...
		GOTO UACPrompt
	) ELSE ( GOTO gotAdmin )

:UACPrompt
    ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    ECHO UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    EXIT /B

:gotAdmin
    IF EXIST "%temp%\getadmin.vbs" ( DEL "%temp%\getadmin.vbs" )
    PUSHD "%CD%"
    CD /D "%~dp0"

:: --------------------------------------- ::

:MENU
	:: Searches the host file for "TSNU" and set variable 'INS' to 1 if it is installed.
	FINDSTR /c:"TSNU" "C:\Windows\System32\drivers\etc\hosts"
	IF ERRORLEVEL 1 GOTO INS0
	IF ERRORLEVEL 0 GOTO INS1
		:INS0
			SET /A INS=0
			GOTO CONT
		:INS1
			SET /A INS=1
			GOTO CONT

	:CONT
	CLS
	IF %INS% == 1 ECHO TSNU is installed.
	IF %INS% == 0 ECHO TSNU is not installed.
	ECHO.
	ECHO What would you like to do?
	ECHO 1. Install
	ECHO 2. Uninstall
	ECHO 3. Exit
	CHOICE /C 123 /N
	
	IF ERRORLEVEL 3 GOTO END
	IF ERRORLEVEL 2 GOTO UNINSTALLHANDLER
	IF ERRORLEVEL 1 GOTO INSTALLHANDLER

:: -------------- Handlers --------------- ::

:INSTALLHANDLER
	IF %INS% == 1 GOTO INSTALLED
	IF %INS% == 0 GOTO INSTALL
	ECHO INS not set. (%INS%)
	PAUSE
	
:UNINSTALLHANDLER
	IF %INS% == 1 GOTO UNINSTALL
	IF %INS% == 0 GOTO NOTINSTALLED
	ECHO INS not set. (%INS%)
	PAUSE

:: --------------------------------------- ::

:INSTALL
	:: Add a blank link to the bottom of the 'hosts' file.
	ECHO. >> C:\Windows\System32\drivers\etc\hosts
	
	:: Add a comment to the hosts file describing what this does.
	ECHO #		[TSNU] This prevents teamspeak from asking if you want to update.  >> C:\Windows\System32\drivers\etc\hosts
	
	:: Prevent teamspeak from ever reaching the update server by rerouting it to localhost.
	ECHO 		127.0.0.1		update.teamspeak.com  >> C:\Windows\System32\drivers\etc\hosts
	ECHO 		127.0.0.1		versions.teamspeak.com  >> C:\Windows\System32\drivers\etc\hosts
	
	:: Go to the menu
	GOTO MENU

:INSTALLED
	CLS
	ECHO TSNU is already installed.
	PAUSE
	:: Go to the menu
	GOTO MENU


:: --------------------------------------- ::

:UNINSTALL
	:: Creates a temporary file (tsnu-hosts) that contains all lines except those containing "teamspeak" and blank new lines.
	:: /v = line does not contain, /r = enable regular expressions, /c: = string, '^$' = blank line, '^\ *$" = lines with only spaces
	TYPE C:\Windows\System32\drivers\etc\hosts | FINDSTR /v /r /c:"^$" /c:"^\ *$" | FINDSTR /v "teamspeak" > C:\Windows\System32\drivers\etc\tsnu-hosts
	
	:: Saves the temporary file as the hosts file, then deletes the temporary file
	XCOPY C:\Windows\System32\drivers\etc\tsnu-hosts C:\Windows\System32\drivers\etc\hosts /Y
	DEL /f C:\Windows\System32\drivers\etc\tsnu-hosts
	
	:: Go to the menu
	GOTO MENU

:NOTINSTALLED
	CLS
	ECHO TSNU is not installed.
	PAUSE
	:: Go to the menu
	GOTO MENU

:: --------------------------------------- ::


:: End the script
	:END
	timeout /t 10