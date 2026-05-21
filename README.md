# Agentic OCR in 2026

An opinionated practitioner's field guide to agentic OCR — what it is, where it came from, who should use it, how it works under the hood, what it costs, how to evaluate it, and where it falls short.

Published as both an HTML book site (via GitHub Pages) and a downloadable PDF, built from a single Quarto source.

## Reading the book

- **Online:** [github-pages-url-here] *(set after first deploy)*
- **PDF:** Available as a download link from the site, or in the latest release.

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

TBD.
