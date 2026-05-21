# Web Research Notes — Agentic OCR, May 2026

Raw research collected during Phase A of the book project. These are notes for authoring, not finished prose. Citations included inline for later import into `references.bib`.

---

## 1. ParseBench (LlamaIndex + Kaggle)

- Built on **~2,000 human-verified pages** and **167,000+ test rules**.
- Targets high-stakes enterprise use cases: insurance claims, financial filings, healthcare records.
- Evaluation axes: tables, charts, content fidelity, formatting, **visual grounding**.
- Live leaderboard at **parsebench.ai** (also on Kaggle).
- **Top result as of mid-2026:** *LlamaParse Agentic* — **84.9% overall**, at roughly **$0.012/page**. Outperforms all other providers at any cost level on this benchmark.
- 14 methods evaluated: VLMs, specialized parsers, and LlamaParse tiers.
- *Caveat:* benchmark is published by LlamaIndex; selection of "rules" inevitably shapes the leaderboard. Treat as one signal, not the signal.

Sources:
- LlamaIndex blog: *LlamaIndex and Kaggle launch a new Document OCR leaderboard for AI agents*
- LlamaIndex blog: *ParseBench: The First Document Parsing Benchmark for AI Agents*
- Kaggle: ParseBench Leaderboard
- HuggingFace: `llamaindex/ParseBench`
- arXiv 2604.08538

---

## 2. IBM Granite-Docling (2026 release)

- **Granite-Docling-258M** released **January 2026** under **Apache-2.0**.
- Production successor to the experimental SmolDocling-256M-preview (HF + IBM Research, March 2025).
- Single 258M parameter VLM that parses + processes documents in one shot.
- All output flows through the **DoclingDocument** unified representation → exports to Markdown, JSON, HTML, or DocTags.
- Backbone: Granite 3 (replaced SmolLM-2); visual encoder: SigLIP2 (replaced SigLIP).
- Trained on 81,000 manually labeled pages — patents, manuals, 10-K filings. Reportedly within 5 percentage points of human accuracy on page element identification.
- Heron layout model (Dec 2025) improves PDF parsing speed.
- Supported input formats: PDF, DOCX, PPTX, XLSX, HTML, WAV, MP3, WebVTT, images (PNG/TIFF/JPEG), LaTeX, plain text.
- The Docling library (the framework) is MIT-licensed and provides customizable ensemble pipelines; Granite-Docling is the model that anchors it.

Sources:
- IBM announcement: *Granite-Docling: End-to-end document understanding*
- GitHub: `docling-project/docling`, `pgadet-wq/granite-docling-258M`
- HuggingFace: `ibm-granite`
- arXiv 2501.17887

---

## 3. Mistral Document AI / Mistral OCR 3

- **Mistral OCR 3** launched January 2026. Model id `mistral-ocr-2512`.
- **Pricing: $2 per 1,000 pages**; Batch API: **$1 per 1,000 pages**. (One of the cheapest agentic-grade parsers on the market.)
- **74% win rate** over Mistral OCR 2 in internal evals — especially strong on forms, handwriting, table-heavy docs.
- Throughput: **up to 2,000 pages/minute per node**.
- Output: Markdown with HTML tables (preserves `rowspan`/`colspan`).
- Designed for downstream agentic/RAG pipelines (structured JSON support).
- Self-hosted deployment available — relevant for HIPAA / regulated industries.
- Drag-and-drop UI ("Document AI Playground") for non-technical users.

Sources:
- InfoQ: *Mistral Releases OCR 3 with Improved Accuracy*
- Mistral AI: *Introducing Mistral OCR 3*
- Mistral pricing page

---

## 4. LlamaParse pricing (current as of mid-2026)

Four tiers, credit-based:

| Tier | Credits / page | Effective $/page |
|---|---|---|
| Fast | 1 | $0.00125 |
| Cost Effective | 3 | $0.00375 |
| Agentic | 10 | $0.0125 |
| Agentic Plus | 45 | $0.05625 |

