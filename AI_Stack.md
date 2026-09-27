# AI Stack

A full AI stack combines a user-facing client, a harness / AI application, an optional gateway / router, and an inference server that hosts the model on compute hardware. The harness coordinates tools and data and sends model requests through the inference API.

```mermaid
---
title: AI Stack Flow
---
flowchart LR
  client["User / Client / IDE"]
  harness["Harness / AI Application
  Prompts, context, conversation state
  Agent loops, tools, memory, permissions"]
  gateway["Gateway / Router (optional)
  Authentication, routing, rate limiting
  Accounting, provider aggregation"]
  subgraph serving["Model-serving layer"]
    server["Inference Server
    Loads and serves the model
    Schedules requests and batching
    Manages CPU / GPU / accelerator resources"]
    model["Model + Context / KV Cache
    Hosted and managed by the inference server"]
    server -->|Runs inference| model
  end
  hardware["Compute Hardware
  GPUs / NPUs / CPUs"]
  tools["Tools / MCP Servers / External APIs"]
  data["RAG / Data Sources / Memory"]
  peer["Independent Agent System / Harness"]

  client -->|Client API / ACP for agents| harness
  harness -->|Inference API| gateway
  gateway -->|Inference API| server
  harness -.->|Inference API when no gateway| server
  model -->|Executes on| hardware
  harness <-->|MCP / tool APIs: calls and results| tools
  harness <-->|Retrieval / memory APIs: queries and data| data
  harness <-.->|A2A| peer
```


## Stack Flow
A modern AI application might operate like this:

```
User sends prompt
 ↓
Harness / AI Application:
  •	manages the conversation, memory, and permissions
  •	constructs the model's context
  •	applies the system prompt
  •	provides tool descriptions and executes permitted tool calls
  •	retrieves information from RAG / data sources / memory
  •	performs context compaction
  •	manages agent loops
 ↓
Gateway / Router (optional):
  •	may authenticate, route, rate-limit, and account for requests
  •	may aggregate model providers
 ↓ Inference API (directly from the harness if no gateway)
Inference Server:
  •	loads and serves the model
  •	schedules requests and manages batching
  •	manages CPU/GPU/accelerator resources
 ↓
Model + Context / KV Cache (hosted by the inference server):
  •	processes tokens using context and inference-time cache
  •	performs reasoning
  •	generates responses, including requests to use available tools
 ↓ executes on
Compute Hardware: GPUs / NPUs / CPUs

Responses return through the inference server (and gateway, if used).
 ↓
Harness:
  •	executes permitted tool calls via MCP or other tool APIs
  •	receives tool results and retrieved data
  •	includes them as context in subsequent inference API requests
  •	presents the final response to the user
```
This distinction is important because an AI application's capabilities come from the combination of the model and the software surrounding it, rather than from the model alone.


## Interfaces and Protocols


### Inference APIs
An inference API lets a harness or application request inference and receive results from a server, directly or through a gateway. These interfaces generally fall into two broad categories:

