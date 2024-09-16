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

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |
| `JFROG_DOCKER_REPOSITORY` | JFrog repository to publish images to (triggers authentication and publication) |

## Outputs

| Output | Description |
|--------|-------------|
| `image` | The published docker image |
| `digest` | The published docker image digest |
