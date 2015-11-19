function New-HomeShortcuts
{
    Param(
        # Use an existing shortcut to update the target.
        [Parameter(Mandatory=$true,
                   Position=1)]
        [string]
        $template

        , # Absolute path to desired folder
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        $destination

        , # User accounts to create shortcut to home directories.
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [Microsoft.ActiveDirectory.Management.ADUser[]]
        $Identity
    )

    begin
    {
        try{get-command new-shortcut}
        catch{
            Import-Module util -ErrorAction Stop
        }
    }

    Process
    {
        $Identity | Get-ADUser -properties homedirectory | foreach{
                $shortcut = @{
                    template = $template
                    destination = (Join-Path $destination "$($_.Surname) $($_.GivenName) $($_.samaccountname).lnk")
                    targetPath = $_.homedirectory
                    description = "Controlled Assesment Tracking"
                }

                new-shortcut @shortcut
            }
    }
}
