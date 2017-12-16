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
        $Endpoint = "v1.0/planner/plans/$Identity/buckets"
        [Planner_Bucket[]](Invoke-PlannerRestMethod -Endpoint $Endpoint -Method Get | Select-Object -ExpandProperty Value)
    }
}