- **Task/application-oriented APIs** expose higher-level operations such as chat, text generation, embeddings, structured output, or classification. [OpenAI-compatible APIs](https://platform.openai.com/docs/api-reference/introduction) are a common example, with JSON requests over HTTP to endpoints such as `/v1/chat/completions` and `/v1/embeddings`. Supported endpoints and features vary by server.
- **Tensor/model-oriented APIs** expose model inputs and outputs more directly as typed, shaped tensors. They support generalized ML serving rather than a specific application workflow.


### Inference Serving Protocols
Serving protocols standardize how clients and servers exchange inference requests, results, and related metadata. KServe's V2 inference protocol / [Open Inference Protocol (OIP)](https://github.com/kserve/open-inference-protocol) defines tensor-oriented request and response schemas with HTTP/REST and gRPC interfaces. OpenAI compatibility instead refers to an API convention, commonly implemented using JSON over HTTP.

### Model Context Protocol (MCP)
[MCP](https://modelcontextprotocol.io/) is an open protocol that lets an AI application connect to external tools, data sources, resources, and prompt templates through MCP servers. The application (the MCP client) remains responsible for deciding which servers to connect to and enforcing permissions; MCP standardizes the interface, not trust or authorization.

An MCP server acts as an adapter for a particular system, such as a filesystem, database, or service API. After the client connects, it can discover what the server offers: **tools** for taking actions, **resources** for reading data, and **prompts** for reusable interaction templates. Client and server exchange structured messages, commonly over a local process's standard input/output or HTTP, so the harness can integrate these capabilities without a custom connector for each service.

For example, a coding agent's harness might discover a database-query tool and describe it to the model. If the model requests a query, the harness decides whether to allow the call, sends the arguments to the MCP server, and returns the result to the model as context for its next response. The model does not connect to the database directly. An MCP server's ability to read or change data depends on its own credentials and the permissions the client gives it, so servers and their exposed tools should be configured with care.

### Agent Client Protocol (ACP)
[Agent Client Protocol (ACP)](https://agentclientprotocol.com/) standardizes the interface between a coding agent and the application presenting it to a user, typically an editor or IDE. It lets an editor integrate different agents without building a separate UI integration for each one. The client owns the user-facing experience and controls access to its resources; the agent does the coding work.

ACP uses JSON-RPC messages: the client and agent first negotiate capabilities and any required authentication, then create or resume a session. The client sends a prompt, and the agent streams session updates such as text, tool activity, and progress; it can also ask the client for file or terminal access and request permission before sensitive actions. A local agent commonly runs as an editor subprocess over standard input/output, while remote transports are also being developed.

### Agent2Agent Protocol (A2A)
[Agent2Agent (A2A)](https://a2a-protocol.org/) standardizes collaboration between independent agents, potentially built with different frameworks or run by different organizations. A remote agent publishes an **Agent Card** describing its endpoint, skills, and authentication requirements. Another agent or application can use that card to choose a suitable agent and send it a message or task; the remote agent works independently without exposing its internal tools or reasoning. For longer jobs, the caller can follow task status, receive updates by streaming or polling, and collect output **artifacts** such as documents or structured data. Unlike MCP, A2A connects agents to agents, not agents to tools.

In practice, a calling agent discovers the remote agent's card, authenticates as required, and sends a request to its HTTP endpoint containing a message with text, files, or structured data. The remote agent can answer immediately or return a task ID for work that continues asynchronously. If it needs more information, the task can enter an input-required state; the caller responds with another message tied to that task. When the task completes, the caller retrieves its artifacts and uses them in its own workflow.

> **NOTE:**
>
> The earlier [Agent Communication Protocol (also abbreviated ACP)](https://agentcommunicationprotocol.dev/) addressed this same agent-to-agent interoperability problem and joined A2A under the Linux Foundation; it is ***not*** the Agent Client Protocol above. Agent Client Protocol connects an agent to its user-facing client (for example, an IDE), whereas Agent Communication Protocol and A2A connect independently operating agents to one another for delegation and collaboration.


## Inference Engines / Servers
An **inference engine** loads models, executes inference, manages accelerator memory, and batches and schedules requests. An **inference server** exposes the engine through an inference API. Products may combine these roles with model management and other convenience features.

- [vLLM](https://vllm.ai/) — LLM inference engine and API server with request scheduling and continuous batching.
- [SGLang](https://github.com/sgl-project/sglang) — inference framework with an optimized runtime and serving interfaces.
- [llama.cpp](https://github.com/ggml-org/llama.cpp) — inference runtime for CPUs and accelerators, with a server executable.
- [Ollama](https://ollama.com/) — model management and an API service around inference runtimes, emphasizing ease of use.
- [NVIDIA Triton Inference Server](https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/index.html) — API serving and scheduling across multiple model execution backends.
- [TensorRT-LLM](https://github.com/NVIDIA/TensorRT-LLM) — optimized LLM execution on NVIDIA GPUs, with serving interfaces and integrations.
- [OpenVINO Model Server](https://docs.openvino.ai/2025/model-server/ovms_what_is_openvino_model_server.html) — inference server using OpenVINO execution backends.
- [MLServer](https://docs.seldon.ai/mlserver/) — inference server with pluggable runtimes for different ML frameworks.


## Serving / Orchestration Platforms
Serving and orchestration platforms deploy inference servers and manage their placement, scaling, availability, and routing across machines or clusters. Applications send requests to the deployed endpoints, optionally through a gateway for authentication, routing, rate limiting, and accounting; cluster schedulers allocate resources and launch processes outside this request path.

- [KServe](https://kserve.github.io/website/) — model deployment and serving on Kubernetes.
- [Seldon](https://docs.seldon.ai/) — model deployment and management on Kubernetes.
- [Ray Serve](https://docs.ray.io/en/latest/serve/index.html) — distributed serving applications with request routing and scaling.
- Kubernetes-based deployments — containers, service discovery, and resource management for inference servers.
- Slurm/custom HPC deployments — GPU-node allocation and server launch, with additional integration for API routing and service lifecycle management.

For example, KServe can manage a vLLM deployment on Kubernetes:

```text
KServe / Kubernetes
        ↓
vLLM
        ↓
Model
        ↓
GPUs
```

In an HPC environment, the corresponding deployment might be:

```text
Slurm / cluster orchestration
        ↓
vLLM or another inference runtime
        ↓
Model
        ↓
GPU nodes
```


## AI Infrastructure and Distributed Inference
LLM serving requires memory for model weights and runtime state, along with compute capacity to process requests. Resource requirements depend on the model, request lengths, concurrency, and scheduling.

### Weight Memory and Runtime Memory
Approximate storage for **weights only** is:

```text
Model weight memory ≈ parameter count × bytes per parameter
```

| Representation | Approximate weight storage |
|---|---:|
| FP32 | 4 bytes / parameter |
| FP16 / BF16 | 2 bytes / parameter |
| INT8 | ~1 byte / parameter |
| 4-bit | ~0.5 byte / parameter |

Quantization metadata, mixed-precision components, and storage layout affect the actual size. Runtime memory also includes:

- **KV cache** for previously processed tokens.
- Temporary activations and execution workspaces.
- Inference-runtime overhead, including buffers and allocator reservations.
- Additional cache and working memory for batching/concurrent requests.
- Multimodal components, such as vision/audio encoders and their intermediate representations, where applicable.

Weight storage depends on **total parameters**, including all experts in a **Mixture-of-Experts (MoE)** model. MoE routes each token through a subset of experts, so its **active parameters per token** can be much smaller than its total count. A **dense model** generally uses all its parameters for each token. The full MoE weights may still need to be stored across the serving hardware; active parameter count alone does not determine memory use or performance.

### KV Cache
The **key-value (KV) cache** stores attention state for tokens already processed, avoiding recomputation of that state during autoregressive generation. Unlike model weights shared across requests, this state is generally sequence-specific, although engines may share cached prompt prefixes.

KV-cache memory grows with context length and the number of concurrent sequences, and depends on model architecture and cache precision. A model whose weights fit in GPU memory can still run out of memory under long-context or highly concurrent workloads.

### Prefill and Decode
LLM inference has two major phases:

- **Prefill** processes the initial prompt/context. Work across prompt tokens is generally highly parallel and compute-intensive.
- **Decode** generates output tokens autoregressively, one step at a time per sequence, using and extending the KV cache. At low batch sizes, it is often limited by memory bandwidth rather than raw compute capacity.

Prefill contributes to **time to first token (TTFT)**, along with queueing and first-token generation. Decode performance affects **inter-token latency (ITL)**, the spacing of subsequent output tokens. A service can process prompts quickly but generate output slowly, or vice versa.

### Batching
**Batching** combines work from multiple requests to improve accelerator utilization and aggregate throughput. **Continuous batching** lets requests enter and leave the active batch dynamically as they arrive or finish, rather than waiting for an entire fixed batch to complete.

Interactive workloads generally prioritize low latency, while batch workloads prioritize aggregate throughput. Higher concurrency and larger batches can improve utilization but increase memory pressure and per-request latency. Performance metrics, including per-request and aggregate **tokens per second (TPS)**, are defined in [Terminology](Terminology.md).

### Distributed Inference
Distributed inference can split a model across devices (**model parallelism**), run independent replicas, or combine both approaches:

- **Tensor parallelism** splits computation within individual model layers across accelerators. It is common when a model cannot efficiently run on one GPU or when additional compute and memory bandwidth are useful; layer execution requires inter-device communication.
- **Pipeline parallelism** places groups of model layers on different accelerators or nodes and passes intermediate results between stages. Stage balance and keeping the pipeline busy affect utilization.
- **Data parallelism / replication** runs multiple model copies so independent requests can be served concurrently. It primarily increases aggregate throughput, not the capacity to fit a single model instance into less memory.
- **Expert parallelism** distributes MoE experts across accelerators and routes token representations to the devices hosting the selected experts.

For example, a service can run several replicas, each using tensor parallelism across a group of GPUs.

### Interconnects
When a single model spans multiple devices, accelerator-to-accelerator and node-to-node communication becomes part of inference execution. PCIe and NVLink/NVSwitch provide device connectivity within nodes; InfiniBand and high-speed Ethernet/RDMA can carry traffic between nodes. Depending on the parallelism strategy, model architecture, and hardware topology, distributed inference can become communication-bound. Adding devices therefore does not guarantee lower latency or proportional throughput gains.

### HPC Cluster Architecture
In an HPC deployment, model instances run on GPU nodes linked by the cluster interconnect. A single instance may span multiple nodes, or separate replicas may serve independent requests.

Cluster design depends heavily on the intended workload: **interactive inference** prioritizes responsiveness; **high-throughput batch inference** prioritizes aggregate work; **long-context workloads** increase prefill work and KV-cache pressure; and **multimodal workloads** add modality-specific processing and memory demands. **Fine-tuning** and **full model training** are separate workloads with additional training state and communication requirements.


## All-in-one solutions & desktop apps
- [lmstudio](https://lmstudio.ai/)
- [localai](https://localai.io/)
- [unsloth](https://github.com/unslothai/unsloth)
- [jan](https://jan.ai/)
- [anythingllm](https://github.com/AnythingLLM/anythingllm)
- [lemonade-server.ai](https://lemonade-server.ai/)


## Agents & Harnesses

### Agentic Concepts
- Plugins
- Skills
- Tools
- .agents file
- Memory
