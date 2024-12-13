# python-lib

Github action to build, test, and publish new versions of a python library.

## Action usage

For a simple validation + publish on push to main, you can simply use:

```yaml
- uses: LedgerHQ/actions/python-lib@main
  env:
    GREEN_NEXUS_HOST: ${{ vars.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ vars.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
    # Token used to push the new tag
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    # Token used to push the new version to our internal repository
    PYPI_PUSH_TOKEN: ${{ secrets.PYPI_PUSH_TOKEN }}
  with:
    # Version of python to use, defaults to 3.9
    python-version: "3.9"
```

If however you need to do some more complex stuff (e.g. run the tests
for two versions of python followed by a single publish), then you can
call the sub-actions separately as such:

```yaml
- uses: LedgerHQ/actions/python-lib/test@main
  with:
    # Version of python to use, defaults to 3.9
    python-version: "3.9"
  env:
    GREEN_NEXUS_HOST: ${{ vars.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ vars.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
    PYPI_DEPLOY_TOKEN: ${{ secrets.PYPI_DEPLOY_TOKEN }}
    PYPI_FULL_ACCESS_TOKEN: ${{ secrets.PYPI_FULL_ACCESS_TOKEN }}
- uses: LedgerHQ/actions/python-lib/check-version@main
  with:
    # Version of python to use, defaults to 3.9
    python-version: "3.9"
- uses: LedgerHQ/actions/python-lib/publish@main
  env:
    GREEN_NEXUS_HOST: ${{ secrets.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ secrets.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
    # Token used to push the new tag
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    # Token used to push the new version to our internal repository
    PYPI_PUSH_TOKEN: ${{ secrets.PYPI_PUSH_TOKEN }}
  with:
    # Version of python to use, defaults to 3.9
    python-version: "3.9"
```

### Publish to public pypi

You can choose to publish your package publicly

```yaml
- uses: LedgerHQ/actions/python-lib@main
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    # Token used to push the new version to pypi.org
    PYPI_PUSH_TOKEN: ${{ secrets.PYPI_PUBLIC_API_TOKEN }}
  with:
    public: true
```

### Private dependencies

If your package depends on another hosted on our private repo, you will also
need a *deploy* token for test

```yaml
- uses: LedgerHQ/actions/python-lib@main
  env:
    GREEN_NEXUS_HOST: ${{ secrets.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ secrets.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    PYPI_PUSH_TOKEN: ${{ secrets.PYPI_PUSH_TOKEN }}
    PYPI_DEPLOY_TOKEN: ${{ secrets.PYPI_DEPLOY_TOKEN }}
  with:
    public: true
```

### Deploying feature branches

If you want your feature branches to be published as rc versions on gemfury,
you will need to:

- Trigger the CI on push to `feature/*` branches
- Make sure `public` is set to `false` (we don't publish features to pypi yet)
- Provide a `PYPI_FULL_ACCESS_TOKEN` (required to be able to fetch
existing versions of packages on gemfury)

```yaml
on:
  push:
    branches: [ main, feature/* ]

...

- uses: LedgerHQ/actions/python-lib@main
  env:
    GREEN_NEXUS_HOST: ${{ secrets.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ secrets.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    PYPI_FULL_ACCESS_TOKEN: ${{ secrets.PYPI_FULL_ACCESS_TOKEN }}
```

## Requirements

Beside choosing the version of python to run, this action does not allow the
caller to customize it. *This is on purpose.*

We want all of our python lib repositories to look the same, so here are
a few conditions to use this action:

- Use `main` as your base branch.
- Don't rely on `pipenv` for listing and locking deps. We want `pipenv` to
be used by services, and simple `setup.py` + `requirements.txt` for libs.
- Define your version in `setup.py` as a variable `__version__ = "1.2.3"`
- If you have multiple extra requirement sets, define a `tests` set which
combines all your deps (see [this example](https://github.com/LedgerHQ/python-ledgercommon/blob/main/setup.py#L35)).
Essentially running `pip install .[tests]` should install all the lib deps
required to run the tests.
- Running `pytest` at your root should run your tests. Note that you need
to have at least one test.
- Have a `requirements-dev.txt` at your root.
  - Required dev packages: `codecov`, `pre-commit`, `pytest`, `pytest-cov`
  - Optional dev packages: `mypy`
- Have a `.pre-commit-config.yaml` at your root (see [this example](https://github.com/LedgerHQ/python-ledgercommon/blob/main/.pre-commit-config.yaml)).

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
