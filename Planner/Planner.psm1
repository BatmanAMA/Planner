#requires -Module AzureAD

# module-scoped variables
$AadRedirectUri = "urn:ietf:wg:oauth:2.0:oob"
$GraphUri = "https://graph.microsoft.com"
$MSAuthority = "https://login.microsoftonline.com"
$AadModule = Get-Module AzureAD -ListAvailable
$Adal = Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
$Adalforms = Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.Platform.dll"

Add-Type -Path $Adal
Add-Type -Path $AdalForms

Function Connect-Planner
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

function Get-PlannerPlan
{
    <#
    .SYNOPSIS
    Get one or more plans
    
    .DESCRIPTION
    Get one or more plans using a plan ID or an Office 365 group.
    
    .PARAMETER Identity
    The ID of the plan
    
    .PARAMETER Group
    An Office 365 to retrieve Plans for. 
    
    .EXAMPLE
    Get-Plan -Identity 8VtbYBiNt0WbPS3MALYirnUADQDX
    
    .EXAMPLE
    Get-PlannerGroup | Get-Plan
    
    .NOTES
    General notes
    #>

    [CmdletBinding(DefaultParameterSetName = "Id")]
    param
    (
        [Parameter(Mandatory, ParameterSetName = "Id")]
        $Identity,

        [Parameter(Mandatory, ParameterSetName = "Group", ValueFromPipeline)]
        $Group
    )

    process
    {
        switch ($PSCmdlet.ParameterSetName)
        {
            "Id"
            {
                $GroupId = $Group.Id
                $Uri = "{0}/{1}" -f $GraphUri, "v1.0/planner/plans/$Identity"
                irm -uri $Uri -Headers $AuthHeader
            }
    
            "Group"
            {
                $GroupId = $Group.Id
                $Uri = "{0}/{1}" -f $GraphUri, "v1.0/groups/$GroupID/planner/plans"
                irm -uri $Uri -Headers $AuthHeader | Select -ExpandProperty Value
            }
        }
    }
}

function Get-PlannerTask
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        $Identity
    )

    process
    {
        $Uri = "{0}/{1}" -f $GraphUri, "v1.0/planner/plans/$Identity/tasks"
        irm -uri $Uri -Headers $AuthHeader | Select-Object -ExpandProperty Value
    }
}

function Get-PlannerBucket
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias("Id")]
        $Identity
    )

    process
    {
        $Uri = "{0}/{1}" -f $GraphUri, "v1.0/planner/plans/$Identity/buckets"
        irm -uri $Uri -Headers $AuthHeader | Select-Object -ExpandProperty Value
    }
}

function Invoke-PlannerRestMethod
{
    [CmdletBinding()]
    param
    (
        $Endpoint,

        $Body
    )

    
}

function Get-PlannerGroup
{
    [CmdletBinding()]
    param
    (
        [string]
        $Name
    )

    $Uri = "{0}/{1}" -f $GraphUri, "v1.0/groups"
    $Groups = irm -Uri $Uri -Headers $AuthHeader |
        Select -ExpandProperty Value |
        Where-Object groupTypes -Contains "Unified"
    if ($Name) {$Groups | Where-Object displayName -Like $Name}
    else {$Groups}
}
