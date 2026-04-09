# neovim-treesitter

**Distributed tree-sitter query maintenance for Neovim.**

---

## Key Repositories

| Repository | Description |
|------------|-------------|
| [treesitter-parser-registry](https://github.com/neovim-treesitter/treesitter-parser-registry) | Editor-agnostic parser catalogue — `registry.json`, schema, documentation |
| [nvim-treesitter](https://github.com/neovim-treesitter/nvim-treesitter) | Neovim plugin — parser installer, query runtime, `:TSInstall` UX |
| [.github](https://github.com/neovim-treesitter/.github) | Org-wide reusable CI workflows and community health files |

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
installer — [nvim-treesitter](https://github.com/neovim-treesitter/nvim-treesitter)
is the first consumer, and the schema is open for others to adopt.

Each language has one of these source types:

| Type | Meaning |
|------|---------|
| `self_contained` | Queries ship inside the upstream parser repo |
| `external_queries` | Queries live in a separate `nvim-treesitter-queries-<lang>` repo |
| `queries_only` | No parser — shared queries inherited by other languages |

### Query repos

For languages that don't ship their own queries, we maintain individual
`nvim-treesitter-queries-<lang>` repositories. Each has:

- Neovim query `.scm` files (highlights, injections, folds, indents, locals)
- A `parser.json` manifest pinning the parser version queries are tested against
- CI that validates queries on every push and PR
- Automated weekly checks for upstream parser releases

### Reusable CI

All CI is centralised as reusable workflows in the
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

## Supported Languages

<!-- BEGIN LANGUAGE LIST -->
> **329 languages** — 1 self-contained, 325 external queries, 3 queries-only
>
> *This table is auto-generated from [registry.json]. Do not edit manually.*

<details>
<summary>Supported languages</summary>

| Language | Parser | Queries |
|----------|--------|---------|
| ada | [parser](https://github.com/briot/tree-sitter-ada) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ada) |
| agda | [parser](https://github.com/tree-sitter/tree-sitter-agda) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-agda) |
| angular | [parser](https://github.com/dlvandenberg/tree-sitter-angular) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-angular) |
| apex | [parser](https://github.com/aheber/tree-sitter-sfapex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-apex) |
| arduino | [parser](https://github.com/tree-sitter-grammars/tree-sitter-arduino) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-arduino) |
| asm | [parser](https://github.com/RubixDev/tree-sitter-asm) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-asm) |
| astro | [parser](https://github.com/virchau13/tree-sitter-astro) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-astro) |
| authzed | [parser](https://github.com/mleonidas/tree-sitter-authzed) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-authzed) |
| awk | [parser](https://github.com/Beaglefoot/tree-sitter-awk) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-awk) |
| bash | [parser](https://github.com/tree-sitter/tree-sitter-bash) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bash) |
| bass | [parser](https://github.com/vito/tree-sitter-bass) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bass) |
| beancount | [parser](https://github.com/polarmutex/tree-sitter-beancount) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-beancount) |
| bibtex | [parser](https://github.com/latex-lsp/tree-sitter-bibtex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bibtex) |
| bicep | [parser](https://github.com/tree-sitter-grammars/tree-sitter-bicep) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bicep) |
| bitbake | [parser](https://github.com/tree-sitter-grammars/tree-sitter-bitbake) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bitbake) |
| blade | [parser](https://github.com/EmranMR/tree-sitter-blade) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-blade) |
| bp | [parser](https://github.com/ambroisie/tree-sitter-bp) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bp) |
| bpftrace | [parser](https://github.com/sgruszka/tree-sitter-bpftrace) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-bpftrace) |
| brightscript | [parser](https://github.com/ajdelcimmuto/tree-sitter-brightscript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-brightscript) |
| c | [parser](https://github.com/tree-sitter/tree-sitter-c) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-c) |
| c3 | [parser](https://github.com/c3lang/tree-sitter-c3) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-c3) |
| c_sharp | [parser](https://github.com/tree-sitter/tree-sitter-c-sharp) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-c_sharp) |
| caddy | [parser](https://github.com/opa-oz/tree-sitter-caddy) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-caddy) |
| cairo | [parser](https://github.com/tree-sitter-grammars/tree-sitter-cairo) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cairo) |
| capnp | [parser](https://github.com/tree-sitter-grammars/tree-sitter-capnp) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-capnp) |
| chatito | [parser](https://github.com/tree-sitter-grammars/tree-sitter-chatito) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-chatito) |
| circom | [parser](https://github.com/Decurity/tree-sitter-circom) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-circom) |
| clojure | [parser](https://github.com/sogaiu/tree-sitter-clojure) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-clojure) |
| cmake | [parser](https://github.com/uyha/tree-sitter-cmake) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cmake) |
| comment | [parser](https://github.com/stsewd/tree-sitter-comment) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-comment) |
| commonlisp | [parser](https://github.com/tree-sitter-grammars/tree-sitter-commonlisp) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-commonlisp) |
| cooklang | [parser](https://github.com/addcninblue/tree-sitter-cooklang) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cooklang) |
| corn | [parser](https://github.com/jakestanger/tree-sitter-corn) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-corn) |
| cpon | [parser](https://github.com/tree-sitter-grammars/tree-sitter-cpon) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cpon) |
| cpp | [parser](https://github.com/tree-sitter/tree-sitter-cpp) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cpp) |
| css | [parser](https://github.com/tree-sitter/tree-sitter-css) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-css) |
| csv | [parser](https://github.com/tree-sitter-grammars/tree-sitter-csv) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-csv) |
| cuda | [parser](https://github.com/tree-sitter-grammars/tree-sitter-cuda) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cuda) |
| cue | [parser](https://github.com/eonpatapon/tree-sitter-cue) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cue) |
| cylc | [parser](https://github.com/elliotfontaine/tree-sitter-cylc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-cylc) |
| d | [parser](https://github.com/gdamore/tree-sitter-d) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-d) |
| dart | [parser](https://github.com/UserNobody14/tree-sitter-dart) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-dart) |
| desktop | [parser](https://github.com/ValdezFOmar/tree-sitter-desktop) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-desktop) |
| devicetree | [parser](https://github.com/joelspadin/tree-sitter-devicetree) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-devicetree) |
| dhall | [parser](https://github.com/jbellerb/tree-sitter-dhall) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-dhall) |
| diff | [parser](https://github.com/tree-sitter-grammars/tree-sitter-diff) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-diff) |
| disassembly | [parser](https://github.com/ColinKennedy/tree-sitter-disassembly) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-disassembly) |
| djot | [parser](https://github.com/treeman/tree-sitter-djot) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-djot) |
| dockerfile | [parser](https://github.com/camdencheek/tree-sitter-dockerfile) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-dockerfile) |
| dot | [parser](https://github.com/rydesun/tree-sitter-dot) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-dot) |
| doxygen | [parser](https://github.com/tree-sitter-grammars/tree-sitter-doxygen) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-doxygen) |
| dtd | [parser](https://github.com/tree-sitter-grammars/tree-sitter-xml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-dtd) |
| earthfile | [parser](https://github.com/glehmann/tree-sitter-earthfile) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-earthfile) |
| ebnf | [parser](https://github.com/RubixDev/ebnf) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ebnf) |
| ecma | — | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ecma) |
| editorconfig | [parser](https://github.com/ValdezFOmar/tree-sitter-editorconfig) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-editorconfig) |
| eds | [parser](https://github.com/uyha/tree-sitter-eds) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-eds) |
| eex | [parser](https://github.com/connorlay/tree-sitter-eex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-eex) |
| elixir | [parser](https://github.com/elixir-lang/tree-sitter-elixir) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-elixir) |
| elm | [parser](https://github.com/elm-tooling/tree-sitter-elm) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-elm) |
| elsa | [parser](https://github.com/glapa-grossklag/tree-sitter-elsa) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-elsa) |
| elvish | [parser](https://github.com/elves/tree-sitter-elvish) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-elvish) |
| embedded_template | [parser](https://github.com/tree-sitter/tree-sitter-embedded-template) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-embedded_template) |
| enforce | [parser](https://github.com/simonvic/tree-sitter-enforce) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-enforce) |
| erlang | [parser](https://github.com/WhatsApp/tree-sitter-erlang) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-erlang) |
| facility | [parser](https://github.com/FacilityApi/tree-sitter-facility) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-facility) |
| faust | [parser](https://github.com/khiner/tree-sitter-faust) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-faust) |
| fennel | [parser](https://github.com/alexmozaidze/tree-sitter-fennel) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-fennel) |
| fidl | [parser](https://github.com/google/tree-sitter-fidl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-fidl) |
| firrtl | [parser](https://github.com/tree-sitter-grammars/tree-sitter-firrtl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-firrtl) |
| fish | [parser](https://github.com/ram02z/tree-sitter-fish) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-fish) |
| foam | [parser](https://github.com/FoamScience/tree-sitter-foam) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-foam) |
| forth | [parser](https://github.com/AlexanderBrevig/tree-sitter-forth) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-forth) |
| fortran | [parser](https://github.com/stadelmanma/tree-sitter-fortran) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-fortran) |
| fsh | [parser](https://github.com/mgramigna/tree-sitter-fsh) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-fsh) |
| fsharp | [parser](https://github.com/ionide/tree-sitter-fsharp) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-fsharp) |
| func | [parser](https://github.com/tree-sitter-grammars/tree-sitter-func) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-func) |
| gap | [parser](https://github.com/gap-system/tree-sitter-gap) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gap) |
| gaptst | [parser](https://github.com/gap-system/tree-sitter-gaptst) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gaptst) |
| gdscript | [parser](https://github.com/PrestonKnopp/tree-sitter-gdscript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gdscript) |
| gdshader | [parser](https://github.com/airblast-dev/tree-sitter-gdshader) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gdshader) |
| git_config | [parser](https://github.com/the-mikedavis/tree-sitter-git-config) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-git_config) |
| git_rebase | [parser](https://github.com/the-mikedavis/tree-sitter-git-rebase) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-git_rebase) |
| gitattributes | [parser](https://github.com/tree-sitter-grammars/tree-sitter-gitattributes) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gitattributes) |
| gitcommit | [parser](https://github.com/gbprod/tree-sitter-gitcommit) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gitcommit) |
| gitignore | [parser](https://github.com/shunsambongi/tree-sitter-gitignore) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gitignore) |
| gleam | [parser](https://github.com/gleam-lang/tree-sitter-gleam) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gleam) |
| glimmer | [parser](https://github.com/ember-tooling/tree-sitter-glimmer) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-glimmer) |
| glimmer_javascript | [parser](https://github.com/NullVoxPopuli/tree-sitter-glimmer-javascript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-glimmer_javascript) |
| glimmer_typescript | [parser](https://github.com/NullVoxPopuli/tree-sitter-glimmer-typescript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-glimmer_typescript) |
| glsl | [parser](https://github.com/tree-sitter-grammars/tree-sitter-glsl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-glsl) |
| gn | [parser](https://github.com/tree-sitter-grammars/tree-sitter-gn) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gn) |
| gnuplot | [parser](https://github.com/dpezto/tree-sitter-gnuplot) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gnuplot) |
| go | [parser](https://github.com/tree-sitter/tree-sitter-go) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-go) |
| goctl | [parser](https://github.com/chaozwn/tree-sitter-goctl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-goctl) |
| godot_resource | [parser](https://github.com/PrestonKnopp/tree-sitter-godot-resource) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-godot_resource) |
| gomod | [parser](https://github.com/camdencheek/tree-sitter-go-mod) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gomod) |
| gosum | [parser](https://github.com/tree-sitter-grammars/tree-sitter-go-sum) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gosum) |
| gotmpl | [parser](https://github.com/ngalaiko/tree-sitter-go-template) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gotmpl) |
| gowork | [parser](https://github.com/omertuc/tree-sitter-go-work) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gowork) |
| gpg | [parser](https://github.com/tree-sitter-grammars/tree-sitter-gpg-config) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gpg) |
| graphql | [parser](https://github.com/bkegley/tree-sitter-graphql) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-graphql) |
| gren | [parser](https://github.com/MaeBrooks/tree-sitter-gren) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gren) |
| groovy | [parser](https://github.com/murtaza64/tree-sitter-groovy) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-groovy) |
| groq | [parser](https://github.com/ajrussellaudio/tree-sitter-groq) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-groq) |
| gstlaunch | [parser](https://github.com/tree-sitter-grammars/tree-sitter-gstlaunch) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-gstlaunch) |
| hack | [parser](https://github.com/slackhq/tree-sitter-hack) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hack) |
| hare | [parser](https://github.com/tree-sitter-grammars/tree-sitter-hare) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hare) |
| haskell | [parser](https://github.com/tree-sitter-grammars/tree-sitter-haskell) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-haskell) |
| haskell_persistent | [parser](https://github.com/MercuryTechnologies/tree-sitter-haskell-persistent) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-haskell_persistent) |
| hcl | [parser](https://github.com/tree-sitter-grammars/tree-sitter-hcl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hcl) |
| heex | [parser](https://github.com/connorlay/tree-sitter-heex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-heex) |
| helm | [parser](https://github.com/ngalaiko/tree-sitter-go-template) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-helm) |
| hjson | [parser](https://github.com/winston0410/tree-sitter-hjson) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hjson) |
| hlsl | [parser](https://github.com/tree-sitter-grammars/tree-sitter-hlsl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hlsl) |
| hlsplaylist | [parser](https://github.com/Freed-Wu/tree-sitter-hlsplaylist) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hlsplaylist) |
| hocon | [parser](https://github.com/antosha417/tree-sitter-hocon) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hocon) |
| hoon | [parser](https://github.com/urbit-pilled/tree-sitter-hoon) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hoon) |
| html | [parser](https://github.com/tree-sitter/tree-sitter-html) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-html) |
| html_tags | — | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-html_tags) |
| htmldjango | [parser](https://github.com/interdependence/tree-sitter-htmldjango) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-htmldjango) |
| http | [parser](https://github.com/rest-nvim/tree-sitter-http) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-http) |
| hurl | [parser](https://github.com/pfeiferj/tree-sitter-hurl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hurl) |
| hyprlang | [parser](https://github.com/tree-sitter-grammars/tree-sitter-hyprlang) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-hyprlang) |
| idl | [parser](https://github.com/cathaysia/tree-sitter-idl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-idl) |
| idris | [parser](https://github.com/kayhide/tree-sitter-idris) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-idris) |
| ini | [parser](https://github.com/justinmk/tree-sitter-ini) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ini) |
| inko | [parser](https://github.com/inko-lang/tree-sitter-inko) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-inko) |
| ispc | [parser](https://github.com/tree-sitter-grammars/tree-sitter-ispc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ispc) |
| janet_simple | [parser](https://github.com/sogaiu/tree-sitter-janet-simple) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-janet_simple) |
| java | [parser](https://github.com/tree-sitter/tree-sitter-java) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-java) |
| javadoc | [parser](https://github.com/rmuir/tree-sitter-javadoc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-javadoc) |
| javascript | [parser](https://github.com/tree-sitter/tree-sitter-javascript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-javascript) |
| jinja | [parser](https://github.com/cathaysia/tree-sitter-jinja) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jinja) |
| jinja_inline | [parser](https://github.com/cathaysia/tree-sitter-jinja) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jinja_inline) |
| jjdescription | [parser](https://github.com/ribru17/tree-sitter-jjdescription) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jjdescription) |
| jq | [parser](https://github.com/flurie/tree-sitter-jq) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jq) |
| jsdoc | [parser](https://github.com/tree-sitter/tree-sitter-jsdoc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jsdoc) |
| json | [parser](https://github.com/tree-sitter/tree-sitter-json) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-json) |
| json5 | [parser](https://github.com/Joakker/tree-sitter-json5) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-json5) |
| jsonnet | [parser](https://github.com/sourcegraph/tree-sitter-jsonnet) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jsonnet) |
| jsx | — | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-jsx) |
| julia | [parser](https://github.com/tree-sitter-grammars/tree-sitter-julia) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-julia) |
| just | [parser](https://github.com/IndianBoy42/tree-sitter-just) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-just) |
| kcl | [parser](https://github.com/kcl-lang/tree-sitter-kcl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kcl) |
| kconfig | [parser](https://github.com/tree-sitter-grammars/tree-sitter-kconfig) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kconfig) |
| kdl | [parser](https://github.com/tree-sitter-grammars/tree-sitter-kdl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kdl) |
| kitty | [parser](https://github.com/OXY2DEV/tree-sitter-kitty) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kitty) |
| kos | [parser](https://github.com/kos-lang/tree-sitter-kos) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kos) |
| kotlin | [parser](https://github.com/fwcd/tree-sitter-kotlin) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kotlin) |
| koto | [parser](https://github.com/koto-lang/tree-sitter-koto) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-koto) |
| kusto | [parser](https://github.com/Willem-J-an/tree-sitter-kusto) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-kusto) |
| lalrpop | [parser](https://github.com/traxys/tree-sitter-lalrpop) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-lalrpop) |
| latex | [parser](https://github.com/latex-lsp/tree-sitter-latex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-latex) |
| ledger | [parser](https://github.com/cbarrete/tree-sitter-ledger) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ledger) |
| leo | [parser](https://github.com/r001/tree-sitter-leo) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-leo) |
| linkerscript | [parser](https://github.com/tree-sitter-grammars/tree-sitter-linkerscript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-linkerscript) |
| liquid | [parser](https://github.com/hankthetank27/tree-sitter-liquid) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-liquid) |
| liquidsoap | [parser](https://github.com/savonet/tree-sitter-liquidsoap) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-liquidsoap) |
| llvm | [parser](https://github.com/benwilliamgraham/tree-sitter-llvm) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-llvm) |
| lua | [parser](https://github.com/tree-sitter-grammars/tree-sitter-lua) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-lua) |
| luadoc | [parser](https://github.com/tree-sitter-grammars/tree-sitter-luadoc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-luadoc) |
| luap | [parser](https://github.com/tree-sitter-grammars/tree-sitter-luap) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-luap) |
| luau | [parser](https://github.com/tree-sitter-grammars/tree-sitter-luau) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-luau) |
| m68k | [parser](https://github.com/grahambates/tree-sitter-m68k) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-m68k) |
| make | [parser](https://github.com/tree-sitter-grammars/tree-sitter-make) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-make) |
| markdown | [parser](https://github.com/tree-sitter-grammars/tree-sitter-markdown) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-markdown) |
| markdown_inline | [parser](https://github.com/tree-sitter-grammars/tree-sitter-markdown) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-markdown_inline) |
| matlab | [parser](https://github.com/acristoffers/tree-sitter-matlab) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-matlab) |
| menhir | [parser](https://github.com/Kerl13/tree-sitter-menhir) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-menhir) |
| mermaid | [parser](https://github.com/monaqa/tree-sitter-mermaid) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-mermaid) |
| meson | [parser](https://github.com/tree-sitter-grammars/tree-sitter-meson) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-meson) |
| mlir | [parser](https://github.com/artagnon/tree-sitter-mlir) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-mlir) |
| muttrc | [parser](https://github.com/neomutt/tree-sitter-muttrc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-muttrc) |
| nasm | [parser](https://github.com/naclsn/tree-sitter-nasm) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nasm) |
| nginx | [parser](https://github.com/opa-oz/tree-sitter-nginx) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nginx) |
| nickel | [parser](https://github.com/nickel-lang/tree-sitter-nickel) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nickel) |
| nim | [parser](https://github.com/alaviss/tree-sitter-nim) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nim) |
| nim_format_string | [parser](https://github.com/aMOPel/tree-sitter-nim-format-string) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nim_format_string) |
| ninja | [parser](https://github.com/alemuller/tree-sitter-ninja) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ninja) |
| nix | [parser](https://github.com/nix-community/tree-sitter-nix) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nix) |
| nqc | [parser](https://github.com/tree-sitter-grammars/tree-sitter-nqc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nqc) |
| nu | [parser](https://github.com/nushell/tree-sitter-nu) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-nu) |
| objc | [parser](https://github.com/tree-sitter-grammars/tree-sitter-objc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-objc) |
| objdump | [parser](https://github.com/ColinKennedy/tree-sitter-objdump) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-objdump) |
| ocaml | [parser](https://github.com/tree-sitter/tree-sitter-ocaml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ocaml) |
| ocaml_interface | [parser](https://github.com/tree-sitter/tree-sitter-ocaml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ocaml_interface) |
| ocamllex | [parser](https://github.com/atom-ocaml/tree-sitter-ocamllex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ocamllex) |
| odin | [parser](https://github.com/tree-sitter-grammars/tree-sitter-odin) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-odin) |
| pascal | [parser](https://github.com/Isopod/tree-sitter-pascal) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pascal) |
| passwd | [parser](https://github.com/ath3/tree-sitter-passwd) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-passwd) |
| pem | [parser](https://github.com/tree-sitter-grammars/tree-sitter-pem) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pem) |
| perl | [parser](https://github.com/tree-sitter-perl/tree-sitter-perl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-perl) |
| php | [parser](https://github.com/tree-sitter/tree-sitter-php) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-php) |
| php_only | [parser](https://github.com/tree-sitter/tree-sitter-php) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-php_only) |
| phpdoc | [parser](https://github.com/claytonrcarter/tree-sitter-phpdoc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-phpdoc) |
| pioasm | [parser](https://github.com/leo60228/tree-sitter-pioasm) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pioasm) |
| pkl | [parser](https://github.com/apple/tree-sitter-pkl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pkl) |
| po | [parser](https://github.com/tree-sitter-grammars/tree-sitter-po) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-po) |
| pod | [parser](https://github.com/tree-sitter-perl/tree-sitter-pod) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pod) |
| poe_filter | [parser](https://github.com/tree-sitter-grammars/tree-sitter-poe-filter) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-poe_filter) |
| pony | [parser](https://github.com/tree-sitter-grammars/tree-sitter-pony) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pony) |
| powershell | [parser](https://github.com/airbus-cert/tree-sitter-powershell) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-powershell) |
| printf | [parser](https://github.com/tree-sitter-grammars/tree-sitter-printf) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-printf) |
| prisma | [parser](https://github.com/victorhqc/tree-sitter-prisma) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-prisma) |
| problog | [parser](https://github.com/foxyseta/tree-sitter-prolog) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-problog) |
| prolog | [parser](https://github.com/foxyseta/tree-sitter-prolog) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-prolog) |
| promql | [parser](https://github.com/MichaHoffmann/tree-sitter-promql) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-promql) |
| properties | [parser](https://github.com/tree-sitter-grammars/tree-sitter-properties) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-properties) |
| proto | [parser](https://github.com/coder3101/tree-sitter-proto) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-proto) |
| prql | [parser](https://github.com/PRQL/tree-sitter-prql) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-prql) |
| psv | [parser](https://github.com/tree-sitter-grammars/tree-sitter-csv) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-psv) |
| pug | [parser](https://github.com/zealot128/tree-sitter-pug) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pug) |
| puppet | [parser](https://github.com/tree-sitter-grammars/tree-sitter-puppet) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-puppet) |
| purescript | [parser](https://github.com/postsolar/tree-sitter-purescript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-purescript) |
| pymanifest | [parser](https://github.com/tree-sitter-grammars/tree-sitter-pymanifest) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-pymanifest) |
| python | [parser](https://github.com/tree-sitter/tree-sitter-python) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-python) |
| ql | [parser](https://github.com/tree-sitter/tree-sitter-ql) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ql) |
| qmldir | [parser](https://github.com/tree-sitter-grammars/tree-sitter-qmldir) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-qmldir) |
| qmljs | [parser](https://github.com/yuja/tree-sitter-qmljs) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-qmljs) |
| query | [parser](https://github.com/tree-sitter-grammars/tree-sitter-query) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-query) |
| r | [parser](https://github.com/r-lib/tree-sitter-r) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-r) |
| racket | [parser](https://github.com/6cdh/tree-sitter-racket) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-racket) |
| ralph | [parser](https://github.com/alephium/tree-sitter-ralph) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ralph) |
| rasi | [parser](https://github.com/Fymyte/tree-sitter-rasi) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rasi) |
| razor | [parser](https://github.com/tris203/tree-sitter-razor) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-razor) |
| rbs | [parser](https://github.com/joker1007/tree-sitter-rbs) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rbs) |
| re2c | [parser](https://github.com/tree-sitter-grammars/tree-sitter-re2c) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-re2c) |
| readline | [parser](https://github.com/tree-sitter-grammars/tree-sitter-readline) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-readline) |
| regex | [parser](https://github.com/tree-sitter/tree-sitter-regex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-regex) |
| rego | [parser](https://github.com/FallenAngel97/tree-sitter-rego) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rego) |
| requirements | [parser](https://github.com/tree-sitter-grammars/tree-sitter-requirements) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-requirements) |
| rescript | [parser](https://github.com/rescript-lang/tree-sitter-rescript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rescript) |
| rifleconf | [parser](https://github.com/purarue/tree-sitter-rifleconf) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rifleconf) |
| rnoweb | [parser](https://github.com/bamonroe/tree-sitter-rnoweb) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rnoweb) |
| robot | [parser](https://github.com/Hubro/tree-sitter-robot) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-robot) |
| robots_txt | [parser](https://github.com/opa-oz/tree-sitter-robots-txt) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-robots_txt) |
| roc | [parser](https://github.com/faldor20/tree-sitter-roc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-roc) |
| ron | [parser](https://github.com/tree-sitter-grammars/tree-sitter-ron) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ron) |
| rst | [parser](https://github.com/stsewd/tree-sitter-rst) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rst) |
| ruby | [parser](https://github.com/tree-sitter/tree-sitter-ruby) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ruby) |
| runescript | [parser](https://github.com/2004Scape/tree-sitter-runescript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-runescript) |
| rust | [parser](https://github.com/tree-sitter/tree-sitter-rust) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-rust) |
| scala | [parser](https://github.com/tree-sitter/tree-sitter-scala) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-scala) |
| scfg | [parser](https://github.com/rockorager/tree-sitter-scfg) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-scfg) |
| scheme | [parser](https://github.com/6cdh/tree-sitter-scheme) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-scheme) |
| scss | [parser](https://github.com/serenadeai/tree-sitter-scss) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-scss) |
| sflog | [parser](https://github.com/aheber/tree-sitter-sfapex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sflog) |
| slang | [parser](https://github.com/tree-sitter-grammars/tree-sitter-slang) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-slang) |
| slim | [parser](https://github.com/theoo/tree-sitter-slim) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-slim) |
| slint | [parser](https://github.com/slint-ui/tree-sitter-slint) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-slint) |
| smali | [parser](https://github.com/tree-sitter-grammars/tree-sitter-smali) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-smali) |
| smithy | [parser](https://github.com/indoorvivants/tree-sitter-smithy) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-smithy) |
| snakemake | [parser](https://github.com/osthomas/tree-sitter-snakemake) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-snakemake) |
| snl | [parser](https://github.com/minijackson/tree-sitter-snl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-snl) |
| solidity | [parser](https://github.com/JoranHonig/tree-sitter-solidity) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-solidity) |
| soql | [parser](https://github.com/aheber/tree-sitter-sfapex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-soql) |
| sosl | [parser](https://github.com/aheber/tree-sitter-sfapex) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sosl) |
| sourcepawn | [parser](https://github.com/nilshelmig/tree-sitter-sourcepawn) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sourcepawn) |
| sparql | [parser](https://github.com/GordianDziwis/tree-sitter-sparql) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sparql) |
| sproto | [parser](https://github.com/hanxi/tree-sitter-sproto) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sproto) |
| sql | [parser](https://github.com/derekstride/tree-sitter-sql) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sql) |
| squirrel | [parser](https://github.com/tree-sitter-grammars/tree-sitter-squirrel) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-squirrel) |
| ssh_config | [parser](https://github.com/tree-sitter-grammars/tree-sitter-ssh-config) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ssh_config) |
| starlark | [parser](https://github.com/tree-sitter-grammars/tree-sitter-starlark) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-starlark) |
| strace | [parser](https://github.com/sigmaSd/tree-sitter-strace) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-strace) |
| styled | [parser](https://github.com/mskelton/tree-sitter-styled) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-styled) |
| supercollider | [parser](https://github.com/madskjeldgaard/tree-sitter-supercollider) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-supercollider) |
| superhtml | [parser](https://github.com/kristoff-it/superhtml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-superhtml) |
| surface | [parser](https://github.com/connorlay/tree-sitter-surface) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-surface) |
| svelte | [parser](https://github.com/tree-sitter-grammars/tree-sitter-svelte) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-svelte) |
| sway | [parser](https://github.com/FuelLabs/tree-sitter-sway.git) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sway) |
| swift | [parser](https://github.com/alex-pinkus/tree-sitter-swift) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-swift) |
| sxhkdrc | [parser](https://github.com/RaafatTurki/tree-sitter-sxhkdrc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-sxhkdrc) |
| systemtap | [parser](https://github.com/ok-ryoko/tree-sitter-systemtap) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-systemtap) |
| systemverilog | [parser](https://github.com/gmlarumbe/tree-sitter-systemverilog) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-systemverilog) |
| t32 | [parser](https://github.com/xasc/tree-sitter-t32) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-t32) |
| tablegen | [parser](https://github.com/tree-sitter-grammars/tree-sitter-tablegen) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tablegen) |
| tact | [parser](https://github.com/tact-lang/tree-sitter-tact) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tact) |
| tcl | [parser](https://github.com/tree-sitter-grammars/tree-sitter-tcl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tcl) |
| teal | [parser](https://github.com/euclidianAce/tree-sitter-teal) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-teal) |
| templ | [parser](https://github.com/vrischmann/tree-sitter-templ) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-templ) |
| tera | [parser](https://github.com/uncenter/tree-sitter-tera) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tera) |
| terraform | [parser](https://github.com/MichaHoffmann/tree-sitter-hcl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-terraform) |
| textproto | [parser](https://github.com/PorterAtGoogle/tree-sitter-textproto) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-textproto) |
| thrift | [parser](https://github.com/tree-sitter-grammars/tree-sitter-thrift) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-thrift) |
| tiger | [parser](https://github.com/ambroisie/tree-sitter-tiger) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tiger) |
| tlaplus | [parser](https://github.com/tlaplus-community/tree-sitter-tlaplus) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tlaplus) |
| tmux | [parser](https://github.com/Freed-Wu/tree-sitter-tmux) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tmux) |
| todotxt | [parser](https://github.com/arnarg/tree-sitter-todotxt) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-todotxt) |
| toml | [parser](https://github.com/tree-sitter-grammars/tree-sitter-toml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-toml) |
| tsv | [parser](https://github.com/tree-sitter-grammars/tree-sitter-csv) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tsv) |
| tsx | [parser](https://github.com/tree-sitter/tree-sitter-typescript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-tsx) |
| turtle | [parser](https://github.com/GordianDziwis/tree-sitter-turtle) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-turtle) |
| twig | [parser](https://github.com/gbprod/tree-sitter-twig) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-twig) |
| typescript | [parser](https://github.com/tree-sitter/tree-sitter-typescript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-typescript) |
| typespec | [parser](https://github.com/happenslol/tree-sitter-typespec) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-typespec) |
| typoscript | [parser](https://github.com/Teddytrombone/tree-sitter-typoscript) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-typoscript) |
| typst | [parser](https://github.com/uben0/tree-sitter-typst) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-typst) |
| udev | [parser](https://github.com/tree-sitter-grammars/tree-sitter-udev) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-udev) |
| ungrammar | [parser](https://github.com/tree-sitter-grammars/tree-sitter-ungrammar) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ungrammar) |
| unison | [parser](https://github.com/kylegoetz/tree-sitter-unison) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-unison) |
| usd | [parser](https://github.com/ColinKennedy/tree-sitter-usd) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-usd) |
| uxntal | [parser](https://github.com/tree-sitter-grammars/tree-sitter-uxntal) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-uxntal) |
| v | [parser](https://github.com/vlang/v-analyzer) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-v) |
| vala | [parser](https://github.com/vala-lang/tree-sitter-vala) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vala) |
| vento | [parser](https://github.com/ventojs/tree-sitter-vento) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vento) |
| vhdl | [parser](https://github.com/jpt13653903/tree-sitter-vhdl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vhdl) |
| vhs | [parser](https://github.com/charmbracelet/tree-sitter-vhs) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vhs) |
| vim | [parser](https://github.com/tree-sitter-grammars/tree-sitter-vim) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vim) |
| vimdoc | [parser](https://github.com/neovim/tree-sitter-vimdoc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vimdoc) |
| vrl | [parser](https://github.com/belltoy/tree-sitter-vrl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vrl) |
| vue | [parser](https://github.com/tree-sitter-grammars/tree-sitter-vue) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-vue) |
| wgsl | [parser](https://github.com/szebniok/tree-sitter-wgsl) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-wgsl) |
| wgsl_bevy | [parser](https://github.com/tree-sitter-grammars/tree-sitter-wgsl-bevy) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-wgsl_bevy) |
| wing | [parser](https://github.com/winglang/tree-sitter-wing) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-wing) |
| wit | [parser](https://github.com/bytecodealliance/tree-sitter-wit) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-wit) |
| wxml | [parser](https://github.com/BlockLune/tree-sitter-wxml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-wxml) |
| xcompose | [parser](https://github.com/tree-sitter-grammars/tree-sitter-xcompose) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-xcompose) |
| xml | [parser](https://github.com/tree-sitter-grammars/tree-sitter-xml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-xml) |
| xresources | [parser](https://github.com/ValdezFOmar/tree-sitter-xresources) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-xresources) |
| yaml | [parser](https://github.com/tree-sitter-grammars/tree-sitter-yaml) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-yaml) |
| yang | [parser](https://github.com/Hubro/tree-sitter-yang) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-yang) |
| yuck | [parser](https://github.com/tree-sitter-grammars/tree-sitter-yuck) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-yuck) |
| zathurarc | [parser](https://github.com/Freed-Wu/tree-sitter-zathurarc) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-zathurarc) |
| zig | [parser](https://github.com/tree-sitter-grammars/tree-sitter-zig) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-zig) |
| ziggy | [parser](https://github.com/kristoff-it/ziggy) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ziggy) |
| ziggy_schema | [parser](https://github.com/kristoff-it/ziggy) | [queries](https://github.com/neovim-treesitter/nvim-treesitter-queries-ziggy_schema) |
| zsh | [zsh](https://github.com/georgeharker/tree-sitter-zsh) | self-contained |

</details>

[registry.json]: https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/registry.json
<!-- END LANGUAGE LIST -->

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
