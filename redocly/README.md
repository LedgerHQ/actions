# redocly

Github action to interact with Redocly.

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

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
