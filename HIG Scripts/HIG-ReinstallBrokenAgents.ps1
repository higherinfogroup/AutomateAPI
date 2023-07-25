param([string]$CWAUsername,[string]$CWAPassword,[string]$CWCUsername,[string]$CWCPassword)

Import-Module AutomateAPI -force

[string]$ClientID = 'bde82821-f9ab-4eba-a6ac-06e2c561b719'

[SecureString]$secureString = $CWAPassword | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$CredentialsToPass = New-Object System.Management.Automation.PSCredential -ArgumentList $CWAUsername, $secureString
Connect-AutomateAPI -Server "connect.higherinfogroup.com" -Credential $CredentialsToPass -ClientID $ClientID

[SecureString]$secureString = $CWCPassword | ConvertTo-SecureString -AsPlainText -Force 
[PSCredential]$CredentialsToPass = New-Object System.Management.Automation.PSCredential -ArgumentList $CWCUserName, $secureString
Connect-ControlAPI -Credential  $CredentialsToPass -Server https://hig.support 

Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Reinstall -Confirm:$false > C:\HIG\Reinstall_Completed.txt
