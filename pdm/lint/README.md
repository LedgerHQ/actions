# Lint

Lint running pre-commit hooks

## Usage

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/lint@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `python-version` | Python version used to build | `3.11` | `false` |


## Outputs

N/A

