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
| `init` | Whether to skip the initialization or not | `true` | `false` |
| `setup` | DEPRECATED (Use `init` instead) | `""` | `false` |
| `install` | Install the project dependencies, only required by hooks relying on the project environment (`repo: local`, `language: system`) | `false` | `false` |
| `working-directory` | Working directory for the project (relative to repo root) | `.` | `false` |
| `python-version` | Python version to run the tests with | `""` | `false` |

## Outputs

N/A
