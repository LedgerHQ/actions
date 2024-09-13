# Release

Bump version and publish release assets

For JFrog Artifactory, repository needs to be authorized on Artifactory.
Calling workflow need to have OIDC permissions:

```yaml
  permissions:
    id-token: write
```

## Usage

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/release@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `kind` | Kind of project to release (lib/app) | `app` | `true` |
| `pypi-token` | A Token to publish on PyPI (private or public) | `""` | `true` |
| `github-token` | A Github token with | `""` | `true` |
| `increment` | Kind of increment (optional: `MAJOR\|MINOR\|PATCH`) | `""` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `public` | Is it a public library ? | `false` | `false` |
| `dgoss-args` | `dgoss` extra docker parameters | `""` | `false` |
| `artifactory-repository` | Artifactory repository to publish to | `vault-pypi-prod-green` | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The generated Github Release URL |
| `version` | The released version |
| `documentation` | The released documentation URL |
