# AI Ecosystem Map

This catalog maps representative products and services to the architectural role they primarily implement. It is not an exhaustive directory. A product can span layers, but the distinctions between a model developer, inference provider, inference engine, gateway, orchestration platform, and application remain useful when designing or operating a system. See [AI Stack](AI_Stack.md) for the architecture behind these categories.

## Frontier Labs
Main AI applications and developer services from the four labs below; individual model versions and subscription tiers are not listed separately. Reviewed September 27, 2026.

#### ![OpenAI logo](https://www.google.com/s2/favicons?domain=openai.com&sz=32) OpenAI
- [ChatGPT](https://chatgpt.com/) (web)
- [ChatGPT](https://chatgpt.com/download/) (desktop and mobile)
- [ChatGPT Work](https://chatgpt.com/work/) — delegated work across apps and tools.
- [Codex](https://openai.com/codex/) — coding agent in ChatGPT, the CLI, and IDE extensions.
- [Codex Cloud](https://openai.com/codex/cloud) - cloud coding agent connected directly to GitHub
- [OpenAI API Platform](https://openai.com/api/) — model APIs and developer playground.

Note: the standalone Codex app has been consolidated into ChatGPT. [ChatGPT Atlas](https://openai.com/index/introducing-chatgpt-atlas/) is deprecated, and [Sora](https://openai.com/sora/) has been discontinued.

#### ![Anthropic logo](https://www.google.com/s2/favicons?domain=anthropic.com&sz=32) Anthropic
- [Claude](https://claude.ai/) (web)
- [Claude](https://claude.com/download) (desktop and mobile)
- [Claude Code](https://claude.com/product/claude-code) — coding agent for the CLI, IDEs, desktop, and web.
- [Claude / Cowork](https://claude.com/product/overview) — task automation; Cowork is being integrated into the main Claude experience.
- [Claude in Chrome](https://claude.com/claude-in-chrome) (browser extension)
- [Claude for Microsoft 365](https://claude.com/claude-for-microsoft-365) — integrations for Excel, PowerPoint, Word, and Outlook; Outlook is in beta.
- [Claude in Slack / Claude Tag](https://claude.com/product/overview) — task-taking Slack integration (beta).
- [Claude Platform](https://claude.com/platform/api) — API and developer console.
- [Claude Science](https://claude.com/product/claude-science) — scientific-research application (public beta).
- [Claude Security](https://claude.com/product/claude-security) — vulnerability scanning and remediation (public beta).

#### ![xAI logo](https://www.google.com/s2/favicons?domain=x.ai&sz=32) xAI / SpaceXAI
- [Grok](https://grok.com/) (web, iOS, Android, and X)
- [Grok Build](https://x.ai/build) — coding agent.
- [Grok Bot](https://x.ai/bot) — AI teammates and workflow automation.
- [Grok Imagine](https://grok.com/imagine) — image and video generation.
- [Grok Voice Agent Builder](https://x.ai/voice) — voice-agent creation and deployment (beta).
- [Grokipedia](https://grokipedia.com/) — AI-generated encyclopedia.
- [SpaceXAI API](https://x.ai/api) — text, code, image, video, and voice APIs, with a console and playground.

#### ![Google logo](https://www.google.com/s2/favicons?domain=google.com&sz=32) Google
- [Gemini](https://gemini.google.com/) (web and mobile; includes Gemini Spark)
- [Google Antigravity](https://antigravity.google/) — agent-first development environment.
- [Google Antigravity CLI](https://antigravity.google/product/antigravity-cli) — terminal-based coding and agent workflows.
- [Gemini CLI](https://geminicli.com/) — terminal coding agent; replaced by Antigravity CLI for unpaid-tier and Google One users.
- [Gemini Code Assist](https://codeassist.google/) — coding assistance in supported IDEs.
- [Jules](https://jules.google/) — coding agent for GitHub repositories.
- [Gemini Notebook (NotebookLM)](https://notebook.google/) — source-grounded research assistant; the former NotebookLM website redirects here.
- [Google AI Studio](https://aistudio.google.com/) — browser-based model playground and app prototyping.
- [Gemini API](https://ai.google.dev/gemini-api/docs) — developer access to Gemini models.
- [Gemini Enterprise](https://cloud.google.com/gemini-enterprise) — enterprise AI assistant and agents.
- [Gemini Enterprise Agent Platform](https://cloud.google.com/products/gemini-enterprise-agent-platform) — agent development and deployment platform incorporating Vertex AI capabilities.
- [Gemini for Google Workspace](https://workspace.google.com/solutions/ai/) — AI assistance in Gmail, Docs, Sheets, and other Workspace apps.
- [Google Flow](https://labs.google/flow/about) — AI-powered creative and video tools.
- [Stitch](https://stitch.withgoogle.com/) — AI-assisted interface design.

## Other Labs

Model developers create model architectures, train model weights, and publish models or expose them through services. The organization that develops a model is not necessarily the organization that runs inference for a particular application.

- [Meta AI](https://ai.meta.com/llama/): develops the Llama model family and distributes model artifacts under its applicable licenses.
- [Mistral AI](https://mistral.ai/models): develops open-weight and hosted models.
- [Cohere](https://cohere.com/models): develops language and embedding models for enterprise applications.
- [AI21 Labs](https://www.ai21.com/jamba/): develops the Jamba model family and provides hosted model services.
- [Allen Institute for AI (Ai2)](https://allenai.org/olmo): develops and publishes the OLMo family of open language models and training artifacts.
- [DeepSeek](https://api-docs.deepseek.com/): develops language and reasoning models and provides hosted model APIs.
- [Alibaba Cloud (Qwen)](https://qwenlm.github.io/): develops and publishes the Qwen model family.
- [Moonshot AI](https://www.moonshot.ai/): develops the Kimi model family.
- [MiniMax](https://www.minimax.io/): develops the MiniMax model family for language and multimodal applications.
- [Z.ai](https://docs.z.ai/): develops the GLM model family and provides hosted model APIs.
- [Tencent Hunyuan](https://github.com/Tencent-Hunyuan): develops and publishes the Hunyuan model family.
- [Xiaomi MiMo](https://github.com/XiaomiMiMo): develops and publishes the MiMo model family.
- [Stability AI](https://stability.ai/): develops generative models for images, video, audio, and other media.

## Model Registries and Distribution

Registries and hubs store, version, document, and distribute [model artifacts](Terminology.md#model-artifact). They are the source from which an operator downloads a model, not the runtime that executes it.

- [Hugging Face Hub](https://huggingface.co/docs/hub/models-the-hub): hosts model repositories containing artifacts, configuration, model cards, and version history.
- [NVIDIA NGC Catalog](https://catalog.ngc.nvidia.com/): distributes models, containers, and related GPU software artifacts.
- [Ollama model library](https://ollama.com/library): distributes models packaged for Ollama's local model-management workflow.

## Hosted Model and Inference APIs

Inference providers operate compute and expose model inference through network APIs. Some providers serve models they developed, while others host models from multiple developers.

- [OpenAI API Platform](https://openai.com/api/): hosted API access to OpenAI models.
- [Claude Platform](https://claude.com/platform/api): hosted API access to Anthropic models.
- [SpaceXAI API](https://x.ai/api): hosted API access to xAI / SpaceXAI models.
- [Gemini API](https://ai.google.dev/gemini-api/docs): hosted API access to Google Gemini models.
- [Hugging Face Inference Providers](https://huggingface.co/docs/inference-providers/index): access to models served by multiple infrastructure providers through a common client interface.
- [Together AI](https://www.together.ai/inference): hosted inference for open models.

## AI Gateways and Routers

Gateways sit between applications and inference endpoints. Depending on the product and configuration, they can provide authentication, routing, provider selection, rate limiting, accounting, or a common API. They do not replace the underlying inference provider or engine.

- [LiteLLM Proxy](https://docs.litellm.ai/docs/simple_proxy): an AI gateway with a common API for multiple model providers and self-hosted endpoints.
- [OpenRouter](https://openrouter.ai/): a hosted gateway and router for models from multiple providers.
- [Nous Portal](https://portal.nousresearch.com/): API access and routing for supported models.

## Inference Engines and Servers

Inference engines load model artifacts, execute inference, and manage runtime concerns such as accelerator memory, batching, and request scheduling. Servers expose an engine through an API. Many projects combine both roles. See [Inference Engines / Servers](AI_Stack.md#inference-engines--servers) for the architectural explanation.

- [vLLM](https://vllm.ai/): LLM inference engine and API server.
- [SGLang](https://github.com/sgl-project/sglang): inference framework with an optimized runtime and serving interfaces.
- [llama.cpp](https://github.com/ggml-org/llama.cpp): inference runtime for CPUs and accelerators that also includes a server executable.
- [NVIDIA TensorRT-LLM](https://github.com/NVIDIA/TensorRT-LLM): optimized LLM inference runtime for NVIDIA GPUs with serving integrations.
- [NVIDIA Triton Inference Server](https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/index.html): inference server supporting multiple model backends.
- [OpenVINO Model Server](https://docs.openvino.ai/2025/model-server/ovms_what_is_openvino_model_server.html): inference server using OpenVINO execution backends.
- [MLServer](https://docs.seldon.ai/mlserver/): inference server with pluggable runtimes for multiple ML frameworks.

## Packaged and Local Inference Platforms

These products package model acquisition, runtime configuration, APIs, and often a user interface into a simpler local or self-hosted experience. Their convenience layer may incorporate one or more inference engines.

- [LM Studio](https://lmstudio.ai/): desktop model discovery, local inference, chat, and a local API server.
- [Ollama](https://ollama.com/): local model management and an API service around inference runtimes.
- [LocalAI](https://localai.io/): self-hosted, OpenAI-compatible API platform supporting multiple inference backends.
- [Jan](https://jan.ai/): desktop application for running local models and connecting to remote providers.
- [AnythingLLM](https://anythingllm.com/): self-hosted or desktop AI application with chat, document retrieval, agents, and provider integrations.
- [Lemonade Server](https://lemonade-server.ai/): local inference server and model-management environment.

## Serving and Orchestration Platforms

Serving and orchestration platforms deploy and operate inference services across machines or clusters. They manage concerns such as placement, scaling, health, networking, and lifecycle. They sit above an inference engine rather than performing model execution themselves.

- [KServe](https://kserve.github.io/website/): Kubernetes-native model serving with inference runtimes, autoscaling, and standardized serving APIs.
- [Ray Serve](https://docs.ray.io/en/latest/serve/index.html): distributed serving framework for composing and scaling Python inference applications.
- [Seldon](https://docs.seldon.ai/): Kubernetes model deployment and management platform.
- [Open Data Hub](https://opendatahub.io/): open-source AI platform for OpenShift that includes model-serving capabilities.
- [Red Hat OpenShift AI](https://www.redhat.com/en/technologies/cloud-computing/openshift/openshift-ai): supported platform for AI development and model serving on OpenShift.
- [NVIDIA NIM](https://docs.nvidia.com/nim/): packaged inference microservices that expose APIs around NVIDIA-optimized engines and model artifacts. NIM is a deployable inference component, not a cluster scheduler.
- [Gemini Enterprise Agent Platform](https://cloud.google.com/products/gemini-enterprise-agent-platform): hosted platform for building and operating enterprise agents.

## AI Applications and Harnesses

Applications and [harnesses](Terminology.md#harness) manage user interaction, prompts, context, tools, memory, permissions, and agent loops around one or more models. They consume inference APIs rather than being models themselves.

- [ChatGPT](https://chatgpt.com/): general-purpose web, desktop, and mobile AI application.
- [Claude](https://claude.ai/): general-purpose web, desktop, and mobile AI application.
- [Grok](https://grok.com/): general-purpose AI application available on the web, mobile devices, and X.
- [Gemini](https://gemini.google.com/): general-purpose web and mobile AI application.
- [ChatGPT Work](https://chatgpt.com/work/): task and workflow-oriented agent application.
- [Claude / Cowork](https://claude.com/product/overview): task and workflow-oriented agent application.
- [Grok Bot](https://x.ai/bot): task and workflow-oriented agent application.
- [Claude in Chrome](https://claude.com/claude-in-chrome): AI application integrated into a web browser.
- [Claude for Microsoft 365](https://claude.com/claude-for-microsoft-365): AI application integrated into Microsoft productivity software.
- [Claude in Slack / Claude Tag](https://claude.com/product/overview): AI application integrated into Slack.
- [Gemini for Google Workspace](https://workspace.google.com/solutions/ai/): AI application integrated into Google productivity software.
- [Claude Science](https://claude.com/product/claude-science): AI application for scientific-research workflows.
- [Claude Security](https://claude.com/product/claude-security): AI application for software-security workflows.
- [Grokipedia](https://grokipedia.com/): AI-generated encyclopedia application.
- [Gemini Notebook (NotebookLM)](https://notebook.google/): source-grounded research and notebook application.
- [Google AI Studio](https://aistudio.google.com/): browser-based model playground and application-prototyping environment.
- [Stitch](https://stitch.withgoogle.com/): AI-assisted interface-design application.

## Coding Agents and Coding Harnesses

Coding agents are harnesses specialized for source repositories, editors, terminals, and software-development tools. The coding agent remains distinct from the model and inference service it uses.

- [Codex](https://openai.com/codex/): coding agent for local and hosted workflows.
- [Codex Cloud](https://openai.com/codex/cloud): cloud coding agent connected to GitHub repositories.
- [Claude Code](https://claude.com/product/claude-code): coding agent for terminal, IDE, desktop, and web workflows.
- [Grok Build](https://x.ai/build): coding agent.
- [Google Antigravity](https://antigravity.google/): agent-oriented development environment.
- [Google Antigravity CLI](https://antigravity.google/product/antigravity-cli): terminal-based coding agent.
- [Gemini CLI](https://geminicli.com/): terminal-based coding agent.
- [Gemini Code Assist](https://codeassist.google/): coding assistant for supported IDEs.
- [Jules](https://jules.google/): coding agent for GitHub repositories.
- [OpenCode](https://opencode.ai/): coding agent for terminal and development workflows.
- [Cline](https://cline.bot/): coding agent integrated with supported editors.
- [Cursor](https://www.cursor.com/): AI-enabled development environment.
- [Windsurf](https://windsurf.com/): AI-enabled development environment.
- [Kiro](https://kiro.dev/): agent-oriented development environment.
- [Pi](https://github.com/badlogic/pi-mono): terminal-oriented coding agent.
- [oh-my-pi](https://github.com/can1357/oh-my-pi): terminal-oriented coding agent.

## RAG, Search, and Data Components

These systems retrieve documents or data that a harness can add to model context. Vector databases are one possible retrieval component, but RAG can also use full-text, relational, knowledge-graph, or hybrid search.

- [Elasticsearch](https://www.elastic.co/elasticsearch): search engine supporting text, vector, filtering, and hybrid retrieval patterns.
- [OpenSearch](https://opensearch.org/): search engine supporting text, vector, filtering, and hybrid retrieval patterns.
- [Milvus](https://milvus.io/): vector database for similarity search and metadata-filtered retrieval.
- [Qdrant](https://qdrant.tech/): vector database for similarity search and metadata-filtered retrieval.
- [pgvector](https://github.com/pgvector/pgvector): vector similarity search within PostgreSQL.

## Agent and Application Frameworks

Frameworks provide libraries and runtime patterns for composing model calls, tools, retrieval, state, and agent workflows. They help developers build a harness but are not themselves inference engines.

- [LangChain](https://python.langchain.com/docs/introduction/): framework providing components for model-powered applications.
- [LangGraph](https://langchain-ai.github.io/langgraph/): framework for stateful agent-workflow orchestration.
- [LlamaIndex](https://docs.llamaindex.ai/): framework for data-connected applications, retrieval, and agents.
- [Microsoft AutoGen](https://microsoft.github.io/autogen/): framework for agentic applications and multi-agent workflows.
- [Semantic Kernel](https://learn.microsoft.com/en-us/semantic-kernel/overview/): SDK for integrating models, tools, plugins, and agent processes.
- [Grok Voice Agent Builder](https://x.ai/voice): hosted tooling for building and deploying voice-agent applications.

## Fine-Tuning and Model Optimization

These tools adapt or optimize model artifacts before deployment. They are development and training tools, not desktop inference applications or serving platforms.

- [Unsloth](https://docs.unsloth.ai/): tooling for fine-tuning and reinforcement-learning workflows, model export, and inference-oriented optimization.

## Memory Systems

Memory systems persist and retrieve information across turns or sessions for an application or agent. They operate around the model and are distinct from the model's finite context window.

- [Honcho](https://honcho.dev/): application memory infrastructure focused on user and conversational context.
- [Mnemosyne](https://github.com/mnemosyne-oss/mnemosyne): an open-source, local memory service for AI applications.

## Observability and Evaluation

Observability and evaluation products record traces, latency, token usage, model responses, feedback, and test results. They help operators understand application and model behavior without becoming part of the model itself.

- [Arize Phoenix](https://phoenix.arize.com/): open-source tracing and evaluation for AI applications.
- [Langfuse](https://langfuse.com/): open-source tracing, prompt management, and evaluation platform.
- [OpenTelemetry](https://opentelemetry.io/): vendor-neutral telemetry framework that AI applications and gateways can use alongside AI-specific semantic conventions and tooling.

## Image and Video Generation

These applications and services provide workflows specialized for generative image or video models rather than general text inference.

- [ComfyUI](https://www.comfy.org/): node-based application and workflow environment for generative image, video, and related media models.
- [Grok Imagine](https://grok.com/imagine): image- and video-generation application.
- [Google Flow](https://labs.google/flow/about): AI-powered creative and video application.
- [Sora](https://openai.com/sora/): discontinued video-generation application.
