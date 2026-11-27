function Pkg-Install {
  Webi-Extract
  if (Test-Path $WEBI_OPT_DIR) { Remove-Item -Recurse -Force $WEBI_OPT_DIR }
  New-Item -ItemType Directory -Force -Path $WEBI_OPT_DIR, $WEBI_BIN_DIR | Out-Null

  $subDir = Get-ChildItem -Path $WEBI_EXTRACT_DIR -Directory | Select-Object -First 1
  if ($null -ne $subDir -and -not (Test-Path (Join-Path $WEBI_EXTRACT_DIR "pyproject.toml"))) {
    $srcRoot = $subDir.FullName
  } else {
    $srcRoot = $WEBI_EXTRACT_DIR
  }

  Copy-Item -Path (Join-Path $srcRoot '*') -Destination $WEBI_OPT_DIR -Recurse -Force

  $venvDir = Join-Path $WEBI_OPT_DIR ".venv"
  if (Get-Command python -ErrorAction SilentlyContinue) {
    & python -m venv $venvDir
  } elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    & python3 -m venv $venvDir
  } elseif (Get-Command py -ErrorAction SilentlyContinue) {
    & py -3 -m venv $venvDir
  } else {
    throw "Python 3.11+ is required to install $WEBI_PKG."
  }

  $venvPython = Join-Path $venvDir "Scripts\python.exe"
  & $venvPython -m pip install --no-cache-dir $WEBI_OPT_DIR
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to install $WEBI_PKG into virtual environment."
  }

  $exePath = Join-Path $venvDir "Scripts\websentinel.exe"
  Set-Content -Path (Join-Path $WEBI_BIN_DIR "websentinel.cmd") -Value "@echo off`r`n`"$exePath`" %*" -Encoding ASCII

  $posixExe = $exePath -replace '\\', '/'
  Set-Content -Path (Join-Path $WEBI_BIN_DIR "websentinel") -Value "#!/usr/bin/env sh`nexec `"$posixExe`" `"`$@`"" -Encoding ASCII
}

function Pkg-PostInstall {
  Webi-PathAdd
  Write-Host "Installed $WEBI_PKG $WEBI_TAG to $WEBI_BIN_DIR"
  Write-Host "Run 'websentinel --version' to verify."
}
