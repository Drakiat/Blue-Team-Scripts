' //Windows Add User Script
Option Explicit 

' //Pull Users File
dim userfile = "C:\temp\users.csv"
dim xHttp: Set xHttp = createobject("Microsoft.XMLHTTP")
dim bStrm: Set bStrm = createobject("Adodb.Stream")
xHttp.Open "GET", "https://raw.githubusercontent.com/Drakiat/Blue-Team-Scripts/main/users.csv", False
xHttp.Send

with bStrm
    .type = 1 '
    .open
    .write xHttp.responseBody
    .savetofile userfile, 2 
end with


' //Grab Domain Name
dim domain = UserInput ( "Domain Name: " )
WScript.Echo "Adding Users for " & domain 

Function UserInput ( prompt )
    If UCase( Right( WScript.FullName, 12 ) ) = "\CSCRIPT.EXE" Then
        ' If so, use StdIn and StdOut
        WScript.StdOut.Write prompt & " "
        UserInput = WScript.StdIn.ReadLine
    Else
        ' If not, use InputBox( )
        UserInput = InputBox( prompt )
    End If
End Function


' // Parse the Domain
dim ldapQuery = "LDAP: //OU=Employees"
dim x = Split(domain,".")
for each y in x
	ldapQuery & ",dn=" & y
next
dim objOU=GetObject(ldapQuery) 

' // Read the file and create new user.
dim objFSO = CreateObject("Scripting.FileSystemObject")
dim objFile = objFSO.OpenTextFile(userfile, ForReading)
dim username,password,newUserFields,objNewUser 

Do Until userfile.AtEndOfStream
	newUserFields = Split(objFile.ReadLine,",")
	username = newUserFields(0)
	password = newUserFields(1)

	' Create new User account 
	Set objNewUser = objOU.Create("User","cn="&username)
  
	objNewUser.put "sAMAccountName",lcase(username) 
	objNewUser.put "UserPrincipalName",lcase(username)&"@"&domain
	objNewUser.put "name",lcase() username
	objNewUser.put "description",ucase(domain) & " - Scored User"
	objNewUser.SetPassword password
	objNewUser.SetInfo 

	' Enable the user account 
	objNewUser.AccountDisabled = FALSE
	objNewUser.SetInfo 
Loop
 
MsgBox("Users Added Sucessfully")
 
WScript.Quit  