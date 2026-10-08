---
marp: true
theme: stellar-bloom
paginate: true
---


<!-- _class: lead -->
# AI Application Stack Overview

## A TLDR Intro to AI CyberInfrastructure

### By: Erick McGhee

<https://github.com/mcgheee/AI_02H>


---


# Terms

- Harness - The application that allows users or other software to interact with AI models. 
- Agent - A special type of harness that operates on a loop.
- Context - What is stored in the model's working memory.
- Memory - Durable long term storage of data
- Prompt - A single instruction or question to the model.
- Turn - A single response in a conversation from either the client or the model.
- Inference - The process of generating a response from the model.


---


# Model Types

- LLMs
  - Ex: GPT 6, Claude 5, Grok 4
- Diffusion
  - Ex: Stable Diffusion, DALL-E, LTX
- Classification
  - Ex: Jev, Laya

---


# AI Stack Simplified

```mermaid
flowchart LR
  subgraph harness["Harness"]
    direction TD
    agent["Agent"]
    web["Web Chat"]
  end
  tools@{ shape: st-rect, label: Tools}
  subgraph inference["Inference Server"]
    model["Model"]
  end
  agent <-. A2A .-> web
  harness <-. MCP .-> tools
  harness -. MIP .-> model
  model -. MIP .-> harness
```


---


# Application Workflow

```mermaid
flowchart LR
  Client
  subgraph Harness["Harness"]
    direction TB
    h_man["Manage Conversations & Context"]
    h_sp["System Prompt"]
    h_tls["Tool Calls & Results"]
    h_lp["Agent Loop"]
  end
  subgraph Gateway
    direction TB
    g_a["Authentication / Authorization"]
    g_r["Route / Load Balance"]
    g_l["Rate Limit & Quotas"]
  end
  subgraph Server["Inference Server"]
    direction TB
    s_l["Load Model"]
    s_s["Schedule Requests"]
    s_m["Manage Resources"]
  end
  subgraph Model["Model"]
    direction TB
    m_p["Process tokens"]
    m_r["Reasoning"]
    m_g["Generate Response"]
  end
  Client -. Request .-> Harness
  Harness -. API .-> Gateway
  Gateway -. API .-> Server
  Server --> Model
```


---


# Harness

- Basically any app used to interact with AI
  - Web Chat
  - CLI
  - Agentic


---


# Inference Server

- Loads and serves the model
- Schedules requests and manages batching
- Manages CPU/GPU/accelerator resources


---


# Agents

- A type of Harness
- Operates on a loop until conditions are met
- May provide or connect to tools

> **Examples:** Openclaw, Hermes, OpenCode, Codex, Claude Code


---


# Tools

- May be provided by the harness
  - Ex: Read, Write, Execute
-  Or, connected to an external service via MCP
  - Ex: Web scraping, Memory, Computer Use



---


# Skills

- Provide instructions, **not** capabilities
- Written in natural language
- Usually structured in Markdown


---


# Context

- Model's working memory
- Limited in Size
- Lossy due to compaction


---


# Guardrails

- Constrains what a model can accept, produce, or do
- Soft constraints that guide the model's behavior
  - System / Developer Instructions, Training, Prompt
- Hard constraints that prevent action
  - Sandboxing, Permission Gating, Human Approval

```text
User
  │
  ▼
Input Guardrails
  │
  ▼
System / Developer Instructions
  │
  ▼
LLM
  │
  ├──► Tool / Action Guardrails ──► APIs, shell, email, files, etc.
  │
  ▼
Output Guardrails
  │
  ▼
User
```


---
