# allure/publish

Publish allure results on an allure server, and notify of results on slack.

## Requirements

For slack notifications:

- You'll need to have a template file in `.github/templates/slack.json`, see [this example](https://github.com/LedgerHQ/vault-e2e-tests/blob/main/.github/templates/slack.json) from the QAA team.
- If you don't use a self-hosted, you'll need to install [the allure npm package](https://www.npmjs.com/package/allure-commandline) as well as `jq`.

## Action usage

```yaml
- uses: LedgerHQ/actions/allure/publish@main
  if: always()
  with:
    allure-username: ${{ secrets.ALLURE_SERVER_USERNAME }}
    allure-password: ${{ secrets.ALLURE_SERVER_PASSWORD }}
    slack-webhook-url: ${{ secrets.SLACK_WEBHOOK_URL }}
```

If you don't want to push a notification on Slack, you can skip `slack-webhook-url`.

See the [action's content](action.yml) for additional available parameters.

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
