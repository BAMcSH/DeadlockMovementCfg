
$win = @{
      Path = 'README.md', 'Deadlock/MoveTool.ps1', 'Deadlock/MoveToolLite.ps1', 'Deadlock/startup.bat', 'Deadlock/scriptonly.bat', 'Deadlock/game'
      CompressionLevel = 'Fastest'
      DestinationPath = '../MoveToolWindows.zip'
    }

Compress-Archive @win -Force

$lin = @{
      Path = 'README.md', 'Deadlock/MoveTool_linux.sh', 'Deadlock/startup.sh', 'Deadlock/game'
      CompressionLevel = 'Fastest'
      DestinationPath = '../MoveToolLinux.zip'
    }
	
Compress-Archive @lin -Force