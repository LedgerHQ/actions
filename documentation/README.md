# documentation

Github actions to generate some documentation

## Action usage

```yaml
- uses: LedgerHQ/actions/documentation/c4@main
```

If you want to specify the documentation path for c4 puml files:

```yaml
- uses: LedgerHQ/actions/documentation/c4@main
  with:
    doc_path: "doc/c4"
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
