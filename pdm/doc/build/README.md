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

> [!IMPORTANT]
> JFrog Artifactory dependencies requires authentication.
> As a consequence, you need to enable the `id-token` permission if you rely on it.
>
> ```yaml
> jobs:
>   build-doc:
>     runs-on: ubuntu-latest
>     permissions:
>       contents: read
>       id-token: write
>     steps:
>       - uses: LedgerHQ/actions/pdm/build-doc@main
>         env:
>           JFROG_REPOSITORY: my-team-repository
> ```
>
> See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `3.11` | `false` |
| `pypi-token` | A read token for private PyPI access | `""` | `false` |
| `openapi` | Whether or not to build OpenAPI specs | `false` | `false` |
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
