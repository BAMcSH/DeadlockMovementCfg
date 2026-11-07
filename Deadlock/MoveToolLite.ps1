# Lite Pwsh console.log controller by Leif (youtube.com/@leifdeadlock)

$GameRoot = Get-Location
$Log  = Join-Path $GameRoot 'game\citadel\console.log'
$LastPos  = Join-Path $GameRoot 'game\citadel\cfg\lastpos.cfg'
$Out = Join-Path $GameRoot 'game\citadel\cfg'

$pat = 'setpos_exact ([\s0-9.-]*);'

$existing = (Get-Content -Path $Log | Measure-Object).Count

Get-Content -Path $Log -Wait | ForEach-Object {
	if ($existing -gt 0) {
		$existing--
	}

	if (-not $existing) {
		$n = [regex]::Match($_, "Source2Shutdown")
		if ($n.Success){
			break
		}
		
		$m = [regex]::Match($_, $pat)
		if ($m.Success) {
			$m = $m.Value.Remove(0,13)
			Set-Content -Path $LastPos -Value ('setpos ' + $m)
		}
	}
}

