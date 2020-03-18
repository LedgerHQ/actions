const core = require('@actions/core');

const main = async () => {
  const username = core.getInput('username', { required: true });
  const ban = core.getInput('ban', { required: true });

  if (username === ban) {
    throw new Error(`${username} is not allowed to trigger this CI`);
  }
};

main().catch(err => core.setFailed(err.message));
