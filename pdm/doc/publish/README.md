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

> [!IMPORTANT]
> JFrog Artifactory dependencies requires authentication.
> As a consequence, you need to enable the `id-token` permission if you rely on it.
>
> ```yaml
> jobs:
>   publish-doc:
>     runs-on: ubuntu-latest
>     permissions:
>       contents: read
>       id-token: write
>     steps:
>       - uses: LedgerHQ/actions/pdm/publish-doc@main
>         env:
>           JFROG_REPOSITORY: my-team-repository
> ```
>
> See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `version` | Force a version to be built | `""` | `false` |
| `openapi` | Has OpenAPI specs | `false` | `false` |
| `site` | Publish a documentation site | `false` | `false` |
| `pypi-token` | A read token for private PyPI access | `""` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The published documentation URL |
