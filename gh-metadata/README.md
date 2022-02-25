# gh-metadata

Github action to retrieve metadata about a ongoing PR.

The metadata is an output of the action, in json format.

Open a PR to contribute, any merge to main will trigger a republish of the
current version (as defined in `.github/workflows/publish.yml`).

## Action usage

```yaml
jobs:
  meta:
    name: Compute metadata
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/gh-metadata@main
        id: metadata
    outputs:
      refs: ${{ toJson(steps.metadata.outputs) }}
      sha: ${{ steps.metadata.outputs.sha }}

  doit:
    name: Do something
    runs-on: ubuntu-latest
    needs:
      - meta
    steps:
      - run: echo "All outputs ${{ fromJson(steps.meta.outputs.refs).target }}"
      - run: echo "sha = ${{ steps.meta.outputs.sha }}"
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
