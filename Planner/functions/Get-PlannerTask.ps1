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
        $Endpoint = "v1.0/planner/plans/$Identity/tasks"
        [Planner_Task[]](Invoke-PlannerRestMethod -Endpoint $Endpoint -Method Get | Select-Object -ExpandProperty Value)
    }
}
