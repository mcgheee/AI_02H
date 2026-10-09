# AI Agents

An agentic workflow uses a model and a surrounding application to work through a task in multiple steps. The thing that makes workflows agentic is that they perform actions within a loop in pursuit of a goal. The model can propose actions, but the harness manages context, executes permitted tools, and decides when the workflow should stop or ask for help.

## Agentic Loop

The agentic loop is the repeated exchange between a model and its harness: the harness supplies the task and relevant context, the model responds or requests a tool, and the harness executes any permitted call and returns its result. The model then uses that new information to choose the next step. A coding agent, for example, might inspect a file, edit it, run a test, and revise its change based on the result.

The loop ends when the task is complete, a limit is reached, or a person needs to make a decision. Tool-call, time, and cost limits prevent unproductive loops; approval gates keep high-impact actions under human control. See [Guardrails](Guardrails.md) for the controls around those actions.

> **Note:**
>
> Any workflow or harness that employs a loop is agentic. This document mostly focuses on autonomous AI assistants and coding agents. 

## Agentic Harnesses

An agentic [harness](Terminology.md#harness) is the application that runs this loop around the model. It builds each model request from instructions, conversation history, tool results, and retrieved information; it also maintains state, manages permissions, and presents progress to the user. The inference server runs the model, while the harness turns model output into tool calls or a final response. See [AI Stack](AI_Stack.md#harnesses) for where the harness fits in the wider system.

Different harnesses expose different tools and workflows, so using the same model in two applications does not guarantee the same behavior. A coding harness may offer file and shell access, while a research harness may offer search and document retrieval.

## Capabilities

Skills and tools play different roles in an agent's capabilities. A skill provides instructions for *how* to approach a task, while a tool provides a way to *do* something, such as read a file or run a command. An agent might follow a code-review skill and use file and search tools to carry it out; the skill does not itself provide access to those tools.

### Skills

A skill is a reusable set of plain-language instructions that a harness or agent can load when relevant. Skills guide how the agent uses its available capabilities. They do not grant new permissions or new capabilities by themselves. A skill that says to run a command still depends on the harness exposing a command tool and allowing that action. The harness determines how skills are discovered and loaded.

A common skill file is named `SKILL.md`. It starts with metadata such as a **name** and **description** so the harness can identify when the skill is relevant. The rest of the file gives the agent steps to follow and may specify how to check its work or format the result. Some skill formats can also include supporting templates or scripts.

Example Skill File for performing code review:

```markdown
---
name: code-review
description: Review code changes for correctness and security issues.
---

# Code Review

Read the changed files and identify potential bugs or security issues.
Run relevant tests if a test tool is available. Report findings with file references.
```

> **Note: Skills vs Prompts**
>
> Skills differ from prompts in several ways. Skills are reusable sets of instructions meant to reliably automate repeatable workflows, while prompts are simple instructions supplied in the model's context for a specific task or objective. Prompts may be injected into context at different layers - as a system prompt, developer prompt, or submitted as a user prompt; whereas skills are usually stored in dedicated version-controlled files, and are loaded by the agent when it determines they are needed.


### Tools

[Tools](Terminology.md#tools) give an agent ways to inspect information or act outside the model, such as reading files, searching the web, querying a database, or running tests. The model selects a tool and supplies arguments, but the harness executes the call and returns its result as context. Tools may be built into the application or provided by external services through interfaces such as [MCP](AI_Stack.md#model-context-protocol-mcp).

A tool's reach depends on its credentials, filesystem scope, and the harness's permissions. Tool output should be treated as data, not as trusted instructions: a retrieved page or repository file can contain text that tries to redirect the agent. Limiting access and requiring approval for sensitive operations matter more than simply telling the model to be careful.

### Subagents

A subagent is a separate agent run that a parent agent spawns and delegates a specific task. Depending on the harness, it may have its own context and tools, work in parallel with other subagents, and return findings or changes for the parent to integrate. For example, a coding agent might ask one subagent to inspect tests while another investigates an independent part of the codebase.

Delegation works best when each task has a clear scope and enough context to stand on its own. The parent remains responsible for coordinating results, checking work, and resolving conflicts if subagents edit shared files. Subagents do not inherently gain extra permissions: what they can access or change depends on the harness. Separate runs can speed up independent work, but they also consume resources and can miss context the parent did not pass along.

### Memory

An agent can use conversation history and tool results as short-term working context, but the [context window](Terminology.md#context-window) is finite and ephemeral. A harness may compact older turns into summaries, retrieve relevant material again, or store task state separately. Compaction, by its nature, reduces context. It can cause details to be lost, so important facts should be checked against their source or stored in a more durable memory system.

Longer-term memory may live in files, a database, or a retrieval system and be brought into later sessions when needed. It can help carry preferences or project knowledge forward, but saved information can become stale or sensitive. Solutions have been developed to control what is stored, who can retrieve it, and when it should be updated or deleted.

For a small workflow, durable memory could be as simple as structured flat files. Common examples include Markdown files for noting user preferences, a task log, or a project summary that the harness reads when needed. Larger data sets may use a more robust solution like a vector store or database. These conventions differ by the selected tools and communities and are not universal features of language models. Their effect depends on whether a harness discovers and loads them, and their contents do not override its permissions or higher-priority instructions.

> **Note: Vector vs Relational Databases**
>
> Relational databases store structured records identified by keys, and retrieve them by querying the database for exact values or relationships. A vector store instead indexes [embeddings](Terminology.md#embeddings), so a query can find items that are similar in meaning even when they use different words. Unlike exact-value queries (for example, in SQL), vector search ranks approximate matches by similarity. The agent still needs the underlying source text to check what a match actually says. These approaches can be combined, and some relational databases also support vector search.

## Common Conventions

The following is a list of different files and conventions commonly implemented by agentic harnesses.

### .agents/ Directory

Some harnesses use a `.agents/` directory to organize agent-related files, such as skills, instructions, or configuration.

### AGENTS.md

`AGENTS.md` is a repository instruction file that can describe project structure, coding standards, and test commands for agents working in that tree. Unlike `.agents/`, it is one file of guidance rather than a directory for organizing resources.

> **Note:** .agents/ Directory vs AGENTS.md File
>
> Both are conventions whose support depends on the harness. Each solution will vary in which files it reads, how nested instructions apply, and where it looks for skills. Naming a directory or file alone does not ensure it will be loaded.


### SOUL.md

`SOUL.md` is used by some agents to describe a persistent persona, communication style, or guiding principles. It can make an assistant's behavior more consistent across sessions when the harness loads it, but it is not a standard protocol or a security policy. Authorization and tool access must still be enforced outside that file.

### llms.txt

[`llms.txt`](https://llmstxt.org/) is a proposed convention for publishing an LLM-friendly guide to a website, often with links to key documentation. A site may place it at `/llms.txt` so tools that support the convention can discover relevant pages. It helps with navigation, not automatic access or authority: clients may ignore it, and agents should treat its contents as external source material rather than instructions that supersede the user's task.

## Agent Orchestration
Agent orchestration coordinates work across multiple agents or agent runs, rather than managing the internal behavior of their harnesses. An orchestrator can assign tasks, pass relevant context, manage dependencies and retries, track progress, and route results for review or further work. It may launch or trigger runs through one or more harnesses, but each harness still runs its agent's loop, tools, and permissions. Orchestration determines how the agents' contributions fit together, whether through a short-lived workflow or a persistent queue of work. Unlike spawning a subagent for a bounded task that returns to its parent, orchestration can coordinate independent agents and work that continues across multiple runs without a single parent agent.

## AI Factories
An AI factory is a repeatable system for turning a stream of goals or requests into outputs with AI agents. For example, a software factory might take feature requests through planning, implementation, testing, and human review. It combines defined roles, task intake, shared context, quality checks, and operational controls such as approvals and cost limits so the process can be run repeatedly rather than assembled anew for each request. Orchestration is the coordination layer that moves work through that process; the factory is the broader production workflow, including its inputs, standards, and oversight. The term describes an approach, not a particular product or a guarantee of autonomy.

> **Note: Multiplexers**
>
> A terminal multiplexer lets a person view and interact with several agent processes in one workspace. It manages terminals and visibility, not task assignment, dependencies, or handoffs between agents. An orchestrator coordinates those tasks and their outcomes; it may use terminals to run agents, but displaying agents side by side does not itself orchestrate their work.
