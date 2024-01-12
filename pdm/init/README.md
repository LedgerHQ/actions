# Initialize `pdm`

Install Python and `pdm` with cache and extract metadata

## Usage

```yaml
jobs:
  init:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/init@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version to use | `3.11` | `true` |
| `group` | Dependency group to install | `""` | `false` |
| `history` | Fetch the full history | `false` | `false` |
| `pypi-token` | Private PyPI token (read) | `""` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |


## Outputs

N/A

