# Upload to Allure server

Upload some Allure results to an Allure Server instance

## Usage

```yaml
jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/actions/allure/upload@main
```

## Inputs

| Input | Description | Default | Required |
|-------|-------------|---------|----------|
| `url` | Allure Server root url | `""` | `true` |
| `username` | Allure Server authentication username (Basic Auth) | `""` | `true` |
| `password` | Allure Server authentication password (Basic Auth) | `""` | `true` |
| `results` | Path to the Allure results directory to upload | `allure-result` | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `response` | The Allure Server upload JSON response |
| `uuid` | The result upload unique identifier |
