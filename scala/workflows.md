# Scala Workflows

This document outlines the available GitHub Actions workflows for Scala projects provided by LedgerHQ. These workflows help set up the development environment and compile Scala code efficiently.

## Available Workflows

### 1. Ephemeral Environment Setup

This workflow sets up an ephemeral environment for Scala projects, installing the necessary JDK and SBT configurations.

**Workflow File:** `.github/workflows/ephemeral.yaml`

**Usage:**

```yaml
name: Scala Ephemeral Environment Setup
on: [push, pull_request]

jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Ephemeral environment
        uses: LedgerHQ/.github/workflows/ephemeral.yaml@main
        with:
          java-version: "25"
        secret: inherits


```
