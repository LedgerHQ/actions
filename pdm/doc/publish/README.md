# Publish documentation

Publish the documentation

## Usage

```yaml
jobs:
  publish-doc:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/doc/publish@main
```

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read  # Checkout
id-token: write  # JFrog Artifactory authentication
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `version` | Force a version to be built | `""` | `false` |
| `openapi` | Has OpenAPI specs | `false` | `false` |
| `site` | Publish a documentation site | `false` | `false` |
| `pypi-token` | ~~Private PyPI token (GemFury read)~~ **deprecated:** _use JFrog instead_ | `""` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `python-version` | Python version used to build | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The published documentation URL |
