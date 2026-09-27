Implement the changes below.
Before making changes, read the existing repository documentation so that new material matches its existing tone, terminology, formatting, and technical depth.
Verify version-sensitive or current ecosystem information against current authoritative sources before adding it.
Prefer official project/vendor documentation. Do not invent product capabilities or classifications.
When a change has been implemented, remove it from the list.
---

# 7. Expand `README.md` into the course landing page

Rewrite the current minimal README so that it clearly explains the purpose and structure of the repository.

Include:

## Course purpose

Explain that this repository supplements a short AI-industry/application-stack course for HPC/research-computing system administrators.

Clarify that the focus is **not** on teaching ML research or deep model mathematics.

The focus is understanding the modern AI application and infrastructure stack.

## Audience

Describe the intended reader as someone who is tech savvy & familiar with topics such as:

- Linux
- HPC/research computing
- clusters
- networking
- storage
- schedulers
- GPUs/accelerators

but who may only have prior experience using AI through chat interfaces.

## Learning objectives

After reading the core material, the reader should be able to:

- distinguish an AI model from an AI application;
- identify the major layers of an AI system;
- explain the difference between training and inference;
- understand the basic resource implications of model weights, quantization, KV cache, context, and concurrency;
- distinguish an inference engine from a serving/orchestration platform;
- explain RAG at an architectural level;
- explain tool use and the basic agent loop;
- understand the role of MCP;
- understand the basic architecture of a self-hosted AI inference service;
- understand major operational and security concerns;
- recognize where common AI products fit in the stack.

## Suggested reading order

Add a clear ordered list linking the core documents.

A reasonable sequence after this work would likely be:

1. `AI_Stack.md`
2. `Terminology.md`
3. `Model_Properties.md`
4. `HPC_Inference_Architecture.md`
5. `Guardrails.md`
6. `Products_and_Services.md`
7. Model-comparison appendix/reference material

Adjust this if the final document structure suggests a better order.

Explain that `Terminology.md` can also be used as a reference rather than necessarily read straight through.

## Repository scope

Explain that some material is intentionally more detailed than the live presentation because the repository is intended to remain useful as follow-up/reference documentation.

---

# Cross-document consistency

After implementing the changes, review the documentation as a whole.

Make sure terms are used consistently, especially:

- model
- checkpoint
- weights
- model artifacts
- tokenizer
- inference engine
- inference server
- inference service
- gateway
- router
- harness
- agent
- tool
- MCP server
- RAG
- model registry
- orchestration platform

Avoid creating conflicting definitions between documents.

Where a term has a dedicated entry in `Terminology.md`, link to it where useful.

Where a detailed explanation already exists in another document, summarize it briefly and link rather than duplicating several paragraphs.

---

# Depth guidance

Optimize for an experienced infrastructure audience.

The documentation should answer questions like:

- "What actually gets loaded onto the GPUs?"
- "Where did those files come from?"
- "What is vLLM responsible for?"
- "What is KServe responsible for?"
- "Where does Slurm fit?"
- "Where does Hugging Face fit?"
- "What actually happens when RAG retrieves a document?"
- "Why does context length consume GPU memory?"
- "Why can a model fit into HBM but still run out of memory under load?"
- "Why does model startup take so long?"
- "What changes when the workload is interactive rather than batch?"
- "What does an agent add beyond a chat interface?"
- "Which layers do we have to operate if we self-host?"

Do not go deeply into topics such as:

- transformer mathematics
- backpropagation mathematics
- detailed CUDA kernel implementation
- attention equations
- detailed ANN algorithm internals
- detailed fine-tuning procedures

Mention such concepts only when required to explain an operational concern.

---

# Validation

Before finishing:

1. Review all changed Markdown for logical flow.
2. Check internal Markdown links and anchors where practical.
3. Check Mermaid syntax where diagrams were modified or added.
4. Make sure headings are consistently nested.
5. Make sure newly introduced technical terms are either defined or linked.
6. Check that the new material does not contradict existing definitions.
7. Verify current product/project claims against authoritative documentation.
8. Remove dead or obviously obsolete links encountered in the sections being modified.
9. Do not modify unrelated files merely for stylistic cleanup.
10. Do not modify `Replicating_My_Setup.md`.

At the end, provide a concise summary of:

- files created;
- files modified;
- major architectural concepts added;
- any current-industry claims that required verification;
- any areas you deliberately left unchanged because they were outside this task.
