# AGENTS.md

This repository contains technical documentation for a short AI application-stack course aimed primarily at HPC and research-computing system administrators.

## Writing Style

Keep new and modified content consistent with the existing documentation:

- Write for technically experienced infrastructure administrators, not ML researchers.
- Use clear, precise, vendor-neutral language.
- Explain concepts from a systems and architecture perspective.
- Prefer short paragraphs, diagrams, examples, and concrete operational implications.
- Define what a component does, where it fits, and how it interacts with adjacent layers.
- Avoid unnecessary mathematical detail, marketing language, hype, and unsupported claims.
- Introduce terminology before relying on it heavily.
- Use familiar infrastructure concepts where they help explain AI concepts.
- Prefer Markdown and Mermaid consistent with existing files.
- Cross-link existing definitions rather than duplicating lengthy explanations.
- Distinguish concepts from specific products that implement them.
- Maintain the same style and prose throughout.
- Avoid joining clauses or separating ideas with semicolons and em dashes.

The documentation should generally go somewhat deeper than the associated presentation while remaining approachable enough to serve as reference material after the course.

## Technical Accuracy

- Verify current, version-sensitive, or rapidly changing information before adding it.
- Prefer authoritative sources such as official project, vendor, standards, or upstream documentation.
- Clearly distinguish established technical behavior from implementation-specific behavior.
- Do not present estimates, rankings, benchmarks, or subjective comparisons as objective facts.
- Avoid implying that a particular implementation is required when multiple valid architectures exist.
- Preserve consistent terminology across the repository.

## Product and Ecosystem References

When mentioning products:

1. Explain the architectural category first.
2. Prefer to use the general term for a product rather than specific product names. Outside of Producs_and_Services.md, try to only use actual products as representative implementations.
3. Avoid turning documentation into promotional copy or an exhaustive product catalog.
4. Prefer stable architectural concepts over transient product features.
5. Remove unnecessary tracking parameters from links.

## Originality and Attribution

All prose added to this repository must be original.

- Do not copy or closely paraphrase documentation, articles, model cards, blog posts, or other external sources.
- Read sources for technical understanding, then explain the concept independently in language appropriate for this project's audience.
- Do not reproduce source-specific wording, examples, diagrams, tables, or organizational structure unless explicitly permitted and properly attributed.
- Use brief quotations only when the exact wording is necessary, and clearly attribute them.
- Link to authoritative sources when they materially support a technical claim or provide useful further reading.
- When adapting an external concept or architecture, redraw and explain it independently rather than copying the original presentation.
- Avoid using material that must be attributed or cited.

A good rule is: **use sources to verify facts, not to supply prose.**

## Scope and Editing

- Preserve the existing intent and technical level of each document.
- Avoid unrelated rewrites while implementing a focused task.
- Do not duplicate substantial material across files; summarize and cross-link instead.
- Keep diagrams readable enough to be useful in presentation or reference contexts.
- Before finishing, check headings, internal links, terminology, and surrounding text for consistency.
