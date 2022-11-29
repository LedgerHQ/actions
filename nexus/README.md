# Nexus

Action to interact with Nexus.

## Action usage

### Get latest version of a package

```yaml
- uses: LedgerHQ/actions/nexus/latest-version
  with:
    feature-name: my-awesome-feature
  env:
    GREEN_NEXUS_HOST: ${{ secrets.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ secrets.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
```

Outputs:

- `last-version`
- `next-feature-tag`

### Publish a new version of a package

```yaml
- uses: LedgerHQ/actions/nexus/publish@main
  env:
    GREEN_NEXUS_HOST: ${{ secrets.GREEN_NEXUS_HOST }}
    GREEN_NEXUS_USER: ${{ secrets.GREEN_NEXUS_USER }}
    GREEN_NEXUS_PASSWORD: ${{ secrets.GREEN_NEXUS_PASSWORD }}
```
