# SBT build action

Sets up Java and SBT, restores cached build outputs, bootstraps SBT with retries, and runs a supplied SBT command.

## Usage

```yaml
- name: Check runtime binary compatibility
  uses: LedgerHQ/actions/sbt@main
  with:
    command: server/Runtime/missinglinkCheck
    fail-on-missing-link-warnings: "true"
```

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `command` | SBT command or commands to run. | Required |
| `java-version` | Java version installed by `actions/setup-java`. | `19` |
| `java-distribution` | Java distribution installed by `actions/setup-java`. | `zulu` |
| `background` | Start SBT in the background. Background runs cannot be retried or validate MissingLink warnings. | `false` |
| `retries` | Number of SBT bootstrap and run attempts, with a 15-second incremental backoff. | `1` |
| `fail-on-missing-link-warnings` | Fail a successful command when MissingLink logs an unresolved parent-class warning. | `false` |

When `fail-on-missing-link-warnings` is enabled, the action fails if the SBT output contains a line matching `Warning: Cannot find parent ... of class ...`. This catches unresolved runtime dependencies that MissingLink reports without returning a non-zero exit code.

`background` and `fail-on-missing-link-warnings` cannot both be enabled because warning validation requires the completed SBT output.
