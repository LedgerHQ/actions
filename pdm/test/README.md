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
| `kind` | Kind of project to release (`lib`/`app`) | `app` | `true` |
| `python-version` | Python version to run the tests with | `3.11` | `true` |
| `pypi-token` | A Token to Ledger private PyPI with read permissions | `""` | `true` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `parameters` | Some extra parameters to pass to `pdm cover` | `""` | `false` |
| `group` | Dependency group(s) to install | `test` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `allure-username` | Allure username (requires both username and password to enable Allure) | `""` | `false` |
| `allure-password` | Allure password (requires both username and password to enable Allure) | `""` | `false` |

## Environment variables

| Variable | Description |
|----------|-------------|
| `BACKSTAGE_URL` | URL to an optional Backstage instance to upload coverage to |

## Outputs

N/A
