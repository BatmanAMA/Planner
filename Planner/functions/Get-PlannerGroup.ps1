function Get-PlannerGroup
{
    [CmdletBinding()]
    param
    (
        [string]
        $Name
    )

    $Endpoint = "v1.0/groups"
    $Groups = Invoke-PlannerRestMethod -Endpoint $Endpoint -Method Get |
        Select-Object -ExpandProperty Value |
        Where-Object groupTypes -Contains "Unified"

    if ($Name)
    {
        [Planner_Group]($Groups | Where-Object displayName -Like $Name)
    }
    else
    {
        [Planner_Group[]]$Groups
    }
}