- Conversion: **1,000 credits = $1.25**.
- **10,000 free credits/month** for new users.
- Agentic tier handles: scanned pages, multi-column layouts, complex tables, embedded charts.
- Agentic Plus optimized for dense financial reports and scientific papers with specialized chart parsing.
- "Extract" workflow costs separately layer on top (6–60 credits/page depending on tier combos).
- Version pinning supported for production consistency.

Sources:
- LlamaIndex pricing page
- LlamaParse developer docs: pricing / tiers

---

## 5. Landing AI — Agentic Document Extraction (ADE)

- Major update in 2025/2026: **credit-based monthly subscriptions** + **one-click Zero Data Retention (ZDR)** + **RBAC**.
- New features: **agentic table captioning**, improved figure captioning, smarter layout detection, expanded ontology covering **attestations, ID cards, logos, barcodes, QR codes**.
- Explore plan: **1,000 free credits** on signup.
- Credit formula: `credits = ceil((input_chars / 5000) + (output_chars / 1000), 0.1)`.
- Plans: **$39/mo for 120,000 credits** → up to **$2,199/mo for 900,000 pages**.
- 10% extra credits on Team plan, 30% extra on Visionary plan.
- **HIPAA compliant** on Team and Enterprise plans.
- ZDR on Team and Enterprise plans.

Sources:
- LandingAI docs: *Pricing & Billing*
- LandingAI: *Agentic APIs Pricing*
- G2: *Landing AI Software Pricing 2026*
- Marketplace listing on Microsoft

---

## 6. Reducto

- **Hybrid architecture:** layout-first CV + contextual VLM interpretation + multi-pass "Agentic OCR" feedback loops.
- On their own **RD-TableBench** (1,000 adversarial tables, PhD-annotated): **~0.90 similarity score**.
- Outperforms AWS, Google, and Azure document APIs **by up to ~20 percentage points** on this benchmark.
- RD-TableBench is open-source; available on Hugging Face for interactive browsing.
- Key technical move: refuses to be "single-pass VLM" — explicitly markets multi-pass review/correction as the differentiator.

Sources:
- GitHub: `reductoai/rd-tablebench`
- Reducto blog: *Announcing RD-TableBench*
- Reducto: *Hybrid Architecture: Technical Deep Dive Into Agentic OCR and Multi-Pass Document Parsing*
- HuggingFace Space: `reducto/rd_table_bench`

---

## 7. Benchmarks landscape (updated)

### OmniDocBench
- 1,651 PDF pages; 10 document types, 5 layout types, 5 language types (CVPR 2025).
- **v1.7 released April 30, 2026** — added 296-page **hard subset** for difficult formulas/tables/layouts; corrected annotations from v1.5; added Qianfan-OCR leaderboard; supports **skills-based evaluation**.
- **Now considered saturated** by LlamaIndex et al. — top scores cluster too tightly; the discriminating signal is moving elsewhere.
- LlamaIndex published a public take: *"OmniDocBench is saturated — what's next for OCR benchmarks?"*

### OCRBench v2
- 10,000+ QA pairs, bilingual EN/ZH.
- Considered less relevant when the production contract is **structured extraction** (vs. visual text reasoning).

### olmOCR-Bench
- AllenAI; **7,000+ test cases across 1,400 documents**.
- **v0.4.0 release in October 2025** improved olmOCR's bench score by ~4 points using synthetic data + RL training.
- Unit-test-style; designed for reproducibility.
- LlamaIndex published a critical review: *"olmOCR-Bench Review: Insights and Pitfalls"*.

### DABstep (Adyen + Hugging Face)
- 450+ real-world data-analysis tasks pulled from Adyen's operational workloads.
- Mixes structured (CSV/JSON) and unstructured (text, manuals) data.
- **Top reasoning agent (o4-mini) achieves only ~14.55% accuracy on Hard tasks; ~16% overall best-in-class.**
- This is the benchmark to cite when arguing that "extraction" ≠ "reasoning." A model can parse the documents perfectly and still fail the analytical task.
- Real-time leaderboard on HuggingFace Spaces.

