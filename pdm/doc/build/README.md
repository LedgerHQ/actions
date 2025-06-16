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

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read  # Checkout
id-token: write  # JFrog Artifactory authentication
pull-requests: write  # to comment on the PR (OpenAPI diff only)
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `""` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `openapi` | Whether or not to build OpenAPI specs. Valid values are: "true" (to generate new specs and run diff steps on PRs), "false" (to skip OpenAPI processing), or an artifact name (to download an existing OpenAPI spec). | `false` | `false` |
| `site` | Whether or not to build a documentation site | `false` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

N/A
