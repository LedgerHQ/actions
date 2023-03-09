import core = require('@actions/core');
import yaml = require('js-yaml');
import fs = require('fs');

const editYaml = (path: string, editFn: any) => {
    let content: any = {};
    if (fs.existsSync(path)) {
        content = yaml.load(fs.readFileSync(path, 'utf-8'));
    }
    const newContent = editFn(content);
    fs.writeFileSync(path, yaml.dump(newContent));
}

try {
    const name = core.getInput('name');
    const version = core.getInput('version');
    const specUrl = core.getInput('spec-url');

    const normalizedName = name.replace(/ /g, '-').toLowerCase();
    const referencePage = `openapi/${normalizedName}.page.yaml`;
    const definitionId = `${normalizedName}-${version}`;
    const title = `${name} API (${version})`;
    const versionDict = {
        "definitionId": definitionId,
        "id": version.replace(/\./g, '-'),
        "title": title,
        "isDefault": true
    };

    editYaml(referencePage, (content: any) => {
        content.type = "reference-docs";
        content.settings = {"jsonSampleExpandLevel": "all", "pagination": "none"};
        if (!("versions" in content)) {
            content.versions = [];
        }
        for (let i = 0; i < content.versions.length; i++) {
            content.versions[i].isDefault = false;
        }
        content.versions.push(versionDict);
        return content;
    });

    editYaml("./sidebars.yaml", (content: any) => {
        const page = content.training.find((p: any) => p.page === referencePage);
        if (!page) {
            content.training.push({"label": name, "page": referencePage});
        }
        return content;
    });

    editYaml("./siteConfig.yaml", (content: any) => {
        content.oasDefinitions[definitionId] = specUrl;
        return content;
    });
} catch (error) {
    core.setFailed(error.message);
}
