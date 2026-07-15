$ErrorActionPreference = 'Stop'

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $repositoryRoot 'index.html'

if (-not (Test-Path -LiteralPath $indexPath -PathType Leaf)) {
    Write-Error "Homepage check failed: index.html was not found at $indexPath."
    exit 1
}

$content = Get-Content -LiteralPath $indexPath -Raw
$requirements = @(
    @{ Pattern = 'wallpaper.jpg'; Description = 'the wallpaper.jpg background reference' }
    @{ Pattern = 'id="projects"'; Description = 'a projects section with id="projects"' }
    @{ Pattern = 'id="friends"'; Description = 'a friends section with id="friends"' }
    @{ Pattern = '<img'; Description = 'at least one <img element for project imagery' }
)

$missing = foreach ($requirement in $requirements) {
    if ($content -notlike "*$($requirement.Pattern)*") {
        $requirement.Description
    }
}

if ($missing) {
    Write-Error "Homepage check failed: index.html is missing $($missing -join '; ')."
    exit 1
}

Write-Host 'Homepage check passed.'
