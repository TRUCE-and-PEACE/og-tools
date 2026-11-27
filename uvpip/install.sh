pkg_install() {
  rm -rf "$WEBI_OPT_DIR"
  mkdir -p "$WEBI_OPT_DIR" "$WEBI_BIN_DIR"
  cp "$WEBI_ARCHIVE" "$WEBI_OPT_DIR/uvpip"
  chmod +x "$WEBI_OPT_DIR/uvpip"
  ln -sf "$WEBI_OPT_DIR/uvpip" "$WEBI_BIN_DIR/uvpip"
}

pkg_post_install() {
  webi_path_add
  printf 'Installed %s %s to %s/%s\n' "$WEBI_PKG" "$WEBI_TAG" "$WEBI_BIN_DIR" "$WEBI_PKG"
  printf 'Run "uvpip doctor" to verify.\n'
}
