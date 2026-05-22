# Agentic OCR in 2026

An opinionated practitioner's field guide to agentic OCR — what it is, where it came from, who should use it, how it works under the hood, what it costs, how to evaluate it, and where it falls short.

Published as both an HTML book site (via GitHub Pages) and a downloadable PDF, built from a single Quarto source.

## Reading the book

- **📖 Live HTML book:** **<https://asadani.github.io/agentic-ocr/>**
- **📄 PDF download:** **<https://asadani.github.io/agentic-ocr/agentic-ocr-2026.pdf>** (~3 MB)

The HTML book has a "Download PDF" link in the top-right corner of every page.

## Structure

Five parts, 15 chapters:

| Part | Focus |
|---|---|
| I — Foundations | What it is, history, definition |
| II — Architecture | Patterns, self-correction, the shift-left thesis |
| III — The 2026 Landscape | Commercial players, open-source players, vendor selection |
| IV — Evaluation & Integration | Benchmarks, evaluating your own pipeline, RAG impact |
| V — Reality Check | Anti-patterns, limitations, where 2027 goes |

See `_quarto.yml` for the full chapter list.

## Building locally

Requires [Quarto](https://quarto.org/docs/get-started/) (any 1.4+ release).

```bash
quarto render          # builds HTML book + PDF into _book/
quarto preview         # live-reload server while writing
```

## Deploying

Deploys are currently **manual** (local-render + push to `gh-pages`). The GitHub
Actions workflow is in the repo but disabled (`workflow_dispatch` only) — the
Quarto render step hangs on Mermaid SVG generation in CI for reasons that have
resisted debugging, while it completes in ~60 seconds locally.

```bash
./scripts/deploy.sh
```

That script:
1. Patches the cached Typst `orange-book` template to neutralize its forced
   odd-page chapter breaks (which otherwise insert blank verso pages).
2. Runs `quarto render`.
3. Pushes the rendered `_book/` to the `gh-pages` branch.

The patch is idempotent and re-applied on every run, so it survives any cache
refreshes Quarto does.

## Project layout

```
.
├── _quarto.yml          # Quarto project config
├── index.qmd            # Preface / landing page
├── chapters/            # 15 chapter sources (.qmd)
├── appendices/          # Glossary, bibliography, cheatsheet
├── data/                # CSV tables for player matrices, benchmarks, pricing
├── research/            # Raw research notes (input material, not part of book)
├── styles.scss          # Theme customizations
├── references.bib       # BibTeX citations
└── .github/workflows/   # GitHub Actions for auto-deploy to Pages
```

## Contributing / authorship notes

- Source docs from research lived in `research/01-*.md` through `research/03-*.md` originally; `04-web-research-2026.md` adds fresh 2026 data.
- Voice is **opinionated practitioner** — named takes, no fence-sitting.
- Diagrams use **Mermaid**, authored inline in `.qmd` files.

## License

[MIT](LICENSE) © 2026 Anuj Sadani.

You are free to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the book content, subject to the conditions in the [LICENSE](LICENSE) file.
