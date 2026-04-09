# neovim-treesitter

**Distributed tree-sitter query maintenance for Neovim.**

---

## Goals

The `neovim-treesitter` org exists to make tree-sitter queries a
**community-maintained, per-language concern** rather than a monolithic
bottleneck. We aim to:

- **Distribute ownership** — each language's Neovim queries are maintained
  by people who actually use that language, not by a small core team
  reviewing 300+ languages.

- **Decouple queries from parsers** — query updates and parser bumps ship
  independently, so a highlight fix for Python doesn't block a grammar
  update for Rust.

- **Provide shared infrastructure** — reusable CI workflows, a schema-validated
  parser registry, and automated version-bump tooling so maintainers can
  focus on query quality rather than plumbing.

- **Encourage upstream ownership** — parser authors are the best people to
  maintain Neovim queries for their grammar. We provide the CI and registry
  support to make shipping queries directly from the parser repo (the
  **self-contained** model) straightforward.

---

## How it works

### The parser registry

The [treesitter-parser-registry](https://github.com/neovim-treesitter/treesitter-parser-registry)
is an editor-agnostic catalogue of every known tree-sitter parser and where
its Neovim queries live. The registry is designed to be consumed by any
installer — [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
is the first consumer, and the schema is open for others to adopt.

Each language has one of these source types:

| Type | Meaning |
|------|---------|
| `self_contained` | Queries ship inside the upstream parser repo |
| `external_queries` | Queries live in a separate `nvim-treesitter-queries-<lang>` repo |
| `queries_only` | No parser — shared queries inherited by other languages |

### Query repos

For languages that don't ship their own queries, we maintain ~330
individual `nvim-treesitter-queries-<lang>` repositories. Each has:

- Neovim query `.scm` files (highlights, injections, folds, indents, locals)
- A `parser.json` manifest pinning the parser version queries are tested against
- CI that validates queries on every push and PR
- Automated weekly checks for upstream parser releases

### Reusable CI

All CI is centralised as reusable workflows in this
[`.github`](https://github.com/neovim-treesitter/.github) repo:

- **[query-validate.yml]** — validates queries for `external_queries` repos
- **[self-contained-validate.yml]** — validates queries for `self_contained` parser repos
- **[query-bump.yml]** — automated parser version bumping

[query-validate.yml]: https://github.com/neovim-treesitter/.github/blob/main/.github/workflows/query-validate.yml
[self-contained-validate.yml]: https://github.com/neovim-treesitter/.github/blob/main/.github/workflows/self-contained-validate.yml
[query-bump.yml]: https://github.com/neovim-treesitter/.github/blob/main/.github/workflows/query-bump.yml

---

## Own your queries

**If you maintain a tree-sitter parser, we want to help you ship Neovim
queries directly from your repo.**

Shipping queries alongside your grammar means:

- Query changes can land in the same PR as grammar changes
- You control the quality and release cadence
- Users get queries that are always tested against the correct parser version
- No dependency on a separate repo or external maintainer

### Getting started

1. Add `nvim-queries/<lang>/` to your parser repo with `.scm` files
2. Add a CI job calling our reusable workflow (4 lines of YAML)
3. Open a PR against the registry to mark your language as `self_contained`

Full walkthrough: **[Self-Contained Migration Guide](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/self-contained-migration.md)**

Reference implementation: **[tree-sitter-zsh](https://github.com/georgeharker/tree-sitter-zsh)**

### Already have a query repo?

If your language already has an `nvim-treesitter-queries-<lang>` repo and
you'd like to take ownership:

- **Claim maintainership** — open a PR adding yourself to `CODEOWNERS` in
  the query repo
- **Or migrate to self-contained** — move queries into your parser repo and
  we'll archive the standalone query repo

Either way, the community benefits from active maintenance.

---

## Documentation

| Document | Description |
|----------|-------------|
| [Registry overview](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/overview.md) | Motivation and design of the distributed model |
| [Architecture](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/architecture.md) | Full system design — registry format, source types, installer integration |
| [Contributing](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/contributing.md) | Adding languages, creating query repos, governance |
| [Testing](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/testing.md) | Running CI locally, ts_query_ls, corpus tests, dependency resolution |
| [Self-contained migration](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/self-contained-migration.md) | Guide for parser maintainers shipping their own queries |
| [Registry schema](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/schemas/schema.json) | JSON Schema for `registry.json` and `parser.json` |

---

## Get involved

- **Parser authors** — ship queries with your grammar using the
  [self-contained guide](https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/docs/self-contained-migration.md)
- **Language users** — claim maintainership of a query repo for a language
  you use daily
- **Query contributors** — improve highlights, injections, folds, and
  indents for any language

Questions or ideas? Open an issue on the
[registry repo](https://github.com/neovim-treesitter/treesitter-parser-registry/issues).
