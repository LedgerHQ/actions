# Ledger Vault actions

Some Vault/Minivault actions based on the [`vault-cli`](https://github.com/LedgerHQ/vault-ts/tree/main/apps/cli)
[docker image](https://github.com/LedgerHQ/vault-ts/pkgs/container/vault-cli).

## Requirements

The runner running those actions should have access to `vault-remote`

## Usage

### `deploy`

Deploy a new minivault instance in the given environmnet (`sbx`|`stg`).

```yaml
- uses: LedgerHQ/actions/vault/deploy
  with:
    preset: api
    name: my-minivault
    owner: me
    expiration: 1
    environment: sbx
```

### `bake`

Bake an existing Vault instance.

```yaml
- uses: LedgerHQ/actions/vault/deploy
  with:
    salt: yummy
    url: https://my-minivault.minivault.ledger-sbx.com
    manifest: empty
```

### `destroy`

Destray a minivault instance given ints name in an environment (`sbx`|`stg`).

```yaml
- uses: LedgerHQ/actions/vault/destroy
  with:
    name: my-minivault
    environment: sbx
```

## Example

The [`vault.yml` workflow](https://github.com/LedgerHQ/actions/blob/main/.github/workflows/vault.yml) is actually using those action to test them and is a complete example.
