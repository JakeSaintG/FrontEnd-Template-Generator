function GenerateTemplate {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false, HelpMessage="What would you like to name the file?") ] [string] $name
    )

    Write-Host "=[INFO]====================================================================================================="
    Write-Host "Copying Boilerplate files found in Program Files";

    if ($name) {
        $folderName = $name
    } else {
        $folderName = "FrontEndTemplate$(Get-Date -format "MM-dd_HHmm")"
    }

    New-Item -Path $PSScriptRoot -Name $folderName -ItemType "directory" | Out-Null;
    Copy-Item -Path "$templateLocation/css" -Destination "$PSScriptRoot/$folderName"
    Copy-Item -Path "$templateLocation/js" -Destination "$PSScriptRoot/$folderName"
    Copy-Item -Path "$templateLocation/index.html" -Destination "$PSScriptRoot/$folderName"

    Write-Host "Template files created under directory: $folderName";
}