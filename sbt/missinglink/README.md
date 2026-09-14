# MissingLink action

Runs an SBT MissingLink check and fails when the command exits unsuccessfully or MissingLink logs an unresolved runtime parent class as a warning.

## Usage

```yaml
- name: Check runtime binary compatibility
  uses: LedgerHQ/actions/sbt/missinglink@main
  with:
    command: server/Runtime/missinglinkCheck
```

The default command is `Runtime/missinglinkCheck`. Override it when the MissingLink task is scoped to a subproject or configuration.

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `command` | MissingLink SBT command to run. | `Runtime/missinglinkCheck` |
| `java-version` | Java version installed by `actions/setup-java`. | `19` |
| `java-distribution` | Java distribution installed by `actions/setup-java`. | `zulu` |
| `retries` | Number of SBT run attempts, with a 15-second incremental backoff. | `1` |
