# Build documentation

Build the documentation using `pdm` commands

## Usage

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/doc/build@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `3.11` | `false` |
| `pypi-token` | A read token for private PyPI access | `""` | `false` |
| `openapi` | Whether or not to build OpenAPI specs | `false` | `false` |
| `site` | Whether or not to build a documentation site | `false` | `false` |
| `init` | Clone & sync | `true` | `false` |


## Outputs

N/A

