# Check release pre-conditions

Check that all requirements for a release are met

## Usage

```yaml
jobs:
  pre:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/release/pre@main
        with:
          workflow: check.yml
          github-token: ${{ github.token }}
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `workflow` | Required workflow file | `ci.yml` | `false` |
| `github-token` | A Github token with proper permissions | `""` | `true` |

## Outputs

N/A
