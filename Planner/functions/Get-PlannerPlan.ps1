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
                $Endpoint = "v1.0/planner/plans/$Identity"
                Invoke-PlannerRestMethod -Endpoint $Endpoint -Method Get
            }
    
            "Group"
            {
                $GroupId = $Group.Id
                $Endpoint = "v1.0/groups/$GroupID/planner/plans"
                [Planner_Plan[]](Invoke-PlannerRestMethod -Endpoint $Endpoint -Method Get | Select-Object -ExpandProperty Value)
            }
        }
    }
}
