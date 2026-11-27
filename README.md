# og-tools

Official tool registry for **[opengadget.dev](https://opengadget.dev)** — zero-sudo, one-line terminal installers for macOS, Linux, and Windows.

## Install Any Tool

```sh
# macOS / Linux (sh, bash, zsh)
curl -sSL opengadget.dev/<tool> | sh

# Windows PowerShell
irm opengadget.dev/<tool> | iex
```

## Add a Tool

Every tool lives in a single folder at the root of this repository:

```text
<tool-slug>/
├── README.md       # YAML frontmatter + usage cheat sheet
├── releases.conf   # github_sources = owner/repo, tag_prefix = v
├── install.sh      # POSIX installer (overrides pkg_install / pkg_post_install)
└── install.ps1     # Windows PowerShell installer (overrides Pkg-Install / Pkg-PostInstall)
```

1. Copy `_example/` into `<tool-slug>/`.
2. Open a Pull Request against `main`.
3. Automated checks validate your folder structure, frontmatter, and zero-`sudo` rules.
4. Once reviewed and merged by a maintainer, `https://opengadget.dev/<tool-slug>` and the one-line installers go live automatically.

See [CONTRIBUTING.md](./CONTRIBUTING.md) for full details.
