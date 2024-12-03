# Slack Notify Release

Dispatch a Slack release Notification in a given channel

## Usage

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/slack/release@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `project` | Project name | `""` | `true` |
| `version` | Released version | `""` | `true` |
| `webhook-url` | Slack webhook URL | `""` | `true` |
| `channel` | Channel to notify in | `#vault-ci-notifications` | `false` |
| `github-release` | An optional github release URL | `""` | `false` |
| `docker` | An optional Docker image URL | `""` | `false` |
| `extra-docker` | An optional extra Docker image URL | `""` | `false` |
| `documentation` | An optional documentation URL | `""` | `false` |

## Outputs

N/A
