#!/usr/bin/env bash
#
# Local-render + gh-pages deploy for the Agentic OCR book.
#
# Usage: ./scripts/deploy.sh
#
# What it does:
#   1. Patches the orange-book Typst template in the Quarto cache to
#      neutralize its `pagebreak(to: "odd")` calls, which otherwise
#      insert blank verso pages between chapters and parts. Idempotent.
#   2. Runs `quarto render` to build _book/ (HTML + PDF).
#   3. Clones the gh-pages branch into a temp dir, replaces its contents
#      with the fresh _book/ output, commits, and pushes.
#
# Requires: quarto, git, gh (authenticated). The repo's origin must be
# the GitHub repository serving via Pages.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

ORIGIN_URL="$(git config --get remote.origin.url)"
if [[ -z "$ORIGIN_URL" ]]; then
  echo "error: no origin remote configured" >&2
  exit 1
fi

echo "==> 1. Patching orange-book template (idempotent)"
TEMPLATE="$REPO_ROOT/.quarto/typst/packages/preview/orange-book/0.7.1/lib.typ"
if [[ -f "$TEMPLATE" ]]; then
  # Replace forced odd-page breaks with weak breaks (no blank verso).
  sed -i 's/pagebreak(to: "odd")/pagebreak(weak: true)/g' "$TEMPLATE"
  echo "    patched: $TEMPLATE"
else
  echo "    note: template not yet cached; will be patched after first render"
fi

echo "==> 2. Rendering book (HTML + PDF)"
quarto render

# Re-patch and re-render once if the template was just downloaded by the
# first render — its initial state would still have the forced breaks.
if [[ ! -f "$TEMPLATE" ]]; then
  echo "    note: template was missing; re-patching and re-rendering"
  exit 1
fi
if grep -q 'pagebreak(to: "odd")' "$TEMPLATE"; then
  echo "==> 2b. Template was re-downloaded with forced breaks; re-patching and re-rendering"
  sed -i 's/pagebreak(to: "odd")/pagebreak(weak: true)/g' "$TEMPLATE"
  quarto render
fi

echo "==> 3. Deploying _book/ to gh-pages branch"
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 --branch gh-pages "$ORIGIN_URL" "$TMPDIR/pages" 2>/dev/null || {
  echo "    gh-pages branch not found; creating from orphan"
  git clone "$ORIGIN_URL" "$TMPDIR/pages"
  (cd "$TMPDIR/pages" && git checkout --orphan gh-pages && git rm -rf . >/dev/null 2>&1 || true)
}

(
  cd "$TMPDIR/pages"
  git config user.email "$(git -C "$REPO_ROOT" config --get user.email)"
  git config user.name  "$(git -C "$REPO_ROOT" config --get user.name)"

  # Wipe everything except .git, then copy the fresh build in.
  find . -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +
  cp -r "$REPO_ROOT/_book/." .
  touch .nojekyll

  git add -A
  if git diff --cached --quiet; then
    echo "    no changes to deploy"
  else
    git commit -m "Deploy book ($(date -u +%Y-%m-%dT%H:%M:%SZ) from $(git -C "$REPO_ROOT" rev-parse --short HEAD))"
    git push origin gh-pages
    echo "    deployed"
  fi
)

echo "==> Done. Live at $(echo "$ORIGIN_URL" | sed -E 's#.*[:/]([^/]+)/([^/.]+)(\.git)?$#https://\1.github.io/\2/#')"
