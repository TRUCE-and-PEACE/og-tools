# Contributing a Tool to opengadget.dev

Every tool on **opengadget.dev** is a single folder in this repository (`yv3000/og-tools`).

## 1. Copy `_example/`

Create a lowercase folder `<tool-slug>/` matching `^[a-z0-9][a-z0-9_-]{0,63}$` with:

```text
<tool-slug>/
├── README.md       # YAML frontmatter (title, homepage, tagline, version, tags) + cheat sheet
├── releases.conf   # github_sources = owner/repo, tag_prefix = v
├── install.sh      # POSIX installer (overrides pkg_install / pkg_post_install)
└── install.ps1     # Windows PowerShell installer (overrides Pkg-Install / Pkg-PostInstall)
```

## 2. Rules for Installers

- **Zero `sudo` / admin rights:** Install only under `$WEBI_OPT_DIR` (`~/.local/opt/<tool>-<tag>`) and link/copy binaries into `$WEBI_BIN_DIR` (`~/.local/bin`).
- **Update `PATH` cleanly:** Call `webi_path_add` (POSIX) or `Webi-PathAdd` (PowerShell) in `pkg_post_install` / `Pkg-PostInstall`.
- **Safe URLs only:** `homepage` in `README.md` must use `https://` or `http://`, and `github_sources` in `releases.conf` must be `owner/repo`.

## 3. Open a Pull Request

The PR check validates your folder structure, frontmatter, and `releases.conf`. Once merged to `main`, Cloudflare Pages automatically rebuilds `https://opengadget.dev` so your tool page, OpenGraph card, and one-line installers go live right away.

