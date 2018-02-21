Start-Transcript -Path C:\WindowsAzure\Logs\CustomscriptLogs.txt -Append
#Download and install git client
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://spektraazurelabs.blob.core.windows.net/aec/devopsvsts/Git-2.16.1.4-64-bit.exe","C:\Packages\Git-2.16.1.4-64-bit.exe") 
C:\Packages\Git-2.16.1.4-64-bit.exe /silent /install
#Download student files
New-Item -ItemType directory -Path C:\Hackathon
$WebClient.DownloadFile("https://cloudworkshop.blob.core.windows.net/agile-continous-delivery/Agile-Continuous-Delivery-Student%20Files-6-2017.zip","C:\Hackathon\Agile-Continuous-Delivery-Student%20Files-6-2017.zip")
#Turn off windows server inhance security of iexplorer
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
Stop-Process -Name Explorer -Force
Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
#unziping folder
$file = "C:\Hackathon\Agile-Continuous-Delivery-Student%20Files-6-2017.zip"
$destination = "C:\Hackathon\"
$shell = new-object -com shell.application
$zip = $shell.NameSpace($file)
foreach($item in $zip.items())
{
$shell.Namespace($destination).copyhere($item)
}
#Create shorcut in desktop
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\Git-Bash.lnk")
$Shortcut.TargetPath = "C:\Program Files\Git\git-bash.exe"
$Shortcut.Save()