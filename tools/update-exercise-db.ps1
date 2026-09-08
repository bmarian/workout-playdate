# Refreshes source/data/free-exercise-db.json from the free-exercise-db

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$outFile = Join-Path $root "source\data\free-exercise-db.json"
$sourceUrl = "https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json"

Write-Host "Downloading $sourceUrl ..." -ForegroundColor Cyan
$raw = Invoke-RestMethod -Uri $sourceUrl

Write-Host "Stripping 'images' field from $($raw.Count) exercises..." -ForegroundColor Cyan
foreach ($exercise in $raw) {
	$exercise.PSObject.Properties.Remove("images")
}

$json = $raw | ConvertTo-Json -Depth 10 -Compress
[System.IO.File]::WriteAllText($outFile, $json)

Write-Host "Wrote $outFile ($((Get-Item $outFile).Length) bytes, $($raw.Count) exercises)." -ForegroundColor Green
