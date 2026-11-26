---
title: bunpm
homepage: https://github.com/yv3000/bunpm
tagline: Zero-runtime-dependency CLI that transparently routes npm, npx, yarn, and pnpm through Bun for 25x faster installs.
version: v2.3.8
tags: [CLI, Node, Bun, Package Manager]
npm: bunpm-cli
---

`bunpm` keeps your muscle memory (`npm install`, `npx`, `yarn`, `pnpm`) and silently runs it through Bun under the hood, with automatic fail-closed fallback to the native package manager if a command or flag is not supported.

### Verify installation

```sh
bunpm doctor
```

### Basic usage

```sh
npm install
npx create-vite@latest
yarn add react
pnpm install
```

### Update

```sh
curl -sS https://opengadget.dev/bunpm | sh
```
