Implement the changes below.
Before making changes, read the existing repository documentation so that new material matches its existing tone, terminology, formatting, and technical depth.
Verify version-sensitive or current ecosystem information against current authoritative sources before adding it.
Prefer official project/vendor documentation. Do not invent product capabilities or classifications.
When a change has been implemented, remove it from the list.
---

# 5. Expand the main AI stack diagram

Update the primary architecture in `AI_Stack.md` so it better represents an operational AI system.

The diagram should continue to emphasize the existing request path:

```text
Client
→ Harness
→ optional Gateway / Router
→ Inference Server
→ Model
→ Compute Hardware
```

Preserve the existing relationships with:

- tools / MCP
- RAG / data / memory
- peer agents / A2A

Add or represent the following supporting layers:

- model registry / model storage
- orchestration / scheduler
- accelerator software/runtime
- observability

The diagram should not falsely imply that all supporting components are traversed for every inference request.

A useful conceptual layering is:

```text
APPLICATION PLANE

User / Client
      ↓
Harness / Agent
  ↙          ↘
Tools        RAG / Data
      ↓
Gateway / Router
      ↓

SERVING PLANE

Inference Service / Server
      ↓
Inference Engine
      ↓
Model artifacts + runtime state
      ↓

COMPUTE PLANE

Accelerator runtime
      ↓
GPU / CPU / accelerator
      ↓
interconnect
```

with supporting systems such as:

```text
Model registry / storage
Scheduler / orchestration
Observability
Security / identity
```

placed alongside the request path rather than incorrectly inside it.

Do not overcomplicate the diagram. It needs to remain readable enough for presentation use.

---

# 6. Reorganize `Products_and_Services.md` around architectural layers

Refactor `Products_and_Services.md`.

The current document is too heavily organized around vendors and individual products. Reorganize it so that someone reading the architecture documents can use this file to answer:

> "Which products implement this layer?"

Prefer sections similar to:

```text
# AI Ecosystem Map

## Model Developers / Labs

## Model Registries and Distribution

## Hosted Model / Inference APIs

## AI Gateways and Routers

## Inference Engines / Servers

## Packaged / Local Inference Platforms

## Serving and Orchestration Platforms

## AI Applications and Harnesses

## Coding Agents / Coding Harnesses

## RAG, Search, and Data Components

## Agent / Application Frameworks

## Memory Systems

## Observability and Evaluation

## Image / Video Generation
```

Adjust the exact headings if the existing content suggests a cleaner taxonomy.

Important requirements:

- Start each major category with a short description of what that category does.
- Preserve useful existing links where they are still current.
- Remove obvious duplication where the same inference-engine explanation already exists in `AI_Stack.md`.
- Use this document primarily as an ecosystem/reference catalog rather than another architecture tutorial.
- Ensure products are categorized according to their primary role.
- Products that legitimately span categories may be mentioned in multiple places sparingly, but avoid excessive duplication.
- Correct obvious misclassifications.
- Preserve the `Frontier Labs` section in its entirety, but include the listed products in the appropriate categories.

Specifically:

- Do not categorize Unsloth simply as a desktop/all-in-one inference application; describe its actual model training/fine-tuning/optimization role appropriately.
- Spell `ComfyUI` correctly and classify it appropriately.
- Add Hugging Face Hub under model registry/distribution.
- Consider representative self-hosted/production technologies that are materially useful to this audience, such as NVIDIA NIM, LiteLLM, or similar projects, but only after verifying their current role using official documentation.
- Preserve the distinction between:
  - model provider,
  - inference provider,
  - inference engine,
  - application/harness,
  - gateway,
  - orchestration platform.

Do not attempt to create an exhaustive directory of every AI product.

Favor representative products that help illustrate each architectural category.

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
