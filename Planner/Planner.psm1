#requires -Module AzureAD

# module-scoped variables
$AadRedirectUri = "urn:ietf:wg:oauth:2.0:oob"
$GraphUri = "https://graph.microsoft.com"
$MSAuthority = "https://login.microsoftonline.com"

# load necessary assemblies from the AzureAD module
# these are required for authentication
$AadModule = Get-Module AzureAD -ListAvailable
Add-Type -Path (Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.dll")
Add-Type -Path (Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.Platform.dll")

# Import module commands and classes
$Paths = & {
    Get-ChildItem -Path (Join-Path $PSScriptRoot "functions") -Recurse -Filter "*.ps1"
    Get-ChildItem -Path (Join-Path $PSScriptRoot "helpers") -Recurse -Filter "*.ps1"
    Get-Item -Path (Join-Path $PSScriptRoot "classes.ps1")
}

foreach ($Script in $Paths)
{
    . $Script.FullName
}
