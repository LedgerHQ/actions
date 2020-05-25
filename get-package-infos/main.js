const core = require('@actions/core');
const semver = require('semver');
const fs = require('fs');

const main = async () => {
  const packageName =
    core.getInput('package', { required: false }) || 'package.json';
  const json = fs.readFileSync(`./${packageName}`, 'utf8');
  const pkg = JSON.parse(json);

  const { version } = semver.coerce(pkg.version);

  core.setOutput('version', pkg.version);
  core.setOutput('clean', version);
  core.setOutput('name', pkg.name);
};

main().catch((err) => core.setFailed(err.message));
