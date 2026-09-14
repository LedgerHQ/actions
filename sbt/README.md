# SBT build action

Sets up Java and SBT, restores Atlas-style content-hashed build outputs, runs a supplied SBT command, and saves the resulting cache.

## Usage

```yaml
- uses: actions/checkout@v7

- name: Run tests
  uses: LedgerHQ/actions/sbt@main
  with:
    command: test
```

## Requirements

- Check out the SBT project before invoking the action.

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `command` | SBT command or commands to run. | Required |
| `java-version` | Java version installed by `actions/setup-java`. | `21` |
| `java-distribution` | Java distribution installed by `actions/setup-java`. | `zulu` |

## Cache behavior

The action reuses Atlas's explicit restore/save strategy. Its cache key includes the operating system, architecture, Java distribution and version, and a hash of the SBT build definition and Scala sources. When the exact source hash is unavailable, it restores the newest cache for the same platform and Java toolchain.

The cache contains project `target` directories, locally published Ivy artifacts, and the ScalablyTyped cache.
