---
name: rebuild-model-comparison
description: Research and recreate model_comparison.csv as a unified catalog of individual AI models relevant in 2025–2026, with model specifications, comparable benchmark scores, estimated capability, and recommended uses. Use when rebuilding or refreshing this model comparison dataset, not for editing its HTML viewer.
---

# Rebuild the model comparison CSV

Create a downloadable UTF-8 file named `model_comparison.csv`. Research the dataset from scratch rather than treating a previous assistant response as verified evidence. Keep all labs in one table, with one row per individual model or materially distinct variant.

Default scope is models relevant during 2025–2026, including earlier releases still relevant in that period. There is no minimum release-date cutoff. Use the actual research date as the evidence cutoff; do not assume future releases exist. If the user specifies a historical snapshot, distinguish information available then from later evidence.

This skill defines a reproducible research and formatting process, not a frozen list of facts or scores. Without an existing row inventory, an independently researched rebuild may differ from a previous export. Do not claim byte-for-byte reproduction or complete preservation of an unavailable source.

## Exact output schema

Use these 12 column names in precisely this order and spelling. The existing HTML viewer validates these headers.

```csv
"Model Name","Lab name","Release date","Number of parameters","maximum context size","model card/official link","reasoning capability score","coding capability score","agentic capability score","overall capability score","estimated capability score (1-100)","recommended use"
```

| Column | Content rules |
| --- | --- |
| Model Name | Canonical individual model/checkpoint/SKU name. Preserve distinctions such as size, Base/Instruct, Thinking, Pro, Mini, Nano, Flash, and coding specialists. |
| Lab name | Developing lab, not the inference reseller or hosting platform. Use one consistent name per lab. |
| Release date | First release of that specific variant. Prefer `YYYY-MM-DD`; use `YYYY-MM` or `YYYY` if that is all the evidence supports. Do not invent precision. |
| Number of parameters | Total and active parameters when available, e.g. `235B / 22B active`. Distinguish effective, stored, and backbone counts if needed. Use `Undisclosed` only when supported; otherwise `—`. |
| maximum context size | Documented input/context window, e.g. `128K`, `1M`, or `256K; 1M extended`. Distinguish native and extended limits. Do not confuse output-token limits or reasoning budgets with context. |
| model card/official link | Plain absolute HTTPS URL to the exact official model card or documentation, preferably the developer's Hugging Face repository. Use a general official catalog only if no model-specific page exists. |
| reasoning capability score | Comparable normalized category score on a 0–100 scale, or `—`. |
| coding capability score | Comparable normalized category score on the same scale and source, or `—`. |
| agentic capability score | Comparable normalized category score on the same scale and source, or `—`. |
| overall capability score | Published aggregate from that benchmark source, or `—`. Do not derive it by averaging the three category scores. |
| estimated capability score (1-100) | An explicitly subjective integer from 1 to 100 based on researched evidence; keep distinct from published scores. Use `—` if evidence is too weak to support an estimate. |
| recommended use | Concise practical workloads and deployment fit, such as local coding, enterprise retrieval, multimodal analysis, or research agents. Avoid unsupported superlatives. |

Use `—` consistently for unavailable values; it is not zero. Preserve meaningful approximation markers on reported measurements. Put availability qualifications in recommended use when needed, without adding columns. Do not place footnote symbols in numeric estimates.

## Model coverage

Cover at least these developing labs and their relevant model lines. The examples identify discovery targets, not assertions that every generation or named variant exists.

- OpenAI: general GPT models, small variants, reasoning models, Codex specialists, and open-weight offerings.
- Anthropic: Claude Sonnet, Opus, Haiku, and other independently verified variants.
- Google DeepMind: both Gemini and Gemma, including each verified size and specialist variant.
- Alibaba: Qwen2.5 and later relevant generations, individual Instruct sizes, Coder, Coder-Next, VL, Omni, Thinking, and distinct API SKUs.
- DeepSeek: V3 and R1-era models as well as subsequent verified checkpoints, reasoning and coding variants, and relevant distilled models.
- Z.ai: GLM models and their verified Air, Flash, reasoning, and other distinct variants.
- xAI: Grok general, Mini, Fast, reasoning, and coding variants.
- Meta: relevant Llama releases and other verified model lines.
- Moonshot AI: Kimi base, instruction, reasoning, coding, and efficient variants.
- Mistral AI: Large, Medium, Small, Ministral sizes, Codestral, Devstral, Magistral, and other relevant verified models.
- MiniMax, Tencent, Xiaomi, and Cohere: individual relevant models and variants, including enterprise and multimodal models.

Explicitly check older relevant models such as GPT-4o, GPT-4.1, o3, o4-mini, Claude 3.7 Sonnet, Claude Sonnet 4, Gemini 2.5, Gemma 3, Qwen2.5, DeepSeek V3/R1, Llama 3.3/4, Grok 3, and 2025 Mistral releases. Verify each candidate rather than relying on the example alone.

Count materially distinct checkpoints and sizes separately. Do not collapse a family into one flagship row. Do not multiply rows for quantizations, packaging formats, provider aliases for the same checkpoint, request-time reasoning-effort settings, or regional endpoints. Preserve meaningful punctuation: `Command A` and `Command A+` must remain distinct. Reconcile name variants only when identity is supported by evidence.

