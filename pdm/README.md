# PDM-related actions

Provides some reusable PDM actions.

## Actions

| Name | Description |
|--------|-------------|
| [Documentation (`doc`)](doc/) | Build and publish documentation |
| [Build Docker Image (`docker`)](docker/) | Build Docker image |
| [Initialize `pdm` (`init`)](init/) | Install Python and `pdm` with cache and extract metadata |
| [Lint (`lint`)](lint/) | Lint running pre-commit hooks |
| [Extract `pdm` metadata (`meta`)](meta/) | Extract required metadata from `pdm` |
| [Release (`release`)](release/) | Bump version and publish release assets |
| [Test (`test`)](test/) | Execute test using `pdm` scripts |
| [Build documentation (`doc/build`)](doc/build/) | Build the documentation using `pdm` commands |
| [Publish documentation (`doc/publish`)](doc/publish/) | Publish the documentation |

## JFrog Artifactory

All those actions have opt-in support for both consuming from and publishing to out internal Artifactory repositories.

The feature is enabled by the presence of:
- a `JFROG_REPOSITORY` environment variable for Python dependencies
- a `JFROG_DOCKER_REPOSITORY` environment variable for Docker

We rely on environment variables instead of explicit parameters because:
- there is a hard limit of 10 parameters on reusable actions
- `pyproject.toml` sources support environment variable inject for credentials and we use the same naming

When enabled, the [Initialize `pdm` action (`init`)](init/) will authenticate against Artifactory using
the [dedicated `jfrog-login` action](https://github.com/LedgerHQ/actions-security/tree/main/actions/jfrog-login).

As a consequence, all jobs requiring access to JFrog Artifactory, even read-only, should have the permissions to issue OIDC token: `id-token: write`.

As soon as you publish on Artifactory (a Python library or a Docker image), those actions will attest and sign them.
As a consequence, you will also need the `attestations: write` permission.

When defining custom permissions, you need to redefine the default one, at least the `contents: read` required to checkout a repository.

```yaml
permissions:
  id-token: write      # OIDC token permission
  attestations: write  # Attestation permission
  contents: read       # Default read permission required to checkout
```

For reference:
- [`jfrog-login` actions' documentation permission section](https://github.com/LedgerHQ/actions-security/tree/main/actions/jfrog-login#required-permissions)
- [GitHub Actions OIDC permissions documentation](https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers#adding-permissions-settings)
