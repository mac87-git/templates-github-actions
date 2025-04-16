# ✅ Validate Unity Catalog Metadata Files

This GitHub action validates the YAML metadata files used for the Databricks Unity Catalog update process by:

---

## 📦 What It Does

- Lints all provided YAML files using a temporary `yamllint` config
- Validates each file against a defined schema (`schema.yml`)
- Fails the workflow if any file is invalid

---

## 🧾 Inputs

| Input       | Description                                               | Required |
|-------------|-----------------------------------------------------------|----------|
| `file-list` | List of YAML files to validate, separated by spaces       | ✅ Yes   |

---

## 📤 Outputs

This action does **not** return outputs. It will fail the job if validation does not pass.

---

## 🧰 Schema Requirements

The schema that YAML files must comply with is defined in the `schema.yml` file.

---

## 🚀 Usage

### Example: Use in a workflow

```yaml
name: Validate metadata files

on:
  pull_request:
    branches:
      - 'develop'
      - 'master'
    paths:
      - 'catalog_metadata/**'

jobs:
  validate-metadata:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Validate metadata yml files
        uses: ClipMX/data-github-actions-templates/.github/actions/uc-metadata-validate-action@main
        with:
          file-list: "metadata/file1.yml metadata/file2.yml"
```