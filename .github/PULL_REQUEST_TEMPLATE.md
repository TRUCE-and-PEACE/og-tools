## Tool Submission Checklist

- **Tool folder:** `<tool-slug>/` (lowercase `a-z0-9_-`, copied from `_example/`)
- [ ] `README.md` includes YAML frontmatter (`title`, `homepage`, `tagline`, `version`, `tags`) and usage cheat sheet
- [ ] `releases.conf` specifies `github_sources = owner/repo` and `tag_prefix`
- [ ] `install.sh` overrides `pkg_install` / `pkg_post_install` with **no `sudo`**, installs under `$WEBI_OPT_DIR`, symlinks into `$WEBI_BIN_DIR`, and calls `webi_path_add`
- [ ] `install.ps1` overrides `Pkg-Install` / `Pkg-PostInstall` with **no admin elevation**, installs under `$WEBI_OPT_DIR`, and calls `Webi-PathAdd`
- [ ] Tested locally and verified safe for users

