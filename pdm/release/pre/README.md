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
          wait-interval: 60
          wait-timeout: 300
```

> [!WARNING]
> Each poll use performimg multiple GitHub API calls.
> Be careful with the `wait-interval` and `wait-timeout` values.

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
actions: read
checks: read
contents: read
```

## Inputs

| Input | Description | Default | Required |
| ----- | ----------- | ------- | -------- |
| `workflow` | Required workflow file | `ci.yml` | `false` |
| `github-token` | A GitHub token with proper permissions | `${{ github.token }}` | `false` |
| `wait` | Wait for the workflow to finish | `true` | `false` |
| `wait-interval` | Interval (in seconds) to check the workflow status | `30` | `false` |
| `wait-timeout` | Timeout (in seconds) to stop checking the workflow status | `600` | `false` |

## Outputs

N/A