### SCORE-Bench (Unstructured.io) — new in 2026
- 1,000+ page enterprise dataset: scanned invoices, nested tables, handwritten notes, schematics, patents, marketing materials, etc.
- SCORE = **Structural and Content Robust Evaluation** — interpretation-agnostic eval framework.
- Specifically designed for **generative** parsing systems: separates "different but valid representation" from "actual extraction error."
- Compares against Reducto, LlamaParse, Docling, Snowflake, Databricks, NVIDIA.

Sources:
- HuggingFace: `opendatalab/OmniDocBench`, `adyen/DABstep`, `unstructuredio/SCORE-Bench`
- GitHub: `opendatalab/OmniDocBench`
- LlamaIndex blog posts on OmniDocBench saturation and olmOCR-Bench review
- arXiv 2506.23719 (DABstep)
- Unstructured.io blog: *Introducing SCORE-Bench*

---

## 8. Market structure (2026)

- **Only one new agentic AI startup entered the market through April 2026.** Down from 245 founded in 2023 — peak year.
- Average funding round size for agentic AI startups: **$155M in Q4 2025/early 2026** — nearly double the $82M average from H1 2025.
- Three pressures squeezing new entrants:
  1. Foundation model providers became direct competitors (Operator, Claude for Work, Gemini agents).
  2. Enterprises consolidating to 1–2 vendors per workflow category.
  3. Capital concentration into established players.
- **67% of enterprise document processing initiatives now explicitly evaluating agentic approaches** — up from 23% two years ago.
- The OCR market has split into two camps: AI-native VLM/agentic platforms vs. legacy high-accuracy text recognition.

Sources:
- AgentMarketCap: *The Agentic Funding Shift: $6.42B in 2025*
- AI Agent Conference: *The Agentic List 2026*
- AgenticAI Institute: enterprise adoption survey
- Artificio: *The 2026 State of Document AI*

---

## 9. Healthcare prior-auth — case-study material

- CMS rule: **starting March 31, 2026**, health plans must publicly report prior-authorization average turnaround times, plus denial / appeal / overturn rates. This is a structural forcing function for agentic OCR adoption in healthcare.
- Agentic systems in prior-auth: ingest clinical notes, lab reports, PDFs via clinical OCR; align with evidence-based protocols; apply payer-specific criteria.
- **Anterior AI** published a fairness-evaluation paper (arXiv 2603.14631) documenting their automated prior-auth system. Error rates consistent across most demographics within tolerance, though some race/ethnicity subgroups had limited sample sizes and wide CIs.
- The existing source docs cite Anterior AI + Reducto achieving 99.24% accuracy on their workflow.

Sources:
- IDC blog: *The U.S. Healthcare Prior Authorization Crisis: Will Agentic AI Come to the Rescue?*
- Deloitte: *AI Could Help Health Plans Simplify Prior Auth, Comply With Regs*
- arXiv 2603.14631

---

## 10. Hallucination, failure modes, criticism (2026)

- Numbers to cite carefully: traditional OCR has reported **15–20% failure rate**; agentic approaches **under 2%** on equivalent tasks. (Vendor-reported; not independently audited.)
- Documented systemic issues from H1 2026 retrospectives:
  - Early agentic systems lacked **graceful degradation** — no rollback, no consistent HITL safeguard.
  - **Observability gap:** logs captured outputs but not decisions. Drift accumulated invisibly until failure forced investigation.
  - Multi-step agentic chains **multiply** the impact of a single error.
- "Tiny silent hallucinations" (OpenReview paper) — hidden failure modes specifically in autonomous agentic systems.
- Compute cost remains real: agentic loops multiply VLM calls per document → meaningful inference cost and latency penalties.
- "Plausible but Wrong" (arXiv 2604.25345) — case study of agentic failures in astrophysical workflows; relevant analogy for document-extraction failures that are convincing but wrong.

