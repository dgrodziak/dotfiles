# Note: I might need to install the package provider NuGet and/or PowerShellGet
# in order to install posh-git.

##################################################
# Install posh-git for convenient Git integration
##################################################
# Install-Module -Name posh-git -Force -Scope CurrentUser
Import-Module posh-git -ErrorAction SilentlyContinue
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptPrefix = '`n'

function prompt {
    $lastCommand = Get-History -Count 1
    if($lastCommand) {
        $executionTime = $lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime
	$executionTimeMS = $executionTime.TotalMilliseconds
	if ( $executionTimeMS -gt 60000 ) {
            $timeStr = ' (' + $executionTime.ToString("hh\:mm\:ss") + ')'
	}
	elseif ( $executionTimeMS -gt 1000 ) {
            $timeStr = ' (' + [math]::Round($executionTimeMS / 1000, 2) + "s)"
	}
	else {
            $timeStr = ' (' + [math]::Round($executionTimeMS, 0) + 'ms)'
	}
    }
    else { 
	$timeStr = '' 
    }
    $GitPromptSettings.DefaultPromptBeforeSuffix.Text = $timeStr + '`n'
    & $GitPromptScriptBlock
} 

##################################################
# Import conda PowerShell objects 
##################################################
& C:\Users\dgrodziak\miniconda3\shell\condabin\conda-hook.ps1


##################################################
# Custom (vim-like) key bindings using PSReadLine 
##################################################

Import-Module PSReadLine
Set-PSReadlineOption -EditMode vi 
$env:VISUAL = (gcm vim).Source

# The following command will show all available key bindings
# Get-PSReadLineKeyHandler -Bound -Unbound
Set-PSReadlineKeyHandler -Chord 'Ctrl+''' -Function ViCommandMode
Set-PSReadLineKeyHandler -Key ',,y' -Function Copy -ViMode Command
Set-PSReadLineKeyHandler -Key ',,p' -Function Paste -ViMode Command
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+d -Function ScrollDisplayDown -ViMode Command
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+u -Function ScrollDisplayUp -ViMode Command
