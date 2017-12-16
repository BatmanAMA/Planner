class Planner_Plan
{
    [string]$Id
    [string]$Owner
    [string]$Title
    [Object]$CreatedBy
    [System.Nullable``1[[DateTimeOffset]]]$CreatedDateTime

    Planner_Plan ([Object]$InputObject)
    {
        $this.Id = $InputObject.id
        $this.Title = $InputObject.Title
        $this.Owner = $InputObject.Owner
        $this.CreatedBy = $InputObject.CreatedBy
        $this.CreatedDateTime = $InputObject.CreatedDateTime
    }
}

class Planner_Task
{
    [string]$Id
    [int]$ActiveChecklistItemCount
    [object]$AppliedCategories
    [string]$AssigneePriority
    [object]$Assignments
    [string]$BucketId
    [int]$ChecklistItemCount
    [object]$CompletedBy
    [System.Nullable``1[[DateTimeOffset]]]$CompletedDateTime
    [object]$ConversationThreadId
    [Object]$CreatedBy
    [System.Nullable``1[[DateTimeOffset]]]$CreatedDateTime
    [System.Nullable``1[[DateTimeOffset]]]$DueDateTime
    [bool]$HasDescription
    [int]$PercentComplete
    [string]$PlanId
    [string]$PreviewType
    [int]$ReferenceCount
    [string]$StartDateTime
    [string]$Title

    Planner_Task ([object]$InputObject)
    {
        $This.Id = $InputObject.Id
        $this.ActiveChecklistItemCount = $InputObject.ActiveChecklistItemCount
        $this.AppliedCategories = $InputObject.AppliedCategories
        $this.AssigneePriority = $InputObject.AssigneePriority
        $this.Assignments = $InputObject.Assignments
        $this.BucketId = $InputObject.BucketId
        $this.ChecklistItemCount = $InputObject.ChecklistItemCount
        $this.CompletedBy = $InputObject.CompletedBy
        $this.CompletedDateTime = $InputObject.CompletedDateTime
        $this.ConversationThreadId = $InputObject.ConversationThreadId
        $this.CreatedBy = $InputObject.CreatedBy
        $this.CreatedDateTime = $InputObject.CreatedDateTime
        $this.DueDateTime = $InputObject.DueDateTime
        $this.HasDescription = $InputObject.HasDescription
        $this.PercentComplete = $InputObject.PercentComplete
        $this.PlanId = $InputObject.PlanId
        $this.PreviewType = $InputObject.PreviewType
        $this.ReferenceCount = $InputObject.ReferenceCount
        $this.StartDateTime = $InputObject.StartDateTime
        $this.Title = $InputObject.Title
    }
}

class Planner_Bucket
{
    [string]$Id
    [string]$Name
    [string]$PlanId

    Planner_Bucket ([object]$InputObject)
    {
        $this.Id = $InputObject.Id
        $this.Name = $InputObject.Name
        $this.PlanId = $InputObject.PlanId
    }
}

class Planner_Group
{
    [string]$Id
    [System.Nullable``1[[DateTimeOffset]]]$DeletedDateTime
    [object]$Classification
    [System.Nullable``1[[DateTimeOffset]]]$CreatedDateTime
    [string]$Description
    [string]$DisplayName
    [object[]]$GroupTypes
    [string]$Mail
    [bool]$MailEnabled
    [string]$MailNickname
    [System.Nullable``1[[DateTimeOffset]]]$OnPremisesLastSyncDateTime
    [object[]]$OnPremisesProvisioningErrors
    [object]$OnPremisesSecurityIdentifier
    [object]$OnPremisesSyncEnabled
    [object]$PreferredDataLocation
    [object[]]$ProxyAddresses
    [System.Nullable``1[[DateTimeOffset]]]$RenewedDateTime
    [bool]$SecurityEnabled
    [string]$Visibility

    Planner_Group ([object]$InputObject)
    {
        $this.Id = $InputObject.Id
        $this.DeletedDateTime = $InputObject.DeletedDateTime
        $this.Classification = $InputObject.Classification
        $this.CreatedDateTime = $InputObject.CreatedDateTime
        $this.Description = $InputObject.Description
        $this.DisplayName = $InputObject.DisplayName
        $this.GroupTypes = $InputObject.GroupTypes
        $this.Mail = $InputObject.Mail
        $this.MailEnabled = $InputObject.MailEnabled
        $this.MailNickname = $InputObject.MailNickname
        $this.OnPremisesLastSyncDateTime = $InputObject.OnPremisesLastSyncDateTime
        $this.OnPremisesProvisioningErrors = $InputObject.OnPremisesProvisioningErrors
        $this.OnPremisesSecurityIdentifier = $InputObject.OnPremisesSecurityIdentifier
        $this.OnPremisesSyncEnabled = $InputObject.OnPremisesSyncEnabled
        $this.PreferredDataLocation = $InputObject.PreferredDataLocation
        $this.ProxyAddresses = $InputObject.ProxyAddresses
        $this.RenewedDateTime = $InputObject.RenewedDateTime
        $this.SecurityEnabled = $InputObject.SecurityEnabled
        $this.Visibility = $InputObject.Visibility
    }
}
