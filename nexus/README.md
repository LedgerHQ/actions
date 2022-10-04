# Nexus

Action to interact with Nexus.

## Action usage

### Get latest version of a package

```yaml
- uses: LedgerHQ/actions/nexus/latest-version
  with:
    feature-name: my-awesome-feature
  env:
    GREEN_NEXUS_HOST: <URL>
    GREEN_NEXUS_USER: <username>
    GREEN_NEXUS_PASSWORD: <password>
```

Outputs:

- `last-version`
- `next-feature-tag`

### Publish a new version of a package

```yaml
- uses: LedgerHQ/actions/nexus/publish@main
  env:
    GREEN_NEXUS_HOST: <URL>
    GREEN_NEXUS_USER: <username>
    GREEN_NEXUS_PASSWORD: <password>
```
