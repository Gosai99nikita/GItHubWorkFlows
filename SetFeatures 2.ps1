param([string]$hostUri) 

# Run this script in a powershell like: SetFeatures.ps1 -hostUri "http://localhost:32767"
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

function CPM-Login($tenant) {
    $postParams = @{username='applicationtests@' + $tenant + '.' + $tenant;password='password'}
    Invoke-WebRequest -Uri "$($hostUri)/api/auth/credentials" -WebSession $session -Method POST -Body $postParams
}
    
function CPM-SendRequest($path) {
    Invoke-WebRequest -Uri $path -WebSession $session
}
    
function CPM-Logout() {
        Invoke-WebRequest -Uri "$($hostUri)/api/auth/logout" -WebSession $session -Method POST
}
    
Write-Output "*** Logging in: applicationtests@kghcs.kghcs ***"
CPM-Login "kghcs"

Write-Output "*** Enable all product feature flags ***"
Start-Sleep -s 2
CPM-SendRequest "$($hostUri)/api/org/test/featureflags/product/enable"

Write-Output "*** Enable all product + current tenant feature flags ***"
Start-Sleep -s 2
CPM-SendRequest "$($hostUri)/api/org/test/featureflags/tenant/enable"

Write-Output "*** Enable all product + current tenant and company feature flags ***"
Start-Sleep -s 2
CPM-SendRequest "$($hostUri)/api/org/test/featureflags/company/enable"

Write-Output "*** Enable all product features ***"
Start-Sleep -s 2
CPM-SendRequest "$($hostUri)/api/org/test/features/product/enable"

Write-Output "*** Enable all product + current company features ***"
Start-Sleep -s 2
CPM-SendRequest "$($hostUri)/api/org/test/features/company/enable"

Write-Output "*** Logging out: applicationtests@kghcs.kghcs ***"
Start-Sleep -s 2
CPM-Logout

Write-Output "*** Logging in: applicationtests@butterfly.butterfly ***"
Start-Sleep -s 2
CPM-Login "butterfly"

Write-Output "*** Enable all product + current company features ***"
Start-Sleep -s 2
CPM-SendRequest "$($hostUri)/api/org/test/featuresets/KghCS/enable"

Write-Output "*** Logging out: applicationtests@butterfly.butterfly ***"
Start-Sleep -s 2
CPM-Logout

Write-Output "Done!"