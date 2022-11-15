# gh-context

Github action to log the context of the main action being run.

The output is written in the Job summary.

Open a PR to contribute, any merge to main will trigger a republish of the
current version (as defined in `.github/workflows/publish.yml`).

## Action usage

```yaml
jobs:
  gh-context:
    name: Log Github Context
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/gh-context@${{ inputs.worflow-version }}
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