Sources:
- DigitalApplied: *AI Incidents H1 2026 Retrospective: Failure Modes Analysis*
- OpenReview: *Tiny Silent Hallucinations in Agentic AI*
- Medium (Y. Mishra): *AI Hallucinations Are Getting Smarter — Real-Time Detection*
- arXiv 2604.25345 (Plausible but Wrong)
- arXiv 2602.21053 (OCR-Agent reference paper)

---

## 11. Databricks Document Intelligence (June 2026 launch context)

The Databricks blog *"Why frontier agents can't read documents — and how we're fixing it"* is the sharpest mainstream articulation in 2026 of the "extraction is the ceiling, not reasoning" thesis. Key data to use:

- **Headline claim:** frontier agents score **below 50%** on document-reasoning tasks (their OfficeQA benchmark).
- **Headline result:** dropping `ai_parse_document` in front of any agent framework produces a **16% average performance gain** across agents — without changing the reasoning layer at all. That's the "reading, not reasoning" thesis in one number.
- **Named failure modes (verbatim):** scanned PDFs with inconsistent layouts, nested tables, handwritten notes, format variation across vendors.
- **Hallucination example they cite:** *"a '$10,000' gets hallucinated as '$3,000.'"* Use this — it lands.
- **Product shape:** three chainable SQL/AI functions — `ai_parse_document` (GA), `ai_classify`, `ai_extract`. Integrated into Lakeflow + Unity Catalog + Agent Bricks.
- **Cost claim:** 5–7× cheaper than comparable VLM-only pipelines; one named customer (Loopback Analytics, clinical notes) reports ~90% lower cost for equivalent entity extraction.
- **Benchmark introduced:** OfficeQA, "based on real-world enterprise document workflows." Full details in arXiv 2603.08655.

This is excellent counter-positioning material for the shift-left thesis chapter — it's a hyperscaler-adjacent data platform (not an OCR pure-play) saying out loud that **document reading is the gating constraint** on agent quality. That hardens the book's central argument.

Sources:
- Databricks blog: *Why Frontier Agents Can't Read Documents — and How We're Fixing It*
- arXiv 2603.08655 (OfficeQA paper)

---

## 12. The open-source OCR landscape — Hugging Face survey

The Hugging Face blog *"Supercharge your OCR Pipelines with Open Models"* (**October 21, 2025**) is the most useful single survey of the open ecosystem. Its comparison table is the foundation for our open-source vendor chapter.

### Comparison table from the article

| Model | Provider | Params | License | Outputs | olmOCR-Bench |
|---|---|---|---|---|---|
| **Chandra** | DataLab-to | 9B | OpenRAIL | Markdown, HTML, JSON | **83.1 ± 0.9** |
| **OlmOCR-2** | AllenAI | 8B | Open | Markdown, HTML, LaTeX | **82.3 ± 1.1** |
| **dots.ocr** | Rednote-hilab | 3B | Open | Markdown, JSON | 79.1 ± 1.0 |
| **DeepSeek-OCR** | DeepSeek | 3B | Open | Markdown, HTML | 75.4 ± 1.0 |
| **Nanonets-OCR2-3B** | Nanonets | 4B | (unclear) | Markdown + HTML tables | — |
| **PaddleOCR-VL** | PaddlePaddle | 0.9B | Open | Markdown, JSON, HTML | — |
| **Granite-Docling-258M** | IBM | 258M | Apache-2.0 | DocTags | — |
| **Qwen3-VL** | Alibaba/Qwen | 9B | Open | All formats (general VLM) | — |

Also mentioned (not in the table):
- **MinerU 2.5-2509-1.2B** (OpenDataLab)
- **LightOnOCR-1B** (LightOn AI) — claims **493k pages/day on a single H100**

