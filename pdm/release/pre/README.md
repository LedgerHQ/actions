# Check release pre-conditions

Check that all requirements for a release are met

## Usage

```yaml
jobs:
  pre:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/pre@main
        with:
          workflow: check.yml
          github-token: ${{ github.token }}
```

## Permissions

This action interact with the GitHub API using the GitHub token and requires the following permissions:

```yaml
actions: read
checks: read
contents: read
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `workflow` | Required workflow file | `ci.yml` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |

## Outputs

N/A
