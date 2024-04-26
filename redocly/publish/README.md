# redocly/publish

Github action to publish a new version of an API spec to redocly.

## Action usage

```yaml
- uses: LedgerHQ/actions/redocly/publish@main
  env:
    REDOCLY_AUTHORIZATION: ${{ secrets.REDOCLY_AUTHORIZATION }}
  with:
    api-name: "Cardano Account Reader"
    api-version: "v1"
```

By default we publish the spec at the path `openapi/spec.json`.
If your spec is located elsewhere you can

```yaml
    spec-path: "account-reader/tooling/openapi/spec.json"
```

By default we publish the spec at the path to the `main` branch.
If you want to publish to a custom branchm provide the `branch` parameter:

```yaml
    branch: "feature/test"
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
