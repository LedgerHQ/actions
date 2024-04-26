# python-app

Github action to build, test, and publish new versions of a python application.

```yaml
name: Lint, Test and Publish

on:
  push:
    branches:
      - main
    tags:
      - "*"
  pull_request:
  workflow_dispatch:

jobs:
  build-test-publish:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/python-app@main
        with:
          redocly-project: "@ledger/Vault Notification Center@v1"
        env:
          PYPI_DEPLOY_TOKEN: ${{ secrets.PYPI_DEPLOY_TOKEN }}
          CI_BOT_USERNAME: ${{ secrets.CI_BOT_USERNAME }}
          CI_BOT_TOKEN: ${{ secrets.CI_BOT_TOKEN }}
          REDOCLY_AUTHORIZATION: ${{ secrets.REDOCLY_AUTHORIZATION }}
```

This action is a `composite` of

- `LedgerHQ/actions/python-app/lint`
Run `pre-commit` hook

- `LedgerHQ/actions/python-app/test`
Run unittest and mypy (if installed in the venv)

- `LedgerHQ/actions/python-app/goss`
Test the image via [Goss](https://goss.rocks/)
Goss files are expected to be present in `.github/goss/`

- `LedgerHQ/actions/python-app/docker`
Build and publish a docker image for: `main`, `tags`, `feature/*`
You can use the `VERSION` build arg to get the version as provided by `git
describe --tags`

- `LedgerHQ/actions/python-app/doc`
call `pipenv openapi` to generate an openapi file and push it to redocly
This step is only active if `redocly-project` is given.

For convenience, we also provide `LedgerHQ/actions/python-app/init` that setup
python and run `pipenv sync` (with `--dev` optionally)
