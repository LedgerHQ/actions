# SBT build action

Sets up Java and SBT, restores cached build outputs, bootstraps SBT with retries, and runs a supplied SBT command.

## Usage

```yaml
- uses: actions/checkout@v7

- name: Check runtime binary compatibility
  uses: LedgerHQ/actions/sbt@main
  with:
    command: a4-bitcoin/Runtime/missinglinkCheck
    fail-on-missing-link-warnings: "true"
```

## Requirements

- Check out the SBT project before invoking the action.
- Use GitHub Actions Runner 2.327.1 or later. `actions/setup-java@v5` and `actions/cache@v5` require this version for their Node.js 24 runtime.

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `command` | SBT command or commands to run. | Required |
| `java-version` | Java version installed by `actions/setup-java`. | `19` |
| `java-distribution` | Java distribution installed by `actions/setup-java`. | `zulu` |
| `retries` | Number of SBT bootstrap and run attempts, with a 15-second incremental backoff. | `1` |
| `fail-on-missing-link-warnings` | Fail a successful command when MissingLink logs an unresolved parent-class warning. | `false` |

When `fail-on-missing-link-warnings` is enabled, the action fails if the SBT output contains a line matching `Warning: Cannot find parent ... of class ...`. This catches unresolved runtime dependencies that MissingLink reports without returning a non-zero exit code.
