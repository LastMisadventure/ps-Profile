# profile script

# Set-up Shell Window and Colors
$PowerShellTerminalUI = (Get-Host).UI.RawUI
$PowerShellTerminalUI.ForegroundColor = 'White'
$PowerShellTerminalUI.BackgroundColor = 'Black'
$PowerShellTerminalUI.WindowTitle = 'PS(5.1\Windows)'
$PowershellTerminalBufferNewSize = $PowerShellTerminalUI.buffersize
$PowershellTerminalBufferNewSize.Height = 1024
$PowershellTerminalBufferNewSize.Width = 512
$PowerShellTerminalUI.BufferSize = $PowershellTerminalBufferNewSize

# Change the colors for the progress bar
$Host.PrivateData.ProgressForegroundColor = "Black"
$Host.PrivateData.ProgressBackgroundColor = "White"

# Change the default colors for Warnings, Errors, and Verbose Messages
$Host.PrivateData.WarningBackgroundColor = "Black"
$Host.PrivateData.WarningForegroundColor = "Yellow"
$Host.PrivateData.VerboseBackgroundColor = "Black"
$Host.PrivateData.VerboseForegroundColor = "DarkCyan"
$Host.PrivateData.ErrorBackgroundColor = "Black"
$Host.PrivateData.ErrorForegroundColor = "Red"
$Host.PrivateData.DebugBackgroundColor = "Black"
$Host.PrivateData.DebugForegroundColor = "Gray"

$FormatEnumerationLimit = -1

# clear the screen to 'apply' above changes.
Clear-Host

function prompt {

    # set Window Title
    $host.UI.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME - $(Get-Location)"

    # Next Command
    $history = @(Get-History)

    if ($history.Count -gt 0) {

        $lastItem = $history[$history.Count - 1]
        $lastId = $lastItem.Id
    }

    $nextCommand = $lastId + 1

    Write-Host (Get-Date -Format "yyyy/MM/dd HH:mm:ss") -NoNewline -ForegroundColor Cyan
    Write-Host "::" -NoNewline -ForegroundColor White
    Write-Host "$ENV:USERNAME@$ENV:COMPUTERNAME" -ForegroundColor Cyan

    $currentLocation = Get-Location

    Write-Host -ForegroundColor Yellow -Object $currentLocation.Provider.Name -NoNewline
    Write-Host "::" -NoNewline -ForegroundColor White
    Write-Host -ForegroundColor Cyan -Object $currentLocation.Path -NoNewline

    Write-Host ":$($nextCommand)>" -NoNewline -ForegroundColor White

    return " "
}