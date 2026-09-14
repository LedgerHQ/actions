# MissingLink check action

Runs an SBT MissingLink check and fails when the command exits unsuccessfully or MissingLink reports an unresolved runtime parent class as a warning.

## Usage

```yaml
- uses: actions/checkout@v7

- name: Check runtime binary compatibility
  uses: LedgerHQ/actions/sbt/missinglink@main
  with:
    command: a4-bitcoin/Runtime/missinglinkCheck
```

## Requirements

- Check out the SBT project before invoking the action.

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `command` | MissingLink SBT command to run, including its project and configuration scope. | Required |
| `java-version` | Java version installed by `actions/setup-java`. | `19` |
| `java-distribution` | Java distribution installed by `actions/setup-java`. | `zulu` |

The action uses A4's warning check exactly: it fails if SBT output contains a line matching `Warning: Cannot find parent ... of class ...`, even when the MissingLink task itself exits successfully.
