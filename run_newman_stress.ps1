param(
    [int]$Iterations = 20,
    [int]$DelayMs = 100,
    [string]$Collection = ".\\newman_health_stress_collection.json",
    [string]$Environment = ".\\newman_health_env.json",
    [string]$ReportDir = ".\\reports"
)

if (-not (Get-Command newman -ErrorAction SilentlyContinue)) {
    Write-Error "Newman belum terinstall. Jalankan: npm install -g newman"
    exit 1
}

if (-not (Test-Path -LiteralPath $ReportDir)) {
    New-Item -ItemType Directory -Path $ReportDir | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$jsonReport = Join-Path $ReportDir "newman-report-$timestamp.json"

Write-Host "Collection : $Collection"
Write-Host "Environment: $Environment"
Write-Host "Iterations : $Iterations"
Write-Host "Delay (ms) : $DelayMs"
Write-Host "JSON Report: $jsonReport"

newman run $Collection `
    -e $Environment `
    -n $Iterations `
    --delay-request $DelayMs `
    --reporters "cli,json" `
    --reporter-json-export $jsonReport
