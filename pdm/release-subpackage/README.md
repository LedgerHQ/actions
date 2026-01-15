# Release Subpackage

Release a subpackage located in a subdirectory of your repository.

This action is designed for monorepos where packages are located in subdirectories
(e.g., `packages/<package_name>/`) with their own `pyproject.toml` and version management.

## Features

- **Subpackage-aware**: Operates within a specified subdirectory
- **Prefixed tags**: Supports commitizen's `tag_format` for namespaced tags (e.g., `mypackage/1.2.3`)
- **Distribution publishing**: Publishes to JFrog Artifactory or PyPI
- **Docker support**: Builds and pushes Docker images from the subpackage directory
- **Automatic cleanup**: Rolls back published artifacts on failure

## Usage

### Basic Example

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: write
      packages: write
    steps:
      - uses: LedgerHQ/actions/pdm/release-subpackage@main
        with:
          package-path: packages/mypackage
          github-token: ${{ secrets.GITHUB_TOKEN }}
```

### With PyPI Publishing

```yaml
- uses: LedgerHQ/actions/pdm/release-subpackage@main
  with:
    package-path: packages/mypackage
    github-token: ${{ secrets.GITHUB_TOKEN }}
    pypi-token: ${{ secrets.PYPI_TOKEN }}
    public: 'true'
```

### With JFrog Artifactory

```yaml
- uses: LedgerHQ/actions/pdm/release-subpackage@main
  env:
    JFROG_REPOSITORY: my-pypi-repo
  with:
    package-path: packages/mypackage
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Subpackage Configuration

### Prefixed Tags

To use prefixed tags (recommended for monorepos), configure commitizen in your subpackage's `pyproject.toml`:

```toml
# packages/mypackage/pyproject.toml

[tool.commitizen]
name = "cz_conventional_commits"
tag_format = "mypackage/$version"
version_files = ["VERSION"]
```

This will create tags like `mypackage/1.2.3` instead of just `1.2.3`.

### Distribution Configuration

Mark your package as a distribution in `pyproject.toml`:

```toml
[tool.pdm]
distribution = true
```

### Docker Support

Place a `Dockerfile` in your subpackage directory:

```
packages/
  mypackage/
    Dockerfile
    pyproject.toml
    src/
    ...
```

Optionally add `goss.yaml` for container testing.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `package-path` | Path to the subpackage directory | Yes | - |
| `github-token` | GitHub token with proper permissions | Yes | - |
| `pypi-token` | Token to publish on PyPI | No | - |
| `increment` | Kind of increment (`MAJOR\|MINOR\|PATCH`) | No | - |
| `group` | Dependency group(s) to install | No | `''` |
| `exclude-group` | Dependency group(s) to exclude | No | `''` |
| `public` | Is it a public library? | No | `'false'` |
| `dgoss-args` | Extra docker parameters for dgoss | No | `''` |
| `docker-name` | Override docker image name | No | Package identifier |
| `python-version` | Python version used to build | No | - |

## Outputs

| Output | Description |
|--------|-------------|
| `url` | The generated GitHub Release URL |
| `version` | The released version (e.g., `1.2.3`) |
| `tag` | The released tag (may include prefix, e.g., `mypackage/1.2.3`) |
| `docker` | The released docker image URL |

## Environment Variables

| Variable | Description |
|----------|-------------|
| `JFROG_REPOSITORY` | JFrog Artifactory PyPI repository name |
| `JFROG_DOCKER_REPOSITORY` | JFrog Artifactory Docker repository name |
| `DOCKERHUB_USERNAME` | Docker Hub username (optional) |
| `DOCKERHUB_PASSWORD` | Docker Hub password (optional) |

## Differences from `pdm/release`

| Aspect | `pdm/release` | `pdm/release-subpackage` |
|--------|---------------|--------------------------|
| Working directory | Repository root | Configurable via `package-path` |
| Tag format | Version only (`1.2.3`) | Respects `tag_format` in pyproject.toml |
| Documentation | Supported | Not supported |
| Extra Docker | Supported | Not supported |

## Repository Structure Example

```
my-monorepo/
├── packages/
│   ├── package-a/
│   │   ├── pyproject.toml
│   │   ├── VERSION
│   │   ├── CHANGELOG.md
│   │   ├── Dockerfile          # Optional
│   │   ├── goss.yaml           # Optional
│   │   └── src/
│   │       └── package_a/
│   └── package-b/
│       ├── pyproject.toml
│       ├── VERSION
│       └── src/
│           └── package_b/
└── .github/
    └── workflows/
        └── release-package-a.yml
```

## Workflow Example for Multiple Packages

```yaml
# .github/workflows/release.yml
name: Release

on:
  workflow_dispatch:
    inputs:
      package:
        description: 'Package to release'
        required: true
        type: choice
        options:
          - package-a
          - package-b
      increment:
        description: 'Version increment'
        required: false
        type: choice
        options:
          - ''
          - PATCH
          - MINOR
          - MAJOR

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      id-token: write
      contents: write
      packages: write
    steps:
      - uses: LedgerHQ/actions/pdm/release-subpackage@main
        with:
          package-path: packages/${{ inputs.package }}
          github-token: ${{ secrets.GITHUB_TOKEN }}
          increment: ${{ inputs.increment }}
```