### Useful framings from the article

- **Output format determines fit:** DocTags / HTML for layout preservation; Markdown for LLM consumption; JSON for analytics. Markdown can't represent split-column tables — a sharp anti-pattern smell to call out.
- **No single best model** — performance is heavily document-type, language, and domain-dependent. The article explicitly recommends testing 2–3 models on your own data rather than trusting public leaderboards.
- **Cost anchor:** OlmOCR-2 at ~**$178 per million pages** on an H100 at $2.69/hr. This is the cleanest open-source cost number to anchor against the closed-source per-page rates in section 4 above.
- Limitations of OlmOCR-Bench: English-only, unit-test style, annotations from closed-source VLMs.
- Three benchmarks the article uses: **OlmOCR-Bench** (EN only), **OmniDocBench** (diverse types, accepts HTML + Markdown), **CC-OCR** (multilingual but lower quality).

Sources:
- Hugging Face blog: *Supercharge your OCR Pipelines with Open Models* (Oct 21, 2025)
- Model cards on HuggingFace for each

---

## 13. Additional open-source / hybrid players

### PaddleOCR / PP-StructureV3 (PaddlePaddle, Baidu)
- **OmniDocBench edit distance: 0.145 EN / 0.206 ZH** at **<100M parameters**.
- Matches **Gemini-2.5-Pro** accuracy at a fraction of the compute cost. This is the strongest "small model wins at OCR" data point in the 2026 set.
- Supports **100+ languages**. The PP- lineage (PP-OCRv3 → v4 → v5) is mature.
- PaddleOCR-VL is the VLM-enriched variant covered in the HF survey.

### MonkeyOCR (OpenDataLab)
- **MonkeyOCR v1.5** (Nov 2025): SOTA on **OmniDocBench v1.5**.
- Beats PP-OCR-VL by **0.15%** and MinerU 2.5 by **2.34%** on OmniDocBench v1.5.
- On the **OCRFlux-complex** dataset (complex-layout focused): beats PP-OCR-VL by **8.2%**.
- Sources: arXiv 2511.10390 (MonkeyOCR v1.5 technical report).

### MinerU (OpenDataLab) — version refresh
- MinerU 2.5 / MinerU2.5-2509-1.2B available on HF. Strong on scientific PDFs.
- AGPL-3.0 license — relevant for commercial deployment decisions.

### dots.ocr (Rednote-hilab)
- 3B parameters, grounding + image extraction + handwriting.
- olmOCR-Bench: **79.1 ± 1.0** — currently 3rd on that leaderboard.

### Chandra (DataLab-to)
- **Top of the olmOCR-Bench leaderboard at 83.1**.
- 9B params, OpenRAIL license, 40+ languages.
- New entrant worth highlighting as the leading open-source quality leader for English-heavy work.

### Qwen3-VL (Alibaba)
- 9B general-purpose VLM, 32 languages.
- Strengths: ancient text recognition, handwriting, image extraction. Weaker on character-perfect transcription.
- Good fit for documents where **understanding meaning** matters more than perfect character fidelity (charts, screenshots, diagrams).

### DeepSeek-OCR
- 3B, ~100 languages, supports chart and table re-rendering to HTML.
- Reported throughput: **~200k+ pages/day on a single A100**.
- olmOCR-Bench: 75.4.

---

## 14. NuExtract series (NuMind)

A focused player worth its own subsection — they specialize in **structured extraction**, not OCR per se. Important distinction.

- **NuExtract 1.5**: multilingual, handles arbitrarily long docs. Beats GPT-4o on English **while being ~500× smaller**.
- **NuExtract 2.0** (May 2025): adds **vision** + abstraction + in-context learning. Open-source variants in **2B–8B params**.
- **NuExtract 2.0 PRO** (API-only): outperforms GPT-4.1 by **+9 F-score** on extraction.
- **NuExtract3** (2026): latest series release — the user's reference.

