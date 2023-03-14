# SONARQUBE

Github action to use sonarqube.

### Needed env variable

- `CI_BOT_TOKEN` (required) GitHub Access Token with the `repo` scope assigned. .
- `SONAR_TOKEN_GREEN` (required) Sonar token generate .
- `SONAR_HOST_URL` (required). Sonar host url.
- `project_id` (required). roject ID for Tagging AWS resources. https://ledgerhq.atlassian.net/wiki/spaces/MS/pages/1372193291/2xxx+AWS+Data+Center
#### <br> !! Go easy !! <ins> Abusive notifications (especially with ping) can be annoying. </ins>

## Action usage

```yaml
uses: LedgerHQ/actions/.github/workflows/sonarqube.yml@main
    secrets: inherit
    with:
      ref: ${{ fromJson(needs.meta.outputs.refs).sha }}
      project_id: 2043
```

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
