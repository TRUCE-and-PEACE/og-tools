---
title: websentinel
homepage: https://github.com/aaryx/websentinel
tagline: Bounded, evidence-oriented CLI for authorized web security assessment.
version: v1.0.0
tags: [CLI, Security, Python]
---

`websentinel` inspects HTTP responses, security headers, cookies, TLS certificates, CORS policies, HTML, and JavaScript. It produces actionable findings with severity, confidence, evidence, remediation, and CWE/OWASP mappings.

> Requires **Python 3.11+**. Use only against websites you own or are explicitly authorized to assess.

### Basic usage

```sh
# Assess an authorized target
websentinel scan -u https://example.com

# Select a profile or specific checks
websentinel scan -u https://example.com --profile quick
websentinel scan -u https://example.com --checks headers,cookies,cors

# Bounded crawling
websentinel scan -u https://example.com --crawl --depth 2 --max-pages 30 --max-requests 100
```

### Reports

```sh
websentinel scan -u https://example.com --format json -o report.json
websentinel scan -u https://example.com --format html -o report.html
websentinel scan -u https://example.com --format sarif -o report.sarif
```

### Inspect options

```sh
websentinel checks
websentinel scan --help
websentinel --version
```

### Update

```sh
curl -sS https://opengadget.dev/websentinel | sh
```
