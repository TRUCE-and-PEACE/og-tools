function Pkg-Install {
  Webi-Extract
  if (Test-Path $WEBI_OPT_DIR) { Remove-Item -Recurse -Force $WEBI_OPT_DIR }
  $optCore = Join-Path $WEBI_OPT_DIR "core"
  $optBin = Join-Path $WEBI_OPT_DIR "bin"
  New-Item -ItemType Directory -Force -Path $optCore, $optBin, $WEBI_BIN_DIR | Out-Null

  $subDir = Get-ChildItem -Path $WEBI_EXTRACT_DIR -Directory | Select-Object -First 1
  $srcRoot = if ($null -ne $subDir) { $subDir.FullName } else { $WEBI_EXTRACT_DIR }

  if (Test-Path (Join-Path $srcRoot "bunpm\core")) {
    Copy-Item -Path (Join-Path $srcRoot "bunpm\core\*") -Destination $optCore -Recurse -Force
    $winBin = Join-Path $srcRoot "bunpm\platforms\windows\bin"
    if (Test-Path $winBin) { Copy-Item -Path (Join-Path $winBin "*") -Destination $optBin -Recurse -Force }
  } elseif (Test-Path (Join-Path $srcRoot "core")) {
    Copy-Item -Path (Join-Path $srcRoot "core\*") -Destination $optCore -Recurse -Force
    $winBin = Join-Path $srcRoot "platforms\windows\bin"
    if (Test-Path $winBin) { Copy-Item -Path (Join-Path $winBin "*") -Destination $optBin -Recurse -Force }
  }

  $pkgJson = Join-Path $srcRoot "package.json"
  if (Test-Path $pkgJson) { Copy-Item -Path $pkgJson -Destination (Join-Path $WEBI_OPT_DIR "package.json") -Force }

  Set-Content -Path (Join-Path $optBin "bunpm.cmd") -Value "@echo off`r`nnode `"%~dp0..\core\wrapper.js`" %*" -Encoding ASCII

  foreach ($cmd in @('bunpm.cmd', 'npm.cmd', 'npx.cmd', 'yarn.cmd', 'pnpm.cmd', 'bunpm', 'npm', 'npx', 'yarn', 'pnpm')) {
    $src = Join-Path $optBin $cmd
    if (Test-Path $src) {
      Copy-Item -Path $src -Destination (Join-Path $WEBI_BIN_DIR $cmd) -Force
    }
  }
}

function Pkg-PostInstall {
  Webi-PathAdd
  Write-Host "Installed $WEBI_PKG $WEBI_TAG to $WEBI_BIN_DIR"
  Write-Host "Run 'bunpm doctor' to verify."
}
