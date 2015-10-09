function New-HomeShortcuts
{
    Param(
        # Use an existing shortcut to update the target.
        [Parameter(Mandatory=$true,
                    Position=0)]
        [string]
        $template

        , # Out Folder
        $destination

        , # User accounts to create shortcut to home directories.
        $classList = $(Import-Csv 'N:\users.txt')
    )

    # Use force to always get the newest version of New-Shortcut.
    Import-Module util -Force

    $classList | foreach{
            Get-ADUser -Identity "CA$($_.identity)" -properties homedirectory
        } | foreach{
            new-shortcut @{
                template = $template
                newName  = $_.samaccountname
                destination = (Join-Path $destination "$($_.samaccountname) $($_.GivenName) $($_.Surname).lnk")
                targetPath = $_.homedirectory
                description = "Controlled Assesment Tracking"
            }
        }
}
