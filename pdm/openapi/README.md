# Generate and Compare OpenAPI Specifications

Build, compare (diff), and lint OpenAPI specifications using **pdm** commands, OpenAPI diff, and [Spectral](https://github.com/stoplightio/spectral).

## Usage

```yaml
jobs:
  build-openapi-spec:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/openapi@main
```

## Permissions

This action interact with the GitHub API and [Spectral](https://github.com/stoplightio/spectral) and requires the following permissions:

```yaml
contents: read  # Checkout
id-token: write  # JFrog Artifactory authentication
pull-requests: write  # to comment on the PR (OpenAPI diff only)
checks: write
contents: read
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `3.11` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `pypi-token` | JFROG token | `""` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `spectral-file-glob`| Glob for Spectral to run on (e.g. docs/*.yaml) | `docs/openapi.yaml` | `false` |
| `spectral-ruleset` | Spectral ruleset to enforce  | `.github/openapi.spectral.yaml` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

N/A
