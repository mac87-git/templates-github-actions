# 🔍 Compare List of Metadata Files

This GitHub Action compares two CSV files representing versions of metadata file inventories. Each row in the CSV must include a file path and the MD5 hash of its contents.

The action determines:
- 🆕 Files that are new (present in the first file but not in the second)
- 🗑️ Files that have been deleted
- ✏️ Files that have been modified (same path, different hash)

---

## 📦 What It Does

- Parses both CSV files into dictionaries
- Compares paths and MD5 hashes between versions
- Outputs whitespace-separated lists of changed files

---

## 📥 Inputs

| Name      | Description                    | Required |
|-----------|--------------------------------|----------|
| `file-1`  | Path to the first CSV file     | ✅ Yes   |
| `file-2`  | Path to the second CSV file    | ✅ Yes   |

> `file-1` typically represents the **current state**, and `file-2` the **previous version**.

---

## 📤 Outputs

| Name            | Description                                 |
|-----------------|---------------------------------------------|
| `new-files`     | Whitespace-separated list of new files      |
| `deleted-files` | Whitespace-separated list of deleted files  |
| `modified-files`| Whitespace-separated list of modified files |

---

## 🧪 Usage Example

```yaml
jobs:
  compare-metadata:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Run metadata comparison
        uses: ClipMX/data-github-actions-templates/.github/actions/uc-metadata-compare-action@main
        with:
          file-1: "current_metadata.csv"
          file-2: "previous_metadata.csv"

      - name: Print changes
        run: |
          echo "New files: ${{ steps.compare-metadata.outputs.new-files }}"
          echo "Deleted files: ${{ steps.compare-metadata.outputs.deleted-files }}"
          echo "Modified files: ${{ steps.compare-metadata.outputs.modified-files }}"
```

## 📁 CSV Format

The CSV files must contain two columns:

```
<path>,<md5>
```

Example:

```
data/models/file_a.yml,d41d8cd98f00b204e9800998ecf8427e
data/models/file_b.yml,e2fc714c4727ee9395f324cd2e7f331f
```

> Headers are not required.