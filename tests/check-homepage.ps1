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
    @{ Pattern = 'id="stacks"'; Description = 'a technical stacks section with id="stacks"' }
    @{ Pattern = '异构计算与 FPGA'; Description = 'the heterogeneous computing and FPGA stack card' }
    @{ Pattern = '嵌入式固件开发'; Description = 'the embedded firmware development stack card' }
    @{ Pattern = '数字 IC 设计与验证'; Description = 'the digital IC design and verification stack card' }
    @{ Pattern = '原理图与 PCB 设计'; Description = 'the schematic and PCB design stack card' }
    @{ Pattern = 'Vitis'; Description = 'the Vitis tool tag' }
    @{ Pattern = 'Verdi'; Description = 'the Verdi tool tag' }
    @{ Pattern = '嘉立创 EDA'; Description = 'the LCSC EDA tool tag' }
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