Default to general-purpose, reasoning, coding, agentic, and multimodal language models. Exclude pure embeddings, rerankers, image/video generation, TTS, and ASR unless requested. If preserving a supplied dataset, retain its existing out-of-scope rows and explain the exception rather than silently removing them. Announced but unavailable models may be retained when requested; clearly label that status and do not present them as downloadable production checkpoints.

## Research workflow

1. Establish the requested period and evidence cutoff. If a prior CSV or comparison is supplied, extract its complete model inventory first. A truncated conversation preview is not a complete source.
2. Build a coverage ledger by lab, generation, size, specialization, and release/checkpoint. Consult official catalogs, model cards, release announcements, technical reports, and developer-owned repositories. Expand beyond flagships. Track candidate aliases and availability.
3. Verify specifications from primary sources. Resolve differences between announcement dates, preview availability, general availability, and later checkpoint updates. When context depends on the serving endpoint, use the official configuration for the listed SKU and qualify it if necessary.
4. Retrieve comparable benchmark scores for the exact variant. Record the benchmark source, retrieval date, version, evaluation settings, and coverage limitations in working notes. Avoid mixing similarly named models or reasoning settings.
5. Assign the separate estimated capability score using the rubric below. Maintain a short evidence-based rationale and uncertainty for each estimate in working notes.
6. Reconcile the inventory against every lab's relevant catalog and any user-provided baseline. Report unresolved entries and missing evidence. Do not manufacture records to achieve a fixed row count.
7. Write and validate the CSV. Deliver the file with a concise explanation of scope, score provenance, missing values, and any unresolved entries.

For this project's previous export, 232 rows were retained, including three earlier-only entries: Voxtral Mini 3B, Voxtral Small 24B, and Mistral Medium 3.1. This is historical context, not a verified completeness target. When refreshing that export, account for every original row, but independently verify its claims. If a baseline entry cannot be verified, retain its name when preservation is requested, mark unsupported facts/scores `—`, and flag it for review. Do not silently repeat unsupported historical values.

## Published capability scores

The original comparison labeled its category and aggregate scores as BenchLM. Verify whether that source actually provides accessible, documented, comparable data for the exact variants. Do not reproduce those numbers solely because an earlier assistant supplied them.

Use one documented normalized benchmark source/version across the four published-score columns. If BenchLM is unavailable or unsuitable, explain the limitation. Do not silently replace its metric with a different index. If a replacement is authorized, identify it clearly and apply it consistently.

An individual benchmark percentage is not automatically a category-level capability score. Do not relabel SWE-bench accuracy as general coding capability or combine heterogeneous percentages into an invented normalized aggregate. Keep unsupported category fields `—`, even when strong model-specific benchmark results exist. Use those results as evidence for the separate subjective estimate instead.

Distinguish vendor-reported results from independent tests. Note harness, tool access, inference budget, context length, and benchmark-version differences before comparing. Missing benchmark coverage alone is not evidence of poor capability.

## Estimated capability rubric

Estimate general practical capability across reasoning, coding, instruction following, tool use, agent reliability, and relevant multimodal tasks. Consider specialization in the recommended-use field. Do not score price, popularity, parameter count, or context length as intelligence directly.

| Score | Interpretation relative to the declared comparison snapshot |
| --- | --- |
| 95–100 | Strongest broadly evidenced frontier capability |
| 85–94 | Frontier-class |
| 75–84 | Very strong, competitive with recent frontier systems |
| 60–74 | Strong production capability |
| 45–59 | Capable midrange, local, or specialist model |
| 30–44 | Small/efficient model with substantial limitations |
| 1–29 | Primarily edge, narrow, or limited legacy use |

Choose evidence-rich anchor models across tiers first, then place other models by observed comparisons. Use one anchor set and evidence cutoff throughout the dataset. Prefer independent evaluations; triangulate with technical reports and official positioning when necessary. Do not mechanically convert another leaderboard's overall score to this scale. Treat estimates as approximate, typically ±3–5 points and wider where evidence is sparse. Explain that later refreshes may change the anchors and are not necessarily longitudinal measurements on a fixed scale.

## CSV creation and checks

- Write with a real CSV serializer, such as Python's standard `csv` module. Use UTF-8, comma delimiters, CRLF record separators, and quote all fields. Escape embedded quotes by doubling them. Preserve commas and newlines within quoted fields correctly.
- Emit exactly one header and 12 fields per model row. Do not insert lab section headings, notes, markdown formatting, or totals into the CSV.
- Keep full source URLs in the CSV; favicon presentation belongs to the separate HTML viewer. Do not edit the viewer while rebuilding the dataset unless requested.
- Use deterministic ordering, preferably lab name then model name, unless the user specifies an order or preservation of an existing order.
- Read the saved CSV back with an independent parser and compare every field with the prepared records. Check distinct model identities, missing-value handling, and parameter/context units.
- Validate published numeric scores are within 0–100 when present and estimates are integers within 1–100. Any source approximation must remain identifiable and parseable. Never coerce `—` into zero.
- Validate non-missing links are absolute HTTP(S) URLs; check the model-specific destinations during research rather than guessing URL slugs.
- Compare the final model inventory with the coverage ledger and any supplied baseline. Report additions, unresolved names, and explicitly authorized removals. Confirm older-but-relevant models and individual size variants remain represented.

Return a downloadable `model_comparison.csv`. Do not generate Markdown tables, HTML, extra workbooks, install the skill, or publish data elsewhere unless requested. Keep research notes as working evidence; summarize the score source and research date in the delivery message so the CSV's meaning is clear without changing its schema.
