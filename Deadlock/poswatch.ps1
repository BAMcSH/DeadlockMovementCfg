# Original script by discord user ProStoKrut
# Edited by Leif

$GameRoot = Get-Location
$Log  = Join-Path $GameRoot 'game\citadel\console.log'
$Out  = Join-Path $GameRoot 'game\citadel\cfg\lastpos.cfg'

$pat = 'setpos_exact ([\s0-9.-]*);'

if (-not (Test-Path $Out)) {
    Set-Content -Path $Out -Value 'setpos 0 0 0' -Encoding Ascii
}

$existing = (Get-Content -Path $Log | Measure-Object).Count

Get-Content -Path $Log -Wait | ForEach-Object {
	if ($existing -gt 0) {
		$existing--
	}
	
    $m = [regex]::Match($_, $pat)
    if ($m.Success) {
		$s = $m.Value.Remove(0,12)
        Set-Content -Path $Out -Value ('setpos ' + $s) -Encoding Ascii
    }

	if (-not $existing) {
		$n = [regex]::Match($_, "Source2Shutdown")
		if ($n.Success){
			break
		}
	}
}



