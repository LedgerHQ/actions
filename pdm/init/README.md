# Initialize `pdm`

Install Python and `pdm` with cache and extract metadata

## Usage

```yaml
jobs:
  init:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/init@main
        with:
          group: test
```

> [!IMPORTANT]
> JFrog Artifactory dependencies requires authentication.
> As a consequence, you need to enable the `id-token` permission if you rely on it.
>
> ```yaml
> jobs:
>   init:
>     runs-on: ubuntu-latest
>     permissions:
>       contents: read
>       id-token: write
>     steps:
>       - uses: LedgerHQ/actions/pdm/init@main
>         with:
>           group: test
>         env:
>           JFROG_REPOSITORY: my-team-repository
> ```
>
> See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read  # Checkout
id-token: write # Authenticate to JFrog Artifactory
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version to use | `""` | `false` |
| `group` | Dependency group(s) to install | `""` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `history` | Fetch the full history | `false` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `skip-dependencies` | Skip dependencies installation | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

| Output | Description |
|--------|-------------|
| `identifier` | The short project identifier |
| `has_tests` | Whether the project has tests exposed through the `test` command |
| `has_coverage` | Whether the project has tests with coverage exposed through the `cover` command |
| `has_docs` | Whether the project has a documentation exposed through the `doc` command |
| `has_openapi` | Whether the project has an OpenAPI specification exposed through the `doc:openapi` command |
| `has_docker` | Whether the project a Docker image (aka. a `Dockerfile` present at root) |
| `has_src` | Whether the project is using a `src` layout or not |
| `has_backstage` | Whether the project is exposing Backstage catalog infos |
| `is_distribution` | Whether the project is a distribution or not |
| `is_pr` | Is the current workflow run a pull-request |
| `branch` | The branch from which workflow has been triggered |
| `has_jfrog` | Whether this project uses JFrog Artifactory or not |
| `jfrog-domain` | Base domain of Ledger's JFrog platform if authenticated |
| `jfrog-url` | Base URL of Ledger's JFrog platform if authenticated |
| `jfrog-user` | Username extracted from the OIDC token if authenticated |
| `jfrog-token` | OIDC token generated by JFrog CLI if authenticated |
| `python-version` | The Python version used by this action |
| `pdm-version` | The version of `pdm` used by this action |

## Exported environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_DOMAIN` | JFrog base domain if authenticated |
| `JFROG_URL` | JFrog base URL if authenticated |
| `JFROG_USER` | JFrog OIDC user if authenticated |
| `JFROG_TOKEN` | JFrog OIDC token if authenticated |
