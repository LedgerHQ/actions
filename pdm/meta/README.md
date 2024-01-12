# Extract `pdm` metadata

Extract required metadata from `pdm`

## Usage

```yaml
jobs:
  meta:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/meta@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used by `pdm` | `3.11` | `false` |


## Outputs

| Output | Description |
|--------|-------------|
| `has_tests` | Wether the project has tests exposed through the `test` command |
| `has_coverage` | Wether the project has tests with coverage exposed through the `cover` command |
| `has_docs` | Wether the project has a documentation exposed through the `doc` command |
| `has_openapi` | Wether the project has an OpenAPI specification exposed through the `doc:openapi` command |


