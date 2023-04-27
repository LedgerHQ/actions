# redocly/lint

Github action linting an OpenAPI specification using redocly CLI.

## Action usage

```yaml
- uses: LedgerHQ/actions/redocly/lint@main
  with:
    specs: path/to/openapi.json
```

You can fine-tune the linter by providing a [Redocly configuration](https://redocly.com/docs/cli/configuration/) in the repository.

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
