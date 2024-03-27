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
| `clone` | Wether to clone or not | `true` | `false` |
| `version` | Force the built version | `""` | `false` |
| `pypi-token` | A Token to Ledger private PyPI with read permissions | `""` | `true` |
| `github-token` | A Github token with proper permissions | `""` | `false` |


## Outputs

| Output | Description |
|--------|-------------|
| `image` | The published docker image |
| `digest` | The published docker image digest |


