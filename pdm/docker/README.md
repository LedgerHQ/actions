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

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read       # Checkout
id-token: write      # JFrog Artifactory authentication
attestations: write  # Attestation permission
packages: write      # Docker image publication on ghcr
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `clone` | Whether to clone or not | `true` | `false` |
| `version` | Force the built version | `""` | `false` |
| `pypi-token` | ~~Private PyPI token (GemFury read)~~ **deprecated:** _use JFrog instead_ | `""` | `false` |
| `github-token` | A GitHub token with proper permissions | `${{ github.token }}` | `false` |
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
