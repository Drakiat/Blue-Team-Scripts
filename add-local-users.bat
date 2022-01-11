@echo off
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/users.csv', 'users.csv')"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/users.csv -OutFile users.csv"

FOR /F "tokens=1,2 delims=," %%username %%password IN (users.csv) DO net user %%username %%password /add

exit