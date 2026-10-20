# Slack Test Notification

Post a standard test-run notification to a Slack incoming webhook. The action builds the title and the body
itself, so every test suite renders the same way whatever repository or workflow posts it.

## Usage

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      # ... run the tests and publish the Allure report ...
      - name: Notify Slack
        if: always()
        continue-on-error: true
        uses: LedgerHQ/actions/slack/test-notify@main
        with:
          webhook: ${{ secrets.SLACK_WEBHOOK_URL }}
          environment: main
          suite: API
          emoji: ":fist:"
          allure-summary: allure-report/widgets/summary.json
          report-url: https://allure.example.com/main_api
          report-path: main_api
```

Choosing the channel is up to the caller: the channel is decided by the webhook alone. Set `continue-on-error: true`
on the step so that a notification problem never turns a test run red.

## Inputs

| Input | Description | Default | Required |
| ----- | ----------- | ------- | -------- |
| `webhook` | Slack incoming webhook URL. An empty value is an error | `""` | `true` |
| `suite` | Suite phrase, rendered as `<suite> Test Results`, e.g. `API`, `UI`, `UI Smoke`, `Web`, `Mobile` | `""` | `true` |
| `environment` | Environment name, shown in the title as `[<environment>]` and in the `Environment` line. `main`, `next`, `ppr`, `prd`, `qa` and `argocd` also get a coloured emoji. Empty renders neither the tag nor the line | `""` | `false` |
| `environment-emoji` | Emoji shown before the environment tag. Overrides the built-in one and gives an emoji to any other environment name. Ignored without an `environment` | `""` | `false` |
| `environment-detail` | Detail shown after the environment, e.g. a workspace or `scope smoke` | `""` | `false` |
| `stack` | Label rendered as `[<stack>]` after the environment tag, e.g. the framework or the generation of the suite | `""` | `false` |
| `emoji` | Suite emoji shown before the suite name | `""` | `false` |
| `qualifier` | Qualifier rendered as `(<qualifier>)`, e.g. `nightly` | `""` | `false` |
| `ref` | Git ref or version rendered as `· <ref>`, e.g. `web@1.2.3` | `""` | `false` |
| `status` | `good`, `danger` or `warning`. Colours the sidebar and picks the status emoji. Wins over the value derived from `allure-summary` | `""` | `false` |
| `summary` | Counts text such as `58 passed, 0 failed, 0 broken, 0 skipped, 58 total`. Used when `allure-summary` is empty or unreadable | `""` | `false` |
| `allure-summary` | Path to an Allure `widgets/summary.json`. Computes the counts text and a `good` or `danger` status | `""` | `false` |
| `report-url` | URL of the published Allure report. The `Allure Report` field is omitted when empty | `""` | `false` |
| `report-path` | Label of the report link. Defaults to the URL | `""` | `false` |
| `dry-run` | Set to `true` to print the payload without posting it | `false` | `false` |

## Outputs

| Output | Description |
| ------ | ----------- |
| `title` | The rendered notification title |
| `payload` | The JSON payload that was posted, or would have been with `dry-run` |

## What it renders

```text
:large_purple_circle: [next][v3] :globe_with_meridians: Web Test Results (nightly run) · web@1.2.3 :x:
Environment: next / workspace-1 — 19 passed, 5 failed, 0 broken, 0 skipped, 24 total
Allure Report: <link>        Workflow: <link>
Trigger: manual · <actor>
octo-org/octo-repo
```

Everything sits inside the coloured bar of one Slack attachment, with no pretext above it.

- **Title** is `<environment emoji> [<environment>][<stack>] <emoji> <suite> Test Results[ (<qualifier>)][ · <ref>] <status emoji>`,
  without the parts that are not set. It is the first line of the attachment text in explicit bold (`*<title>*`),
  and the notification preview (`fallback`). The status emoji is `:green-check:` when the status is `good` and `:x:`
  for anything else.
- **Environment emoji**: `main` `:large_blue_circle:`, `next` `:large_purple_circle:`, `ppr` `:black_circle:`,
  `prd` `:white_circle:`, `qa` and `argocd` `:argocd:`. Any other name renders a bare `[name]` unless
  `environment-emoji` is set.
- **Body** is `Environment: <environment>[ / <detail>] — <counts>`. Without counts it reads `No test results`.
- **Fields** are `Allure Report` and `Workflow` side by side, then `Trigger` full width. `Trigger` is `schedule`,
  `manual · <actor>` for a `workflow_dispatch`, or `<event> · <actor>` for any other event. `Workflow`, `Trigger` and
  the footer come from the GitHub context and need no input.
- **Colour and status**: an explicit `status` wins. Otherwise `allure-summary` gives `good` only when tests ran and
  none failed or is broken, and `danger` in every other case, including when no counts are available.

## Delivery

The payload is built with `jq --arg`, so quotes or shell metacharacters in an input can neither break the JSON nor
run as commands. The action masks the webhook in the logs.

- An empty `webhook` fails the step with an error: it is how a secret that is not defined in a repository would
  otherwise hide a whole channel's notifications.
- A webhook that does not answer HTTP 200 only produces a warning, so a Slack outage does not fail the job.

## Tests

```shell
bash slack/test-notify/test/test.sh
```

The script needs `bash`, `jq` and `curl`, and `python3` for the delivery tests, which post to a local mock endpoint.
