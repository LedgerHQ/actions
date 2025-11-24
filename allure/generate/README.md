# Generate Allure report

Generate an allure report for a set of results (given their uuids)

## Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: LedgerHQ/allure/upload@main
        with:
          url: https://allure.server.url
          build-name: ${{ github.workflow }}
          build-url: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}
          username: ${{ secrets.allure-username }}
          password: ${{ secrets.allure-password }}
          path: my-project
          results: allure-results
```

## Inputs

| Input | Description | Default | Required |
| ----- | ----------- | ------- | -------- |
| `url` | Full url of your deployed allure-server' | `""` | `true` |
| `username` | If your allure-server has basic auth enabled, specify username here | `""` | `false` |
| `password` | If your allure-server has basic auth enabled, specify password here | `""` | `false` |
| `path` | Allure server identifier used to aggregate reports (default to repository name) | `""` | `true` |
| `results` | line separated list of results UUIDs to process | `""` | `true` |
| `report-name` | [Report Overview top name](https://allurereport.org/docs/how-it-works-executor-file/#report-properties) *(default to `<repository name>`)* | `""` | `false` |
| `build-name` | [Executor](https://allurereport.org/docs/how-it-works-executor-file/) build name *(default to `<workflow name> #<buildno>`)* | `""` | `false` |
| `build-url` | [Executor](https://allurereport.org/docs/how-it-works-executor-file/#build-properties) link to the build *(default to the current workflow run URL)* | `""` | `false` |
| `delete-results` | Whether or not to delete the raw results after the report generation. | `true` | `false` |

## Outputs

| Output | Description |
| ------ | ----------- |
| `response` | The Allure Server generation JSON response |
| `uuid` | The generated report UUID |
| `url` | The generated report unique URL |
