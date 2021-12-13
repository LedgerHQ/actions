import * as github from '@actions/github';
import * as core from '@actions/core';

function checkStatus(result) {
  if (result.status >= 200 && result.status < 300) {
    return result;
  }

  core.setFailed(`Received status ${result.status} from API.`);
  process.exit();
}

const main = async function (): Promise<void> {
  const username = core.getInput('usename');
  const organisation = core.getInput('organisation');
  const token = core.getInput('token');

  const octokit = github.getOctokit(token);

  const { data: orgs } = checkStatus(
    await octokit.rest.orgs.listForUser({
      username,
      per_page: 100,
    })
  );

  const isMember = orgs.some(
    ({ login }) => login.toLowerCase() === organisation.toLowerCase()
  );

  if (!isMember) {
    core.setFailed(
      `${username} is not part of the ${organisation} organisation`
    );
  }
};

main();
