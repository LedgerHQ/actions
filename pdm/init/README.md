# Initialize `pdm`

Install Python and `pdm` with cache and extract metadata

## Usage

```yaml
jobs:
  init:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/init@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version to use | `3.11` | `true` |
| `group` | Dependency group(s) to install | `""` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `history` | Fetch the full history | `false` | `false` |
| `pypi-token` | Private PyPI token (read) | `""` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `has_tests` | Whether the project has tests exposed through the `test` command |
| `has_coverage` | Whether the project has tests with coverage exposed through the `cover` command |
| `has_docs` | Whether the project has a documentation exposed through the `doc` command |
| `has_openapi` | Whether the project has an OpenAPI specification exposed through the `doc:openapi` command |
| `has_docker` | Whether the project a Docker image (aka. a `Dockerfile` present at root) |
| `has_src` | Whether the project is using a `src` layout or not |
