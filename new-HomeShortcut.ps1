function New-homeShortcuts
{
    Param(
        # Use an existing shortcut to update the target.
        [Parameter(Mandatory=$true,
                    Position=0)]
        [string]
        $template

        , # Out Folder
        $destination
    )

    $classList = import-csv N:\u.txt
    import-module util -Force

    $classList | foreach{
            get-aduser -Identity "CA$($_.identity)" -properties homedirectory
        } | foreach{
            new-shortcut -template $template -newName $_.samaccountname -destination (join-path $destination "$($_.samaccountname) $($_.GivenName) $($_.Surname).lnk") -targetPath $_.homedirectory -description $_.homedirectory
        }
}
