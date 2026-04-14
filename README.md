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

---

### `query-bump.yml`

Checks whether a query repo's `parser.json` points at the latest upstream parser version and, if not, validates the queries against the new version before opening a bump PR automatically.

**Usage** — add `.github/workflows/bump.yml` to any parser query repo:

```yaml
name: Bump Parser Version

on:
  schedule:
    - cron: "0 4 * * *"   # run daily; adjust as needed
  workflow_dispatch:

jobs:
  bump:
    uses: neovim-treesitter/.github/.github/workflows/query-bump.yml@main
```

No `with:` inputs are required — the workflow reads everything from `parser.json`.

**What it does:**

1. Reads `parser.json` for `lang`, `url`, `parser_version`, `semver`, and `queries_only`
2. Skips the run entirely if `queries_only` is `true`
3. Skips if the repo has no tests (tests are required before an automated PR is created)
4. Resolves the latest upstream version:
   - If `semver: true` — picks the highest `vX.Y…` tag via `git ls-remote --tags`
   - Otherwise — uses the current `HEAD` commit SHA via `git ls-remote`
5. If the latest version already matches `parser_version`, exits with no action
6. Otherwise, sets up the full query environment (builds parser `.so` at the **new** version, resolves `; inherits:` deps)
7. Runs `tree-sitter test` against corpus fixtures if `test/corpus/*.txt` exists
8. Runs highlight assertion tests (via `highlight-assertions`) against `tests/highlights/*` if present
9. Only if all tests pass: commits the updated `parser_version` to a branch `bump-parser-version/<version>` and opens a PR (skipped if the PR already exists)

**Requirements:**

- The calling repo must have a `parser.json` conforming to the [schema](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/schemas/schema.json)
- The repo must contain at least one test suite (`test/corpus/*.txt` or `tests/highlights/*`) — the workflow will not create a bump PR without passing tests
- The workflow needs `contents: write` and `pull-requests: write` permissions (inherited automatically when called via `workflow_call`/`workflow_dispatch` with default token permissions)
