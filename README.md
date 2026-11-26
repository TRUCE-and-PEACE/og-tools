# og-tools

Tool registry for **[opengadget.dev](https://opengadget.dev)** — zero-sudo, one-line terminal installers.

Every tool lives in a single folder at the root of this repository:

```text
<tool-slug>/
├── README.md       # YAML frontmatter + usage cheat sheet
├── releases.conf   # github_sources = owner/repo, tag_prefix = v
├── install.sh      # POSIX installer (overrides pkg_install / pkg_post_install)
└── install.ps1     # Windows PowerShell installer (overrides Pkg-Install / Pkg-PostInstall)
```

Once a PR is merged to `main`, `opengadget.dev` automatically rebuilds and publishes:
- `https://opengadget.dev/<tool-slug>`
- `curl -sS https://opengadget.dev/<tool-slug> | sh`
- `irm https://opengadget.dev/<tool-slug> | iex`

See [CONTRIBUTING.md](./CONTRIBUTING.md) to add a tool.
