# docker-metadata

Github action to generate Ledger compliant docker metadata.

Open a PR to contribute, any merge to main will trigger a republish of the
current version (as defined in `.github/workflows/publish.yml`).

## Action usage

```yaml
jobs:
  meta:
    name: Compute all metadata
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/gh-metadata@main
        id: gh-meta
      - uses: LedgerHQ/actions/docker-metadata@main
        id: docker-meta
        with:
          ref: ${{ steps.gh-meta.outputs.branch }}
          sha: ${{ steps.gh-meta.outputs.sha }}
    outputs:
      docker: ${{ steps.docker-meta.outputs.docker }}
      image: ${{ steps.docker-meta.outputs.image }}

  doit:
    name: Do something
    runs-on: ubuntu-latest
    needs:
      - meta
    steps:
      - run: echo "Docker meta ${{ steps.meta.outputs.docker }}"
      - run: echo "Docker image short = ${{ steps.meta.outputs.image }}"
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
