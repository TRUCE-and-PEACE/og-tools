pkg_install() {
  webi_extract
  rm -rf "$WEBI_OPT_DIR"
  mkdir -p "$WEBI_OPT_DIR/core" "$WEBI_OPT_DIR/bin" "$WEBI_BIN_DIR"

  src_root="$(find "$WEBI_EXTRACT_DIR" -maxdepth 1 -mindepth 1 -type d | head -n 1)"
  if [ -z "$src_root" ]; then
    src_root="$WEBI_EXTRACT_DIR"
  fi

  if [ -d "$src_root/bunpm/core" ]; then
    cp -R "$src_root/bunpm/core/." "$WEBI_OPT_DIR/core/"
    [ -d "$src_root/bunpm/platforms/linux/bin" ] && cp -R "$src_root/bunpm/platforms/linux/bin/." "$WEBI_OPT_DIR/bin/"
  elif [ -d "$src_root/core" ]; then
    cp -R "$src_root/core/." "$WEBI_OPT_DIR/core/"
    [ -d "$src_root/platforms/linux/bin" ] && cp -R "$src_root/platforms/linux/bin/." "$WEBI_OPT_DIR/bin/"
  fi

  [ -f "$src_root/package.json" ] && cp "$src_root/package.json" "$WEBI_OPT_DIR/package.json"

  cat << 'EOF' > "$WEBI_OPT_DIR/bin/bunpm"
#!/usr/bin/env sh
DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
exec node "$DIR/../core/wrapper.js" "$@"
EOF

  chmod +x "$WEBI_OPT_DIR/bin/"*
  for cmd in bunpm npm npx yarn pnpm; do
    if [ -f "$WEBI_OPT_DIR/bin/$cmd" ]; then
      ln -sf "$WEBI_OPT_DIR/bin/$cmd" "$WEBI_BIN_DIR/$cmd"
    fi
  done
}

pkg_post_install() {
  webi_path_add
  printf 'Installed %s %s to %s\n' "$WEBI_PKG" "$WEBI_TAG" "$WEBI_BIN_DIR"
  printf 'Run "bunpm doctor" to verify.\n'
}
