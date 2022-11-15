# ec2-linux-runner

Actions for the creation and destroying on-demand self-hosted AWS EC2 runners

## Action usage

### Start AWS EC2 Runner

```yaml
- uses: LedgerHQ/actions/ec2-linux-runner@${{ inputs.worflow-version }}
  with:
    mode: start
    github-token: ${{ secrets.CI_BOT_TOKEN }}
    project: ec2-runner-project-id
```

### Stop AWS EC2 Runner

```yaml
- uses: LedgerHQ/actions/ec2-linux-runner@${{ inputs.worflow-version }}
  with:
    mode: stop
    github-token: ${{ secrets.CI_BOT_TOKEN }}
    label: ${{ needs.start-runner.outputs.label }}
    ec2-instance-id: ${{ needs.start-runner.outputs.ec2-instance-id }}
```

Inputs:

| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Required                                   | Description                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `mode`                                                                                                                                                                       | Always required.                           | Specify here which mode you want to use: <br> - `start` - to start a new runner; <br> - `stop` - to stop the previously created runner.                                                                                                                                                                                               |
| `project`                                                                                                                                                                    | Always required.                           | Project ID for Tagging AWS resources                                                                                                                                                                                                                                                                                                  |
| `github-token`                                                                                                                                                               | Always required.                           | GitHub Personal Access Token with the `repo` scope assigned.                                                                                                                                                                                                                                                                          |
| `ami-name-filter`                                                                                                                                                            | Required if you use the `start` mode.      | Get AMI ID by name (`default: ledger-live-runner`)                                                                                                                                                                                                                                                                                    |
| `ec2-instance-type`                                                                                                                                                          | Required if you use the `start` mode.      | EC2 Instance Type (`default: t3.medium`)                                                                                                                                                                                                                                                                                              |
| `instance-volume-size`                                                                                                                                                       | Required if you use the `start` mode.      | Volume size for EC2 Instance (`default: 8`)                                                                                                                                                                                                                                                                                           |
| `subnet-id`                                                                                                                                                                  | Required if you use the `start` mode.      | VPC Subnet Id (`default: subnet-009c04af0177247e8`) <br><br> The subnet should belong to the same VPC as the specified security group.                                                                                                                                                                                                |
| `security-group-id`                                                                                                                                                          | Required if you use the `start` mode.      | EC2 Security Group Id (`default: sg-010daba499648d1e7`) <br><br> The security group should belong to the same VPC as the specified subnet. <br><br> Only the outbound traffic for port 443 should be allowed. No inbound traffic is required.                                                                                         |
| `aws-nfs-logging`                                                                                                                                                            | Required if you use the `start` mode.      | Flag for enabling or disabling NFS logging (`default: false`)                                                                                                                                                                                                                                                                         |
| `aws-nfs-host`                                                                                                                                                               | Required if you use the `start` mode.      | NFS host in AWS for logging (`default: fs-0f9f29caae5ade69c.efs.eu-west-1.amazonaws.com`)                                                                                                                                                                                                                                             |
| `github-runner-version`                                                                                                                                                      | Required if you use the `start` mode.      | GitHub runner releases version (`default: 2.296.2`)                                                                                                                                                                                                                                                                                   |
| `label`                                                                                                                                                                      | Required if you use the `stop` mode.       | Name of the unique label assigned to the runner. <br><br> The label is provided by the output of the action in the `start` mode. <br><br> The label is used to remove the runner from GitHub when the runner is not needed anymore.                                                                                                   |
| `ec2-instance-id`                                                                                                                                                            | Required if you use the `stop` mode.       | EC2 Instance Id of the created runner. <br><br> The id is provided by the output of the action in the `start` mode. <br><br> The id is used to terminate the EC2 instance when the runner is not needed anymore.                                                                                                                      |

Outputs:

- `label`
- `ec2-instance-id`

## Contribute

Open a PR to contribute, the CI and reviewer will take care of the rest.
