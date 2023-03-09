# redocly/new-api

Github action to add a new API to redocly.

This should only be used in Redocly Portal repositories, such as [Internal LES API Portal](https://github.com/LedgerHQ/internal-les-api-portal).

## Action usage

```yaml
- uses: LedgerHQ/actions/redocly/new-api@main
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  with:
    name: "My New API"
    version: "1.0.0"
    spec-url: "https://somewhere.com/spec.yaml"
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
