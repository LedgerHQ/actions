# OpenAPI Diff

Generate a diff between 2 OpenAPI specifications

## Usage

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/openapi/diff@main
        with
          base: path/to/base/openapi.yaml
          head: path/to/head/openapi.yaml
          output: path/to/output/directory
          github-token: ${{ github.token }}
```

## Permissions

This action interact with the GitHub API using the GitHub token and requires the following permissions:

```yaml
pull-requests: write  # to comment on the PR
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `base` | Base diff specification file | `""` | `true` |
| `head` | Head diff specification file | `""` | `true` |
| `output` | Output directory | `reports/openapi` | `true` |
| `github-token` | A GitHub token with `pull-requests: write` permissions | `${{ github.token }}` | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `markdown` | Path to the generated markdown diff file |
| `text` | Path to the generated text diff file |
