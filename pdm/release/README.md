# Release

Bump version and publish release assets

For JFrog Artifactory, repository needs to be authorized on Artifactory.
Calling workflow need to have OIDC permissions:

```yaml
  permissions:
    id-token: write
```

## Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/release@main
```

> [!IMPORTANT]
> JFrog Artifactory dependencies requires authentication.
> As a consequence, you need to enable the `id-token` permission if you rely on it.
>
> When publishing on JFrog Artifactory, this action will also sign and attest the produced packages,
> so it will also need the `attestations` permission.
>
> ```yaml
> jobs:
>   test:
>     runs-on: ubuntu-latest
>     permissions:
>       contents: read
>       id-token: write
>       attestations: write
>     steps:
>       - uses: LedgerHQ/actions/pdm/release@main
>         env:
>           JFROG_REPOSITORY: my-team-repository
>           JFROG_DOCKER_REPOSITORY: my-team-docker-repository
> ```
>
> See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `kind` | DEPRECATED (Set `tool.pdm.distribution=true` on libraries) | `app` | `false` |
| `pypi-token` | A Token to publish on PyPI (private or public) | `""` | `false` |
| `github-token` | A Github token with proper permissions | `""` | `true` |
| `increment` | Kind of increment (optional: `MAJOR\|MINOR\|PATCH`) | `""` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `public` | Is it a public library ? | `false` | `false` |
| `dgoss-args` | `dgoss` extra docker parameters | `""` | `false` |
| `artifactory-repository` | DEPRECATED (Use `JFROG_REPOSITORY` environment variable) | `""` | `false` |
| `docker-name` | Optionally override the docker image name (default to the repository name) | `""` | `false` |
| `extra-docker` | An optional extra docker image to build | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository to publish libraries on (triggers authentication and publication) |
| `JFROG_DOCKER_REPOSITORY` | JFrog repository to publish images to (triggers authentication and publication) |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The generated Github Release URL |
| `version` | The released version |
| `documentation` | The released documentation URL |
| `docker` | The released docker image URL |
| `extra-docker` | The released additional docker image URL |
