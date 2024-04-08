# Extract `pdm` metadata

Extract required metadata from `pdm`

**Deprecatation notice**: this actions is deprecated and has been merged into `pdm/init`.

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
| `target` | The target branch in case of pull-request |
| `version` | The deterministic version (aka. Docker usable version based on the current branch) |
| `branch` | The real actual branch (resolved in case of pull-request) |
| `sha` | The current commit `sha1` being tested/builded |


