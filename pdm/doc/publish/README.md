# Publish documentation

Publish the documentation

## Usage

```yaml
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/doc/publish@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `version` | Force a version to be built | `""` | `false` |
| `openapi` | Has OpenAPI specs | `false` | `false` |
| `site` | Publish a documentation site | `false` | `false` |
| `pypi-token` | A read token for private PyPI access | `""` | `false` |
| `init` | Clone & sync | `true` | `false` |


## Outputs

| Output | Description |
|--------|-------------|
| `url` | The published documentation URL |


