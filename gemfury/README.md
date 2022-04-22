# gemfury

Actions to interact with Gemfury.

## Action usage

### Publish a new version of a package

```yaml
- uses: LedgerHQ/actions/gemfury/publish
  env:
    DEPLOY_TOKEN: ${{ env.PYPI_PUSH_TOKEN }}
```

### Get latest version of a package

```yaml
- uses: LedgerHQ/actions/gemfury/latest-version
  with:
    feature-name: my-awesome-feature
  env:
    FULL_ACCESS_TOKEN: ${{ env.PYPI_FULL_ACCESS_TOKEN }}
```

Outputs:

- `last-version`
- `next-feature-tag`

### Install fury CLI

```yaml
- uses: LedgerHQ/actions/gemfury/install@main
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
