function Connect-Planner
{
    <#
          .SYNOPSIS
          Connect to Microsoft Planner via the Graph API
          .DESCRIPTION
          Connect to Microsoft Planner via the Graph API. Requires that an application be registered in Azure Active Directory and that you know that application's ID. For more information about registering an application, run Get-Help about_Planner_Register.
          .EXAMPLE
          $Credential = Get-Credential
          $ClientId = 'f338765e-1cg71-427c-a14a-f3d542442dd'
          $AuthToken = Connect-Planner -Credential $Credential -ClientId $ClientId
          .EXAMPLE
          $ClientId = 'f338765e-1cg71-427c-a14a-f3d542442dd'
          $AuthToken = Connect-Planner -ClientId $ClientId -TenantName domain.onmicrosoft.com
          .LINK
          https://github.com/microsoftgraph/powershell-intune-samples/blob/master/Authentication/Auth_From_File.ps1
          http://www.powershell.no/azure,graph,api/2017/10/30/unattended-ms-graph-api-authentication.html
      #>

    [cmdletbinding(DefaultParameterSetName = "ADAL")]
    param
    (
        [Parameter(Mandatory = $true, ParameterSetName = 'PSCredential')]
        [PSCredential] $Credential,
        [Parameter(Mandatory = $true)]
        [String]$ClientId,
        [Parameter(Mandatory = $true, ParameterSetName = 'ADAL')]
        [String]$TenantName
    )

    try
    {
        switch ($PsCmdlet.ParameterSetName)
        {
            'ADAL'
            {
                $Authority = "{0}/{1}" -f $MSAuthority, $TenantName
                $AuthContext = [Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext]::new($Authority)
                $PlatformParameters = [Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters]::new("Always")
                $AuthResult = ($AuthContext.AcquireTokenAsync($GraphUri, $ClientID, $AadRedirectUri, $PlatformParameters)).Result
            }

            'PSCredential'
            {
                $userUpn = New-Object "System.Net.Mail.MailAddress" -ArgumentList $Credential.Username
                $TenantName = $userUpn.Host
                $Authority = "{0}/{1}" -f $MSAuthority, $TenantName
                $AuthContext = [Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext]::new($Authority)
                $PlatformParameters = [Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters]::new("Auto")
                $UserCredentials = [Microsoft.IdentityModel.Clients.ActiveDirectory.UserPasswordCredential]::new($Credential.Username, $Credential.Password)
                $AuthResult = [Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContextIntegratedAuthExtensions]::AcquireTokenAsync($AuthContext, $GraphUri, $ClientId, $UserCredentials)
                if ($AuthResult.Exception)
                {
                    throw "An error occured getting access token: $($AuthResult.Exception.InnerException)"
                }
            }
        }

        $Script:AuthHeader = @{
            'Content-Type'  = 'application/json'
            'Authorization' = "Bearer " + $AuthResult.Result.AccessToken
            'ExpiresOn'     = $AuthResult.Result.ExpiresOn
        }
    }
    catch
    {
        $PsCmdlet.ThrowTerminatingError($_)
    }
}
