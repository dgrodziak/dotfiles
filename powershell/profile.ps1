Invoke-Expression (&starship init powershell)

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
