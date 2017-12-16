@{
    NestedModules = "Planner.psm1"
    ModuleVersion = "0.1.0"
    Author        = "Matt McNabb"
    Copyright     = "(c) 2017 Matt McNabb. All rights reserved."
    GUID               = '457b8f27-df9e-48cc-844d-40d212e9799b'
    Description        = "A PowerShell module for managing Microsoft Planner"
    PowerShellVersion  = '5.1'
    FunctionsToExport  = @(
        "Connect-Planner"
        "Get-PlannerBucket"
        "Get-PlannerGroup"
        "Get-PlannerPlan"
        "Get-PlannerTask"
    )
    PrivateData        = @{
        PSData = @{
            Tags = @("Planner","Office365","Graph","REST","API","GraphAPI","Office","ADAL","AzureAD")
            LicenseUri = "https://github.com/mattmcnabb/Planner/blob/master/LICENSE"
            ProjectUri = "https://github.com/mattmcnabb/Planner"
            ReleaseNotes = "This is a very early draft with a few capabilities. More to come..."
        }
    }
}