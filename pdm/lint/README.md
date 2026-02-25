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
| ----- | ----------- | ------- | -------- |
| `setup` | Whether to skip the setup or not | `true` | `false` |

## Outputs

N/A
