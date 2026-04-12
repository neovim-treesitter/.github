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

---

### `self-contained-validate.yml`

Validates queries and runs highlight assertion tests for **self-contained** parser repos — repos where Neovim queries ship alongside the grammar itself.

**Usage** — add `.github/workflows/nvim-queries.yml` to your parser repo:

```yaml
name: Validate Queries (Self-Contained)

on:
  push:
    branches: [main]
    paths:
      - "nvim-queries/mylang/**"
      - "tests/**"
      - "parser.json"
  pull_request:
    branches: [main]
    paths:
      - "nvim-queries/mylang/**"
      - "tests/**"
      - "parser.json"
  workflow_dispatch:

jobs:
  validate:
    uses: neovim-treesitter/.github/.github/workflows/self-contained-validate.yml@main
```

No `with:` inputs are needed — the workflow reads `parser.json` from the repo root.

**What it does:**

1. Reads `parser.json` for configuration (`lang`, `queries_dir`, `test_dir`, `location`, `inject_deps`, `inherits`)
2. Builds the parser `.so` from source using `tree-sitter build`
3. Resolves `; inherits:` query dependencies via BFS
4. Builds injection dependency parsers if `inject_deps` is specified
5. Runs `ts_query_ls check` to validate all `.scm` files
6. Runs highlight assertion tests if `test_dir` is specified and the directory exists

**Requirements** — the calling repo must have a `parser.json` at the root with at least `lang` and one of `queries_dir` or `queries_path`. See the [self-contained migration guide](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/self-contained-migration.md) and the [schema](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/schemas/schema.json).
