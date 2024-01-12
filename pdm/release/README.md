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
| `increment` | Kind of increment (optional: MAJOR|MINOR|PATCH) | `""` | `false` |


## Outputs

| Output | Description |
|--------|-------------|
| `url` | The generated Github Release URL |
| `version` | The released version |
| `documentation` | The released documentation URL |


