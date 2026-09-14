# SBT build action

Sets up Java and SBT, restores Atlas-style content-hashed build outputs, runs a supplied SBT command, and saves the resulting cache.

## Usage

```yaml
- uses: actions/checkout@v7

- name: Check runtime binary compatibility
  uses: LedgerHQ/actions/sbt@main
  with:
    command: a4-bitcoin/Runtime/missinglinkCheck
    java-version: "19"
    fail-on-missing-link-warnings: "true"
```

## Requirements

- Check out the SBT project before invoking the action.

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `command` | SBT command or commands to run. | Required |
| `java-version` | Java version installed by `actions/setup-java`. | `21` |
| `java-distribution` | Java distribution installed by `actions/setup-java`. | `zulu` |
| `retries` | Number of SBT run attempts, with a 15-second incremental backoff. | `1` |
| `fail-on-missing-link-warnings` | Fail a successful command when MissingLink logs an unresolved parent-class warning. | `false` |

## Cache behavior

The action reuses Atlas's explicit restore/save strategy. Its cache key includes the operating system, architecture, Java distribution and version, and a hash of the SBT build definition and Scala sources. When the exact source hash is unavailable, it restores the newest cache for the same platform and Java toolchain.

The cache contains project `target` directories, locally published Ivy artifacts, and the ScalablyTyped cache.

## MissingLink validation

When `fail-on-missing-link-warnings` is enabled, the action fails if the SBT output contains a line matching `Warning: Cannot find parent ... of class ...`. This catches unresolved runtime dependencies that MissingLink reports without returning a non-zero exit code.
