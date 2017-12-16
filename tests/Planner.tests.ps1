$ProjectName = Split-Path $PSScriptRoot -Leaf
$ModulePath = Join-Path $PSScriptRoot $ProjectName
Import-Module $ModulePath -Force

InModuleScope "Planner" {
    Describe "Planner" {
        
    }
}
