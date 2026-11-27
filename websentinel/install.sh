pkg_install() {
  webi_extract
  rm -rf "$WEBI_OPT_DIR"
  mkdir -p "$WEBI_OPT_DIR" "$WEBI_BIN_DIR"

  src_root="$(find "$WEBI_EXTRACT_DIR" -maxdepth 1 -mindepth 1 -type d | head -n 1)"
  if [ -z "$src_root" ] || [ -f "$WEBI_EXTRACT_DIR/pyproject.toml" ]; then
    src_root="$WEBI_EXTRACT_DIR"
  fi

  cp -R "$src_root"/. "$WEBI_OPT_DIR"/

  py_bin=""
  if command -v python3 >/dev/null 2>&1; then
    py_bin="python3"
  elif command -v python >/dev/null 2>&1; then
    py_bin="python"
  else
    printf 'Error: Python 3.11+ is required to install %s.\n' "$WEBI_PKG" >&2
    return 1
  fi

  "$py_bin" -m venv "$WEBI_OPT_DIR/.venv"
  "$WEBI_OPT_DIR/.venv/bin/python" -m pip install --no-cache-dir "$WEBI_OPT_DIR"

  ln -sf "$WEBI_OPT_DIR/.venv/bin/websentinel" "$WEBI_BIN_DIR/websentinel"
}

pkg_post_install() {
  webi_path_add
  printf 'Installed %s %s to %s/%s\n' "$WEBI_PKG" "$WEBI_TAG" "$WEBI_BIN_DIR" "$WEBI_PKG"
  printf 'Run "websentinel --version" to verify.\n'
}
