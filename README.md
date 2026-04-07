# neovim-treesitter/.github

Org-wide GitHub Actions workflows and community health files for the [neovim-treesitter](https://github.com/neovim-treesitter) organisation.

## Reusable workflows

### `query-validate.yml`

Validates tree-sitter queries and optionally runs corpus tests for a `nvim-treesitter-queries-<lang>` repository.

**Usage** — add `.github/workflows/validate.yml` to any parser query repo:

```yaml
name: Validate Queries

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validate:
    uses: neovim-treesitter/.github/.github/workflows/query-validate.yml@main
```

**What it does:**

1. Reads `parser.json` at the repo root for parser metadata (`lang`, `url`, `min_version`, `location`, `queries_only`)
2. Builds the parser `.so` from source at `min_version`
3. Resolves `; inherits:` query dependencies via BFS, fetching query files and building parsers for each transitive dependency
4. Runs `ts_query_ls check queries/` to validate all `.scm` files
5. Runs `tree-sitter test` if `test/corpus/*.txt` exists

**Requirements** — the calling repo must have a `parser.json` at the root conforming to the [schema](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/schemas/schema.json).
