# Test

Execute test using `pdm` scripts

## Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/test@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version to run the tests with | `3.11` | `true` |
| `pypi-token` | A Token to Ledger private PyPI with read permissions | `""` | `true` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `init` | Clone & sync | `true` | `false` |


## Outputs

N/A

