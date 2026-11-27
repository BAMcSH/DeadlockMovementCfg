$ErrorActionPreference = 'Stop'

function ConvertTo-Lf {
    param([string]$Path)
    $content = [System.IO.File]::ReadAllText($Path)
    $content = $content -replace "`r`n", "`n"
    $content = $content -replace "`r", "`n"
    return $content
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$win = @{
      Path = 'README.md', 'Deadlock/MoveTool.ps1', 'Deadlock/MoveToolLite.ps1', 'Deadlock/startup.bat', 'Deadlock/scriptonly.bat', 'Deadlock/game'
      CompressionLevel = 'Fastest'
      DestinationPath = '../MoveToolWindows.zip'
    }

Compress-Archive @win -Force

$linStage = Join-Path ([System.IO.Path]::GetTempPath()) 'MoveToolLinux'
if (Test-Path $linStage) { Remove-Item $linStage -Recurse -Force }

New-Item -ItemType Directory -Path $linStage -Force | Out-Null
Copy-Item 'README.md' (Join-Path $linStage 'README.md')
Copy-Item 'Deadlock/game' (Join-Path $linStage 'game') -Recurse

$shellScripts = @('Deadlock/MoveTool_linux.sh', 'Deadlock/startup.sh')
foreach ($f in $shellScripts) {
    $dest = Join-Path $linStage ([System.IO.Path]::GetFileName($f))
    [System.IO.File]::WriteAllText($dest, (ConvertTo-Lf -Path $f), $utf8NoBom)

    if ([System.IO.File]::ReadAllText($dest).Contains("`r")) {
        throw "CRLF detected in '$f' after normalization; refusing to package."
    }
}

Compress-Archive -Path (Join-Path $linStage 'README.md'), (Join-Path $linStage 'MoveTool_linux.sh'), (Join-Path $linStage 'startup.sh'), (Join-Path $linStage 'game') -DestinationPath '../MoveToolLinux.zip' -CompressionLevel 'Fastest' -Force
Remove-Item $linStage -Recurse -Force
