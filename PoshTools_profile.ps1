<#     
 Comment     : PowerShell Profile Script.
      
 Requirements: * Powershell 5.0 or greater

#>

# global variables
$ShellCurrentUserUPN          = [Environment]::UserName +"@" + ([Environment]::UserDomainName).ToLower()
$ShellCurrentUser             = ([Environment]::UserDomainName).ToLower()  +"\" +  [Environment]::UserName
$HostName                     = [System.Net.Dns]::GetHostByName((hostname)).HostName
 
# locate user's "My Documents" folder.
$DocumentsFolder      = [Environment]::GetFolderPath("MyDocuments")
                        
# Mount Home PSdrive to the Document Library root.                        
if (Test-Path -PathType Container -Path $DocumentsFolder) 
{	    
    New-PSDrive -Name Home -PSProvider FileSystem -Root $DocumentsFolder | Out-Null
	Set-Location Home:\
}

else 
{        
    Write-Warning "The system can't find your Documents directory at $DocumentsFolder." 
}
	 
function prompt
{       
    #we run this last due to Exchange's lust for changing the prompt function :D
    
    #Set Window Title
    $host.UI.RawUI.WindowTitle = "$ENV:USERNAME@$ENV:COMPUTERNAME - $(Get-Location)"
     
    #Next Command
    $history = @(get-history)
    If ($history.Count -gt 0)
    {        
        $lastItem = $history[$history.Count - 1]
        $lastId = $lastItem.Id
    }
    $nextCommand = $lastId + 1
	
    # set prompt
    Write-Host (Get-Date -Format "yyyy/MM/dd HH:mm:ss") -NoNewline -ForegroundColor Cyan
    Write-Host "::" -NoNewline -ForegroundColor White
    Write-Host "$ENV:USERNAME@$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Cyan
    Write-Host "::" -NoNewline -ForegroundColor White
    Write-Host $(Get-Location) -ForegroundColor Cyan
     
    # check for Administrator elevation
    $wid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $prp = new-object System.Security.Principal.WindowsPrincipal($wid)
    $adm = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $IsAdmin = $prp.IsInRole($adm)
    if ($IsAdmin) 
    {       
        Write-Host ("admin:" + "$($nextCommand)>") -NoNewline -ForegroundColor White
        Return " "
    }
    else 
    {
        Write-Host ">" -NoNewline -ForegroundColor White
        Return " "
    }
}