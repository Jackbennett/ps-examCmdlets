<#
.Synopsis
   Helper script to register the context menu entry to run 'Submit-Finishedwork'
.DESCRIPTION
   Must run as administrator
.EXAMPLE
   .\Register-FinishedWork.ps1

   Execute this file will run the function it exporots. It will not leave a new drive in the scope. 
#>
function Register-FinishedWork
{
    [CmdletBinding()]
    Param
    (
        # Where to forward the work on to.
        $Destination = "C:\new work",
        $PSLocation = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
        $PSCommand = "-executionPolicy Bypass -NoProfile -Noninteractive -NoLogo -noexit"
    )

    Begin
    {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    }
    Process
    {
        New-Item -Path "HKCR:\`*\Shell\Powershell" -Force -Value "Submit Finished Work"
        New-Item -Path "HKCR:\`*\Shell\Powershell\Command" -Force -Value "$PSLocation $PSCommand -File N:\\examCmdlets\\Submit-FinishedWork.ps1 -Path `"%1`" -Destination `"$Destination`" "
    }
    End
    {
    }
}

Register-FinishedWork
