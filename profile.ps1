# prompt
function Prompt
{
    # Datetime
    Write-Host '[' -NoNewLine;
    Write-Host "$(Get-Date -Format 'HH:mm:ss')" -NoNewLine -Foreground Green;
    Write-Host '] ' -NoNewLine;

    # Proxy indicator
    if ($env:http_proxy) {
	Write-Host "🌐 " -NoNewLine -Foreground Red;
    }
    Write-Host "$(Get-Location)" -NoNewLine;

    # Git branch
    $git_branch = ""
    git rev-parse | Out-Null
    if($?){
      $git_branch = " ( $(git branch --show-current --no-color))"
      Write-Host $git_branch -NoNewLine -Foreground Red;
    } 

    # Newline
    Write-Host ;
    Write-Host ""  -NoNewLine;
    return " "
}
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

set-alias e explorer
function reload() { ".  $env:userprofile\Documents\PowerShell\profile.ps1" }
function proxy() {
  if ($args.Length -eq 0) {
    echo "proxy [state|on|off]"
    echo $env:http_proxy
  } elseif ($args[0] -eq "on") {
    $env:proxy="http://192.168.3.48:20172";
    $env:http_proxy=$env:proxy;
    $env:https_proxy=$env:proxy;
    $env:no_proxy="127.0.0.1";
  } elseif ($args[0] -eq "off" ){
    $env:proxy="";
    $env:http_proxy=$env:proxy;
    $env:https_proxy=$env:proxy;
  } 
}


function config {
    vim ~\Documents\PowerShell\profile.ps1
}
function source {
    . ~\Documents\PowerShell\profile.ps1
}

Import-Module ZLocation


# prerequirement
#  Install-Module -Name PSReadLine
# Install-Module -Name PSFzf -AllowPrerelease
