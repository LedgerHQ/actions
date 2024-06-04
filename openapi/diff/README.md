# OpenAPI Diff

Generate a diff between 2 OpenAPI specifications

## Usage

```yaml
jobs:
  diff:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/openapi/diff@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `base` | Base diff specification file | `""` | `true` |
| `head` | Head diff specification file | `""` | `true` |
| `output` | Output directory | `reports/openapi` | `true` |

## Outputs

| Output | Description |
|--------|-------------|
| `markdown` | Path to the generated markdown diff file |
| `text` | Path to the generated text diff file |
