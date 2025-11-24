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

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read  # Checkout
id-token: write  # JFrog Artifactory authentication
pull-requests: write  # to comment on the PR (OpenAPI diff only)
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
| ----- | ----------- | ------- | -------- |
| `python-version` | Python version to run the tests with | `""` | `false` |
| `github-token` | A Github token with proper permissions | `${{ github.token }}` | `false` |
| `init` | Clone & sync | `true` | `false` |
| `parameters` | Some extra parameters to pass to `pdm cover` | `""` | `false` |
| `group` | Dependency group(s) to install | `test` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `matrix-id` | An optional unique ID for matrix builds (triggers parallelism) | `""` | `false` |
| `report-only` | Only perform aggregation and reporting (parallelism closure) | `""` | `false` |
| `docker-compose` | Start and wait Docker Compose | `""` | `false` |
| `sonar-token` | SonarCloud token | `""` | `false` |

## Environment variables

| Variable | Description |
| ------ | ----------- |
| `BACKSTAGE_URL` | URL to an optional Backstage instance to upload coverage to |
| `ALLURE_URL` | URL to an optional Allure instance to upload test results to |
| `ALLURE_USERNAME` | Allure instance authentication username |
| `ALLURE_PASSWORD` | Allure instance authentication password |
| `ALLURE_UUIDS` | Allure results UUIDS in case of matrix testing |
| `JFROG_REPOSITORY` | JFrog repository used to fetch internal dependencies (triggers authentication) |

## Outputs

N/A
