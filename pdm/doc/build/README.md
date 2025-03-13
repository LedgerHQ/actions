# Build documentation

Build the documentation using `pdm` commands

## Usage

```yaml
jobs:
  build-doc:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/doc/build@main
```

## Permissions

This action interact with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read  # Checkout
id-token: write  # JFrog Artifactory authentication
pull-requests: write  # to comment on the PR (OpenAPI diff only)
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `3.11` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `pypi-token` | ~~Private PyPI token (GemFury read)~~ **deprecated:** _use JFrog instead_ | `""` | `false` |
| `openapi` | Whether or not to build OpenAPI specs | `false` | `false` |
| `site` | Whether or not to build a documentation site | `false` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |

## Environment variables

N/A

## Outputs

N/A
