import * as core from '@actions/core';
import { join } from 'path';
import { promises as fs } from 'fs';

async function main() {
  const workspace = core.getInput('workspace');
  const pkg = core.getInput('package');
  const packagePath = join(workspace, pkg);
  core.debug(packagePath);
  try {
    const p = await fs.readFile(packagePath, 'utf8');
    core.debug(p);
    if (!p) {
      core.setOutput('has-hash-commit-deps', false);
      return;
    }
    const json = JSON.parse(p);
    const { dependencies = {}, devDependencies = {} } = json;
    const versions = Object.keys(dependencies)
      .map((key) => dependencies[key])
      .concat(Object.keys(devDependencies).map((key) => devDependencies[key]));
    const has = versions.some((v) => v.includes('.git'));
    core.setOutput('has-hash-commit-deps', has);
    return;
  } catch (error) {
    core.debug(error);
    throw error;
  }
}

main().catch((err) => core.setFailed(err));
