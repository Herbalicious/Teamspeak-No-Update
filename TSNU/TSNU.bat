@echo off
color 0a
findstr /c:"TSNU" "C:\Windows\System32\drivers\etc\hosts" >nul 2>&1 && (
:: Filter the host files for TSNU (teamspeak-noupdate), blank new lines, and "update.teamspeak.com", then crease a new file without those lines ('tsnu-hosts').
echo Filtering the host file for blank new lines and "teamspeak", and removing those lines from a new file.
type C:\Windows\System32\drivers\etc\hosts | findstr /v /r /c:"^$" /c:"^\ *$" | findstr /v "teamspeak" > C:\Windows\System32\drivers\etc\tsnu-hosts
:: Copy and replace the file just created with the normal hosts file
echo Overwriting the hosts file with the new file.
xcopy C:\Windows\System32\drivers\etc\tsnu-hosts C:\Windows\System32\drivers\etc\hosts /Y
:: Delete the 'tsnu-hosts' file.
echo Deleting the old file.
del /f C:\Windows\System32\drivers\etc\tsnu-hosts
echo TSNU has been removed from your hosts file. Now you can update teamspeak!
timeout /t 3
) || ( 
:: Add a blank link to the bottom of the 'hosts' file.
echo Adding a new line to your hosts file.
echo. >> C:\Windows\System32\drivers\etc\hosts
:: Add a commant to the hosts file describing what this does.
echo Writing a comment in your hosts file.
echo #		[TSNU] This prevents teamspeak from asking if you want to update.  >> C:\Windows\System32\drivers\etc\hosts
:: Prevent teamspeak from ever reaching the update server by rerouting it to localhost.
echo Redirecting update.teamspeak.com to 127.0.0.1
echo 		127.0.0.1		update.teamspeak.com  >> C:\Windows\System32\drivers\etc\hosts
echo 		127.0.0.1		versions.teamspeak.com  >> C:\Windows\System32\drivers\etc\hosts
echo TSNU has been added to your hosts file. No more annoying popups!
timeout /t 3
)