**Where to position them in the book:** these are best framed as an **extraction layer** that sits *after* parsing, not as agentic OCR systems themselves. Useful comparison/foil for vendors that bundle parsing + extraction (LlamaParse, ADE) — NuExtract shows extraction can be a separable, smaller model.

Sources:
- HuggingFace: `numind/NuExtract`, `numind/NuExtract-1.5`, `numind/NuExtract-2.0-8B`, `numind/NuExtract3`
- NuMind blog: *NuExtract 2.0*, *NuExtract Platform*, *Outclassing Frontier LLMs*

---

## 15. Nanonets (commercial agentic IDP)

- **Pricing model:** workflow blocks. Simple blocks cheap; complex AI blocks ~**$0.30** each → **under $2/invoice** end-to-end.
- **Free credits:** every account starts with $200. Volume discounts up to **40%**.
- **Coverage:** **100+ languages**, mixed-script docs.
- Claims **34% of Fortune 500** as customers (vendor claim, treat accordingly).
- The **agentic layer** reviews and corrects outputs in real-time on edge cases — explicitly markets self-correction.
- Often grouped alongside Rossum and Docsumo as the "API-first, easy-onboarding, invoice-friendly" tier of commercial IDP.

Sources: Nanonets pricing page, Capterra, G2, Parseur comparison.

---

## 16. Docsumo (commercial IDP)

- **150+ document types** out of the box, claims **95%+ accuracy**.
- Plans: Free (14-day, 1,000 pages) → Business (adds classification, validation, customization) → Enterprise (full workflow automation, case management, analytics).
- Often paired in IDP roundups with Nanonets and Rossum.
- Particularly active in marketing the "agentic document processing" framing — published a public definition blog (*What is Agentic Document Processing*) which aligns with the book's working definition.
- Useful market-size citation from Docsumo's content: IDP market growing at **33.68% CAGR** from **~$3.09B (2025) → $43.92B (2034)**. (Source: Docsumo blog citing analyst data — flag as analyst-projection, not measured.)

Sources: Docsumo pricing, *What is Agentic Document Processing*, F6S listing.

---

## 17. Updated open-source benchmark snapshot (consolidated)

Three benchmarks form the live olmOCR-Bench / OmniDocBench frontier as of mid-2026:

| Benchmark | Top open-source model | Score |
|---|---|---|
| olmOCR-Bench | Chandra (9B, OpenRAIL) | 83.1 ± 0.9 |
| olmOCR-Bench | OlmOCR-2 (8B) | 82.3 ± 1.1 |
| OmniDocBench v1.5 | MonkeyOCR v1.5 | SOTA (beats prior best by 0.15–2.34%) |
| OmniDocBench (EN) | PP-StructureV3 (<100M) | edit distance 0.145 |
| ParseBench | LlamaParse Agentic (closed) | 84.9% |
| RD-TableBench (tables) | Reducto (closed) | ~0.90 similarity |

**Editorial take to land in the book:** the open-source leaderboard has caught up with proprietary systems on raw parsing quality. The remaining gap is in **agentic orchestration, HITL workflows, and grounding/auditability for compliance** — which is exactly where the commercial vendors are doubling down. The open-source side has the models; the commercial side has the surrounding platform.

---

## 18. Gaps still open after this research pass

Things the book should address but where the public 2026 record is thin:

- **Independent (non-vendor) pricing benchmarks.** Every leaderboard so far is published by a vendor.
- **Per-vertical ROI numbers** beyond healthcare prior-auth. Legal and finance have qualitative pieces but few numbers.
- **TCO including engineering effort**, not just per-page cost. Most pricing comparisons stop at API spend.
- **Empirical failure-mode taxonomy** drawn from production deployments, not labs.
- **Long-form benchmarks** — most public benchmarks are page-level. The DABstep result suggests this is where the real gap is.

These are worth flagging in the book as honest open problems rather than papering over with vendor claims.
