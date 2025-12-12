# Scala Workflows

This document provides an overview of the available GitHub workflows specifically designed for Scala projects using SBT (Simple Build Tool). These workflows help automate various tasks such as building, testing, and deploying Scala applications.

## Available Workflows

### 1. **Scala GH-Pages Deployment** (`scala-gh-pages.yml`)

Automates the deployment of Scala project documentation to GitHub Pages.

Usage:

```yaml
name: Deploy static content to Pages

on:
  # Runs on pushes targeting the default branch
  push:
    tags:
      - "v*"
    branches: ["website"]

# Sets the GITHUB_TOKEN permissions to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  # Single deploy job since we're just deploying
  deploy:
    uses: LedgerHQ/actions/.github/workflows/scala-gh-pages.yml@main
    with:
      script: sbt -mem 4096 website
    secrets: inherit

```
