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
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/pdm/release@main
```

## Permissions

This action interacts with the GitHub API using the GitHub token and requires the following permissions:

```yaml
contents: read       # Checkout
id-token: write      # JFrog Artifactory authentication
attestations: write  # Attestation permission
packages: write      # Docker image publication on ghcr
```

See [the shared documentation on JFrog Artifactory](https://github.com/LedgerHQ/actions/tree/main/pdm#jfrog-artifactory)

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `kind` | DEPRECATED (Set `tool.pdm.distribution=true` on libraries) | `""` | `false` |
| `pypi-token` | A Token to publish on PyPI (private or public) | `""` | `false` |
| `github-token` | A Github token with proper permissions | `""` | `true` |
| `increment` | Kind of increment (optional: `MAJOR\|MINOR\|PATCH`) | `""` | `false` |
| `group` | Dependency group(s) to install | `docs` | `false` |
| `exclude-group` | Dependency group(s) to exclude from install | `""` | `false` |
| `public` | Is it a public library ? | `false` | `false` |
| `dgoss-args` | `dgoss` extra docker parameters | `""` | `false` |
| `artifactory-repository` | DEPRECATED (Use `JFROG_REPOSITORY` environment variable) | `""` | `false` |
| `docker-name` | Optionally override the docker image name (default to the repository name) | `""` | `false` |
| `extra-docker` | An optional extra docker image to build | `""` | `false` |
| `python-version` | Python version used to build | `""` | `false` |

## Environment variables

| Variable | Description |
|--------|-------------|
| `JFROG_REPOSITORY` | JFrog repository to publish libraries on (triggers authentication and publication) |
| `JFROG_DOCKER_REPOSITORY` | JFrog repository to publish images to (triggers authentication and publication) |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The generated Github Release URL |
| `version` | The released version |
| `documentation` | The released documentation URL |
| `docker` | The released docker image URL |
| `extra-docker` | The released additional docker image URL |
