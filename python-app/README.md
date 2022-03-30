# python-app

Github action to build, test, and publish new versions of a python application.

```
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
        env:
          PYPI_DEPLOY_TOKEN: ${{ secrets.PYPI_DEPLOY_TOKEN }}
          CI_BOT_USERNAME: ${{ secrets.CI_BOT_USERNAME }}
          CI_BOT_TOKEN: ${{ secrets.CI_BOT_TOKEN }}
```

This action is a `composite` of

 * `LedgerHQ/actions/python-app/lint`
Run `pre-commit` hook

 * `LedgerHQ/actions/python-app/test`
Run unittest and mypy (if installed in the venv)

 * `LedgerHQ/actions/python-app/goss`
Test the image via [Goss](https://goss.rocks/)
Goss files are expected to be present in `.github/goss/`

 * `LedgerHQ/actions/python-app/docker`
Build and publish a docker image for: `main`, `tags`, `feature/*`
