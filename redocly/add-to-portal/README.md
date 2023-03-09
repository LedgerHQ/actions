# redocly/add-to-portal

Github action to add a new API to a Redocly Portal.

This should only be used in Redocly Portal repositories, such as [Internal LES API Portal](https://github.com/LedgerHQ/internal-les-api-portal).

## Action usage

```yaml
- uses: LedgerHQ/actions/redocly/add-to-portal@main
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  with:
    name: "My New API"
    version: "1.0.0"
    spec-url: "https://somewhere.com/spec.yaml"
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
