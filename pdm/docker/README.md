# Build Docker Image

Build Docker image

## Usage

```yaml
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/docker@main
```

> [!IMPORTANT]
> JFrog Artifactory dependencies requires authentication.
> As a consequence, you need to enable the `id-token` permission if you rely on it (to build or publish).
>
> When publishing on JFrog Artifactory, this action will also sign and attest the produced images,
> so it will also need the `attestations` permission.
>
> ```yaml
> jobs:
>   docker:
>     runs-on: ubuntu-latest
>     permissions:
>       contents: read
>       id-token: write
>       attestations: write
>     steps:
>       - uses: LedgerHQ/actions/pdm/docker@main
>         env:
>           JFROG_REPOSITORY: my-team-repository
>           JFROG_DOCKER_REPOSITORY: my-team-docker-repository
> ```
>
> See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `clone` | Whether to clone or not | `true` | `false` |
| `version` | Force the built version | `""` | `false` |
| `pypi-token` | A Token to Ledger private PyPI with read permissions (GemFury, deprecated) | `""` | `false` |
| `github-token` | A Github token with proper permissions | `""` | `false` |
| `build-args` | Docker build command extra `build-args` (multiline supported) | `""` | `false` |
| `secrets` | Docker build command extra `secrets` (multiline supported) | `""` | `false` |
| `dgoss-args` | dgoss extra docker parameters | `""` | `false` |
| `name` | Optional image name (default to repository name) | `""` | `false` |
| `suffix` | Optional Dockerfile suffix | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |
| `JFROG_DOCKER_REPOSITORY` | JFrog repository to publish images to (triggers authentication and publication) |
| `DOCKERHUB_USERNAME` | Optional Docker Hub username (in case you depend on it and to avoir rate limiting) |
| `DOCKERHUB_PASSWORD` | Optional Docker Hub password (in case you depend on it and to avoir rate limiting) |

## Outputs

| Output | Description |
|--------|-------------|
| `image` | The published docker image |
| `digest` | The published docker image digest |
