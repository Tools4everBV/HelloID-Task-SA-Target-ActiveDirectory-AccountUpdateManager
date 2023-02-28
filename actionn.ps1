# HelloID-Task-SA-Target-ActiveDirectory-AccountUpdateManager
#############################################################
# Form mapping
$formObject = @{
    UserPrincipalName        = $form.UserPrincipalName
    ManagerUserPrincipalName = $form.ManagerUserPrincipalName
}

try {
    Write-Information "Executing ActiveDirectory action: [UpdateManager] for: [$($formObject.UserPrincipalName)]"
    Import-Module ActiveDirectory -ErrorAction Stop
    $user = Get-ADUser -Filter "userPrincipalName -eq '$($formObject.UserPrincipalName)'"
    $manager = Get-ADUser -Filter "userPrincipalName -eq '$($formObject.ManagerUserPrincipalName)'"
    if ($null -ne $user -and $null -ne $manager) {
        $null = Set-ADUser -Identity $User -Manager $manager
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.UserPrincipalName)
            TargetIdentifier  = ($user).SID.value
            Message           = "ActiveDirectory action: [UpdateManager] for: [$($formObject.UserPrincipalName)] executed successfully"
            IsError           = $false
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "ActiveDirectory action: [UpdateManager] for: [$($formObject.UserPrincipalName)] executed successfully"
    } elseif (-not($user)) {
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.UserPrincipalName)
            TargetIdentifier  = ($user).SID.value
            Message           = "An ActiveDirectory account for: [$($formObject.UserPrincipalName)] does not exist"
            IsError           = $true
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "An ActiveDirectory account for: [$($formObject.UserPrincipalName)] does not exist"
    } elseif (-not($manager)) {
        $auditLog = @{
            Action            = 'UpdateAccount'
            System            = 'ActiveDirectory'
            TargetDisplayName = $($formObject.managerUserPrincipalName)
            TargetIdentifier  = ($user).SID.value
            Message           = "An ActiveDirectory account for: [$($formObject.ManagerUserPrincipalName)] does not exist"
            IsError           = $true
        }
        Write-Information -Tags 'Audit' -MessageData $auditLog
        Write-Information "An ActiveDirectory account for: [$($formObject.ManagerUserPrincipalName)] does not exist"
    }
} catch {
    $ex = $_
    $auditLog = @{
        Action            = 'UpdateAccount'
        System            = 'ActiveDirectory'
        TargetDisplayName = $($formObject.UserPrincipalName)
        TargetIdentifier  = ($user).SID.value
        Message           = "Could not execute ActiveDirectory action: [UpdateManager] for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute ActiveDirectory action: [UpdateManager] for: [$($formObject.UserPrincipalName)], error: $($ex.Exception.Message)"
}
#############################################################
