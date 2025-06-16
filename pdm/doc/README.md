# Documentation

Build and publish documentation

## Usage

```yaml
jobs:
  doc:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/doc@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `version` | Force a version to be built | `""` | `false` |
| `openapi` | Has OpenAPI specs | `false` | `false` |
| `site` | Publish a documentation site | `false` | `false` |
| `pypi-token` | A read token for private PyPI access | `""` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `python-version` | Python version used to build | `""` | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The published documentation URL |
