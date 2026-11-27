function Pkg-Install {
  if (Test-Path $WEBI_OPT_DIR) { Remove-Item -Recurse -Force $WEBI_OPT_DIR }
  New-Item -ItemType Directory -Force -Path $WEBI_OPT_DIR, $WEBI_BIN_DIR | Out-Null

  $srcExe = Join-Path $WEBI_OPT_DIR "uvpip.exe"
  Copy-Item -Path $WEBI_ARCHIVE -Destination $srcExe -Force

  $dstExe = Join-Path $WEBI_BIN_DIR "uvpip.exe"
  Copy-Item -Path $srcExe -Destination $dstExe -Force
}

function Pkg-PostInstall {
  Webi-PathAdd
  Write-Host "Installed $WEBI_PKG $WEBI_TAG to $WEBI_BIN_DIR"
  Write-Host "Run 'uvpip doctor' to verify."
}
