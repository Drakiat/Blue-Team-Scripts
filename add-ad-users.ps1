
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/ad-users.csv', 'ad-users.csv')"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/ad-users.csv -OutFile ad-users.csv"

$Users = Import-Csv -Delimiter "," -Path "ad-users.csv"

foreach ($User in $Users){
    net user $User.username $User.password /add /domain
}

exit