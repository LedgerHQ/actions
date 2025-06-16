# Generate and compare OpenAPI specifications

Build, compare (diff), and lint OpenAPI specifications using **pdm** commands, OpenAPI diff, and [Spectral](https://github.com/stoplightio/spectral).

## Usage

```yaml
jobs:
  openapi:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/openapi@main
```

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read       # Checkout
id-token: write      # JFrog Artifactory authentication
pull-requests: write # To comment on the PR (OpenAPI diff only)
checks: write        # To submit Spectral linting results
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `""` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `pypi-token` | Private PyPI token | `""` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `spectral-file-glob` | Glob for Spectral to run on (e.g. `docs/*.yaml`) | `docs/openapi.yaml` | `false` |
| `spectral-ruleset` | Spectral ruleset to enforce | `.github/openapi.spectral.yaml` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

| Output | Description |
|--------|-------------|
| `openapi` | The name of the uploaded OpenAPI artifact |
