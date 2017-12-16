function Invoke-PlannerRestMethod
{
    [CmdletBinding()]
    param
    (
        [string]
        $Endpoint,

        [string]
        $Method = "Get"
    )

    $Uri = "{0}/{1}" -f $GraphUri, $Endpoint
    Invoke-RestMethod -Uri $Uri -Method $Method -Headers $AuthHeader
}
