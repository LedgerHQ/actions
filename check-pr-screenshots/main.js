const core = require('@actions/core');
const github = require('@actions/github');

const main = async () => {
  if (github.context) {
    const { payload } = github.context;
    if (payload.head_commit) {
      const found = payload.head_commit.message.indexOf('[Screenshots]');
      if (found > 0) {
        throw new Error('stop right here, this is a screenshot PR');
      } else {
        core.info('normal PR, go on as you were');
      }
    }
  }
};

main()
  .then()
  .catch((err) => core.setFailed(err.message));
