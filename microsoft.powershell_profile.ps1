# profile script

[CmdletBinding()]

param (

)

# Allows more items to be displayed when a property contains more than one value: https://blogs.technet.microsoft.com/heyscriptingguy/2011/11/20/change-a-powershell-preference-variable-to-reveal-hidden-data/.
$FormatEnumerationLimit = 8

$currentPrincipal = New-Object -ErrorAction Stop -TypeName Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$UserIsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$userRole = $null

if ($false -eq $UserIsAdmin) {

    $userRole = 'User', 'White'

}
else {

    Write-Host -ForegroundColor Yellow "[$($MyInvocation.MyCommand.Name)]: Session is running with administrator privileges."

    $userRole = 'Administrator', 'Yellow'
    
}

function prompt {

    # set Window Title
    $host.UI.RawUI.WindowTitle = "$env:UserDomain\$env:UserName - $(Get-Location)"

    # Next Command
    $history = @(Get-History)

    if ($history.Count -gt 0) {

        $lastItem = $history[$history.Count - 1]
        $lastId = $lastItem.Id
    }

    $nextCommand = $lastId + 1

    Write-Host (Get-Date -Format "yyyy/MM/dd HH:mm:ss") -NoNewline -ForegroundColor Cyan
    Write-Host '::' -NoNewline
    Write-Host "$env:ComputerName" -NoNewline
    Write-Host '::' -NoNewline
    Write-Host "$env:UserDomain\$env:UserName" -ForegroundColor Cyan -NoNewline
    Write-Host -ForegroundColor $userRole[1] " ($($userRole[0]))"

    $currentLocation = Get-Location

    Write-Host -ForegroundColor Yellow -Object $currentLocation.Provider.Name -NoNewline
    Write-Host "::" -NoNewline
    Write-Host -ForegroundColor Cyan -Object $currentLocation.Path -NoNewline

    Write-Host ":$($nextCommand)>" -NoNewline

    return " "
}