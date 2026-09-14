# MissingLink output check action

Checks an existing SBT output log and fails when MissingLink reports an unresolved runtime parent class as a warning. This action does not install Java, run SBT, or manage caches.

## Usage

```yaml
- uses: actions/checkout@v7

- name: Run MissingLink
  id: missinglink
  uses: LedgerHQ/actions/sbt@main
  with:
    command: a4-bitcoin/Runtime/missinglinkCheck
    java-version: "19"

- name: Check MissingLink output
  uses: LedgerHQ/actions/sbt/missinglink@main
  with:
    log-file: ${{ steps.missinglink.outputs.log-file }}
```

## Requirements

- Produce the log before invoking the action. `LedgerHQ/actions/sbt` exposes a compatible `log-file` output.

## Inputs

| Input | Description | Default |
| --- | --- | --- |
| `log-file` | Path to the captured MissingLink SBT output. | Required |

The action uses A4's warning check exactly: it fails if the log contains a line matching `Warning: Cannot find parent ... of class ...`.
