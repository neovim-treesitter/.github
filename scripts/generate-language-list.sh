#!/usr/bin/env bash
# generate-language-list.sh
#
# Reads registry.json and generates a markdown language table for the
# org profile README.  Output is injected between marker comments:
#
#   <!-- BEGIN LANGUAGE LIST -->
#   ... generated content ...
#   <!-- END LANGUAGE LIST -->
#
# Usage:
#   ./generate-language-list.sh <registry.json> <README.md>

set -euo pipefail

REGISTRY="${1:?Usage: $0 <registry.json> <README.md>}"
README="${2:?Usage: $0 <registry.json> <README.md>}"

if [ ! -f "$REGISTRY" ]; then
  echo "ERROR: registry file not found: $REGISTRY" >&2
  exit 1
fi
if [ ! -f "$README" ]; then
  echo "ERROR: README file not found: $README" >&2
  exit 1
fi

# Generate the language table as markdown
TABLE=$(jq -r '
  to_entries
  | map(select(.value | type == "object"))
  | sort_by(.key)
  | .[] |
  {
    lang: .key,
    type: .value.source.type,
    url: (
      if .value.source.type == "self_contained" then .value.source.url
      elif .value.source.type == "external_queries" then .value.source.parser_url
      elif .value.source.type == "queries_only" then .value.source.url
      else ""
      end
    ),
    queries_url: (
      if .value.source.type == "external_queries" then .value.source.queries_url
      elif .value.source.type == "self_contained" then .value.source.url
      elif .value.source.type == "queries_only" then .value.source.url
      else ""
      end
    )
  } |
  if .type == "self_contained" then
    "| \(.lang) | [\(.lang)](\(.url)) | self-contained |"
  elif .type == "queries_only" then
    "| \(.lang) | — | [queries](\(.queries_url)) |"
  else
    "| \(.lang) | [parser](\(.url)) | [queries](\(.queries_url)) |"
  end
' "$REGISTRY")

TOTAL=$(jq '[to_entries[] | select(.value | type == "object")] | length' "$REGISTRY")
SC=$(jq '[to_entries[] | select(.value | type == "object") | select(.value.source.type == "self_contained")] | length' "$REGISTRY")
EQ=$(jq '[to_entries[] | select(.value | type == "object") | select(.value.source.type == "external_queries")] | length' "$REGISTRY")
QO=$(jq '[to_entries[] | select(.value | type == "object") | select(.value.source.type == "queries_only")] | length' "$REGISTRY")

GENERATED=$(cat <<EOF
> **${TOTAL} languages** — ${SC} self-contained, ${EQ} external queries, ${QO} queries-only
>
> *This table is auto-generated from [registry.json]. Do not edit manually.*

<details>
<summary>Supported languages</summary>

| Language | Parser | Queries |
|----------|--------|---------|
${TABLE}

</details>

[registry.json]: https://github.com/neovim-treesitter/treesitter-parser-registry/blob/main/registry.json
EOF
)

# Inject between markers
BEGIN_MARKER="<!-- BEGIN LANGUAGE LIST -->"
END_MARKER="<!-- END LANGUAGE LIST -->"

if ! grep -q "$BEGIN_MARKER" "$README"; then
  echo "ERROR: marker not found in README: $BEGIN_MARKER" >&2
  exit 1
fi

# Write generated content to a temp file, then splice it in
TMPGEN=$(mktemp)
echo "$GENERATED" > "$TMPGEN"

# Use sed to delete old content between markers, then read in the new
# 1) Delete lines between markers (exclusive)
# 2) Read generated content after the BEGIN marker
awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" -v file="$TMPGEN" '
  $0 == begin { print; while ((getline line < file) > 0) print line; skip=1; next }
  $0 == end   { skip=0 }
  !skip       { print }
' "$README" > "${README}.tmp"

rm -f "$TMPGEN"
mv "${README}.tmp" "$README"
echo "Updated $README with $TOTAL languages"
