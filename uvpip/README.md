---
title: uvpip
homepage: https://github.com/yv3000/uvpip
tagline: Zero-runtime-dependency CLI that transparently routes pip commands through uv for 10-100x faster installs.
version: v1.1.0
tags: [CLI, Python, uv, pip, Package Manager]
pip: uvpip-cli
---

`uvpip` keeps your muscle memory (`pip install`, `pip uninstall`, `pip list`, `pip freeze`) and silently runs it through Astral's `uv` under the hood, with automatic fail-closed fallback to native `pip` if a command or flag is not supported.

### Verify installation

```sh
uvpip doctor
```

### Basic usage

```sh
uvpip install requests
uvpip install -r requirements.txt
uvpip list
uvpip freeze
```

### Update

```sh
curl -sS https://opengadget.dev/uvpip | sh
```
