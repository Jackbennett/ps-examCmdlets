Param(
    # Use an existing shortcut to update the target.
    [Parameter(Mandatory=$true,
                Position=0)]
    [string]
    $template
)

$classList = import-csv N:\u.txt
import-moudle util

$classList | foreach{
        get-aduser -Identity "CA$($_.identity)" -properties homedirectory
    } | foreach{
        new-shortcut -template $template -newName $_.samaccountname -destination ".\$($_.samaccountname) $($_.GivenName) $($_.Surname).lnk" -targetPath $_.homedirectory
    }