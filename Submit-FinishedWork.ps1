﻿<#
.Synopsis
   Copy a file to a set location with a consistent filename
.DESCRIPTION
   To be used as a content menu entry for all files in explorer.
   
   When given the selected files path from the context menu, prefix the filename into the format:
   
   <Username> - <Display Name> - <Last Write Time in UTC> - <Original Filename><Original Extension>

   Copied to the specified path for finished files that teachers know to check.
.EXAMPLE
   Select one or more files from explorer
   Right Click and "Submit Finished Work"
#>
Param
(
    # Path of the piece of work to be copied
    [Parameter(Mandatory=$True,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    [string[]]$Path

    , # Path to finished work location
    [Parameter(Mandatory=$True,
            ValueFromPipelineByPropertyName=$true,
            Position=1)]
    [string]$Destination
)

Begin
{
}
Process
{
    $file = Get-Item -LiteralPath $path
    $id = $env:USERNAME
    $name = ([adsi]"WinNT://$env:USERDOMAIN/$env:USERNAME,user").fullname
    $time = (Get-Date $file.LastAccessTimeUtc -format u).replace(':','.')

    $Destination = join-path -Path $Destination  -ChildPath ("$id - $name - $time - " + $file.Basename + $file.Extension)

    Copy-Item -Destination $Destination -LiteralPath "$path" -Force
}
End
{
}
