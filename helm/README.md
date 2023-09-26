# helm

See the [Vault helm workflow](.github/workflows/vault_helm_lint_publish.yml) as an example. 

It is combining below actions to meet Vault needs.

Please create your own reusable workflow matching your need

## helm-conform action

Check the chart conformity with K8 version

```yaml
  - name: Verify conformity
    uses: LedgerHQ/actions/helm/conform@main
    with:
      kubernetes-version: "v1.23.17" # current default value
      kuberconform-version: "v0.6.3" # current default value
      charts-path: "./helm/charts/" # where helm charts are
      schemas-path: ... # overriding schemas location
```

Here is the schemas-path [documentation](https://github.com/yannh/kubeconform#overriding-schemas-location)

## helm-lint action

Lint the helm chart

```yaml
  - name: Run lint on chart
    uses: LedgerHQ/actions/helm/lint@main
    with:
      chart-testing-config: ... # the ct config
      helm-docs-version: "1.11.0" # current default value
```

## helm-publish-cm action

Push the chart to internal chartmuseum .
It need `secrets: inherit` to be used within another workflow

```yaml
  - uses: LedgerHQ/actions/helm/publish-cm@main
    environment: prd # environment defining your CHARTMUSEUM secrets
    with:
      version: 1.2.3 # overwriting the chart version from Chart.yaml
      chartmuseum-url: ${{ secrets.CHARTMUSEUM_URL }}
      chartmuseum-user: ${{ secrets.CHARTMUSEUM_USER }}
      chartmuseum-password: ${{ secrets.CHARTMUSEUM_PASSWORD }}
      charts-path: "./helm/charts/" # where helm charts are
      force: true # force overwriting helm charts in chartmuseum
```

