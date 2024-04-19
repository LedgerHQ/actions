# Release

Bump version and publish release assets

## Usage

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/release@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `kind` | Kind of project to release (lib/app) | `app` | `true` |
| `pypi-token` | A Token to Ledger private PyPI | `""` | `true` |
| `github-token` | A Github token with | `""` | `true` |
| `increment` | Kind of increment (optional: `MAJOR\|MINOR\|PATCH`) | `""` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |

## Environment variables

### Publishing on Nexus

Those variables are required if you want to publish you package on Nexus.

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| `NEXUS_HOST` | The Nexus repository host (without the `https?://` prefix) | | `true` |
| `NEXUS_USER` | The Nexus username to authenticate with | | `true` |
| `NEXUS_PASSWORD` | The Nexus password to authenticate with | | `true` |
| `NEXUS_REPO` | The Nexus repository to publish in | `pypi-internal` | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The generated Github Release URL |
| `version` | The released version |
| `documentation` | The released documentation URL |


