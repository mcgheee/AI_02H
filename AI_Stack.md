# AI Stack

A full AI stack combines a user-facing client, a harness / AI application, an optional gateway / router, and an inference server that hosts the model on compute hardware. The harness coordinates tools and data and sends model requests through the inference API.

```mermaid
---
title: AI Stack
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

The RAG / data connection in the diagram represents a retrieval pipeline rather than a property of the model. See [Retrieval-Augmented Generation Architecture](RAG.md) for its separate ingestion and query paths.

## Harnesses
A harness is the application layer around a model. It turns a user's request into model inputs, maintains conversation state, and decides what to do with the model's outputs. It assembles prompts and relevant context, manages agent loops and context compaction, and can retrieve data or make tools available to the model. When the model requests a tool call, the harness checks permissions, executes the call, and feeds the result back into a subsequent model request.

This separates application behavior from inference. The inference server runs the model and returns its output; the harness determines how that output becomes an action or a response to the user. A coding agent, for example, can use a harness to read files, run permitted commands, and present its work in an IDE. The interfaces below describe how the harness communicates with model servers, tools, clients, and other agents.

## Interfaces and Protocols

### Inference APIs
An inference API lets a harness or application request inference and receive results from a server, directly or through a gateway. These interfaces generally fall into two broad categories:

- **Task/application-oriented APIs** expose higher-level operations such as chat, text generation, embeddings, structured output, or classification. [OpenAI-compatible APIs](https://platform.openai.com/docs/api-reference/introduction) are a common example, with JSON requests over HTTP to endpoints such as `/v1/chat/completions` and `/v1/embeddings`. Supported endpoints and features vary by server.
- **Tensor/model-oriented APIs** expose model inputs and outputs more directly as typed, shaped tensors. They support generalized ML serving rather than a specific application workflow.


### Inference Serving Protocols
Serving protocols standardize how clients and servers exchange inference requests, results, and related metadata. KServe's V2 inference protocol / [Open Inference Protocol (OIP)](https://github.com/kserve/open-inference-protocol) defines tensor-oriented request and response schemas with HTTP/REST and gRPC interfaces. OpenAI compatibility instead refers to an API convention, commonly implemented using JSON over HTTP.

### Model Context Protocol (MCP)
[MCP](https://modelcontextprotocol.io/) is an open protocol that lets an AI application connect to external tools, data sources, resources, and prompt templates through MCP servers. The application (the MCP client) remains responsible for deciding which servers to connect to and enforcing permissions; MCP standardizes the interface, not trust or authorization.

After connecting to an [MCP server](Terminology.md#mcp-server), the client can discover its [tools](Terminology.md#tools), resources, and prompt templates. Client and server exchange structured messages, commonly over a local process's standard input/output or HTTP, so the harness can integrate these capabilities without a custom connector for each service.

For example, a coding agent's harness might discover a database-query tool and describe it to the model. If the model requests a query, the harness decides whether to allow the call, sends the arguments to the MCP server, and returns the result to the model as context for its next response. The model does not connect to the database directly. An MCP server's ability to read or change data depends on its own credentials and the permissions the client gives it, so servers and their exposed tools should be configured with care.

### Agent Client Protocol (ACP)
[Agent Client Protocol (ACP)](https://agentclientprotocol.com/) standardizes the interface between a coding agent and the application presenting it to a user, typically an editor or IDE. It lets an editor integrate different agents without building a separate UI integration for each one. The client owns the user-facing experience and controls access to its resources; the agent does the coding work.

ACP uses JSON-RPC messages: the client and agent first negotiate capabilities and any required authentication, then create or resume a session. The client sends a prompt, and the agent streams session updates such as text, tool activity, and progress; it can also ask the client for file or terminal access and request permission before sensitive actions. A local agent commonly runs as an editor subprocess over standard input/output, while remote transports are also being developed.

### Agent2Agent Protocol (A2A)
[Agent2Agent (A2A)](https://a2a-protocol.org/) standardizes collaboration between independent agents, potentially built with different frameworks or run by different organizations. A remote agent publishes an Agent Card describing its endpoint, skills, and authentication requirements. Another agent or application can use that card to choose a suitable agent and send it a message or task; the remote agent works independently without exposing its internal tools or reasoning. For longer jobs, the caller can follow task status, receive updates by streaming or polling, and collect output artifacts such as documents or structured data. Unlike MCP, A2A connects agents to agents, not agents to tools.

In practice, a calling agent discovers the remote agent's card, authenticates as required, and sends a request to its HTTP endpoint containing a message with text, files, or structured data. The remote agent can answer immediately or return a task ID for work that continues asynchronously. If it needs more information, the task can enter an input-required state; the caller responds with another message tied to that task. When the task completes, the caller retrieves its artifacts and uses them in its own workflow.

> **NOTE:**
>
> The earlier [Agent Communication Protocol (also abbreviated ACP)](https://agentcommunicationprotocol.dev/) addressed this same agent-to-agent interoperability problem and joined A2A under the Linux Foundation; it is ***not*** the Agent Client Protocol above. Agent Client Protocol connects an agent to its user-facing client (for example, an IDE), whereas Agent Communication Protocol and A2A connect independently operating agents to one another for delegation and collaboration.


## Self-Hosted AI Architecture

Self-hosting means that an organization operates the inference endpoint and the resources behind it rather than sending each model request to an externally operated service. It does not imply a single machine or a disconnected environment. A deployment can range from one workstation running one model to a cluster with replicated services, shared storage, and separate management systems.

### Request Path

The request path contains the components that handle an inference request or execute the model on its behalf:

```text
Client / AI application
        ↓
Gateway / ingress
        ↓
Inference service
        ↓
Inference engine
        ↓
Model artifacts loaded by the engine
        ↓
Accelerator runtime and device drivers
        ↓
GPU / accelerator hardware
```

- The **client or AI application** constructs the request and consumes the response. A harness can add conversation state, retrieved information, tool results, and other context.
- The **gateway or ingress** exposes a reachable endpoint. It can terminate TLS, authenticate callers, apply quotas, route requests, and balance traffic across service instances. A small deployment can expose the inference service directly instead.
- The **inference service** provides the network API and manages request queues, streaming responses, and service-level limits. One service can have one or more server instances.
- The **inference engine** tokenizes inputs, batches and schedules model execution, and manages weights and runtime state such as the [KV cache](Terminology.md#kv-cache). The service and engine are often packaged in the same process even though their architectural roles differ.
- The **model artifacts** include the weights, configuration, tokenizer, and other files needed by the engine. They are inputs to the running service, not another network service in the path. See [What Gets Deployed](Model_Properties.md#what-gets-deployed).
- The **accelerator runtime and drivers** provide the software interface between the engine's framework kernels and the devices. Compatibility between the engine, runtime, drivers, and hardware is an operational requirement.
- The **GPU or other accelerator** holds weights and runtime state in device memory and executes the model operations. CPU-only serving follows the same general layers without an accelerator runtime.

The arrows show logical dependencies rather than requiring a separate product or host for every box. For example, an inference server commonly contains both the API service and inference engine, while a local client might call that server without a gateway.

### Supporting and Control-Plane Systems

Other systems prepare, place, secure, and monitor the service. They support the request path but do not normally process every inference request:

```text
Model registry / hub ──→ model storage and caches ──→ inference instances
                                  ↑
Orchestrator / scheduler ── launches and manages instances
Service discovery ───────── registers healthy endpoints for routing
Identity, policy, secrets ─ supplies credentials and access rules
Observability systems ───── collect logs, metrics, traces, and events
```

- **Model distribution and storage:** A model registry or hub provides approved, versioned artifacts. Object storage or a shared filesystem can provide cluster-wide access. A node-local model cache reduces repeated transfers and can improve restart time. A deployment can copy artifacts into local storage ahead of launch or populate the cache on demand. Operators should pin artifact revisions and protect registry and storage credentials. The [Hugging Face cache documentation](https://huggingface.co/docs/huggingface_hub/guides/manage-cache) provides one implementation example.
- **Orchestration and scheduling:** An orchestrator or cluster scheduler selects nodes, allocates accelerators, and launches or replaces server instances. Kubernetes and Slurm are representative choices with different service and batch-computing conventions. They manage processes and resources outside the normal data path. A scheduler decision might determine which server receives GPUs, but the scheduler does not normally receive the prompt or generated tokens. See the [Kubernetes workload documentation](https://kubernetes.io/docs/concepts/workloads/) and [Slurm overview](https://slurm.schedmd.com/overview.html) for their respective resource-management roles.
- **Service discovery and health:** Instances publish their endpoints, and health checks prevent an ingress or load balancer from routing to a server that is starting, unhealthy, or draining. A platform can supply this function, or operators can integrate a separate registry. Kubernetes [Services](https://kubernetes.io/docs/concepts/services-networking/service/) are one example of discovery and stable access to changing backends.
- **Authentication and authorization:** Authentication establishes the caller's identity. Authorization controls which models, operations, and data that identity can access. Enforcement can occur at the gateway, service, and data systems. Network location alone is not an adequate authorization policy.
- **Secrets:** Registry tokens, TLS keys, and service credentials need controlled distribution, rotation, and auditing. They should not be embedded in model repositories, images, or application source.
- **Observability:** Logs record request and lifecycle events, metrics expose measures such as queue depth, latency, throughput, errors, and accelerator utilization, and traces can connect work across gateways and services. Prompts and outputs can contain sensitive data, so collection and retention policies must account for their contents.
- **Quotas and admission control:** Per-user or per-project quotas limit consumption. Admission control can reject, defer, or route work when request size, queue depth, context length, or accelerator capacity would violate policy or service objectives. This protects the long-running service from unbounded demand.

Not every deployment needs every component. A single-node lab service might use local artifacts, process-local logging, and static endpoint configuration. A multi-tenant cluster usually needs stronger identity, quotas, discovery, durability, and monitoring. The architecture should add components in response to availability, security, scale, and operational requirements rather than treating the full list as mandatory.

The boundary between request-path and control-plane components matters when troubleshooting. A gateway or inference service is involved in normal request latency. Slurm or Kubernetes may allocate resources and start that service, while storage may supply its model during startup. Once the instance is ready, neither the scheduler nor model registry is normally traversed by each inference request.


## Inference Engines / Servers
An inference engine loads models, executes inference, manages accelerator memory, and batches and schedules requests. An inference server exposes the engine through an inference API, returning or streaming results. Products may combine these roles with model management and other convenience features.


## Serving / Orchestration Platforms
Serving and orchestration platforms deploy inference servers and manage their placement, scaling, health checks, rollouts, and routing across machines or clusters. Applications send requests to the deployed endpoints, optionally through a gateway for authentication, routing, rate limiting, and accounting; cluster schedulers allocate resources and launch processes outside this request path.

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

## Distributed Inference
A deployment can combine [model parallelism](Terminology.md#model-parallelism) within each instance with [data parallelism](Terminology.md#data-parallelism) across instances. For example, a service might run several replicas, each using [tensor parallelism](Terminology.md#tensor-parallelism) across a group of GPUs. Requests can be routed among replicas while each GPU group cooperates on its assigned work.

[Pipeline parallelism](Terminology.md#pipeline-parallelism) and [expert parallelism](Terminology.md#expert-parallelism) add placement considerations: layer groups and MoE experts must be distributed with enough memory, balanced work, and suitable connectivity. The combination depends on model architecture, runtime support, and cluster topology.

### Interconnects
When a single model spans multiple devices, accelerator-to-accelerator and node-to-node communication becomes part of inference execution. PCIe and NVLink/NVSwitch provide device connectivity within nodes; InfiniBand and high-speed Ethernet/RDMA can carry traffic between nodes. Depending on the parallelism strategy, model architecture, and hardware topology, distributed inference can become communication-bound. Adding devices therefore does not guarantee lower latency or proportional throughput gains.

### HPC Cluster Architecture
In an HPC deployment, model instances run on GPU nodes linked by the cluster interconnect. A single instance may span multiple nodes, or separate replicas may serve independent requests.

Cluster design depends heavily on the intended workload: interactive inference prioritizes responsiveness; high-throughput batch inference prioritizes aggregate work; long-context workloads increase prefill work and KV-cache pressure; and multimodal workloads add modality-specific processing and memory demands. Fine-tuning and [full model training](Terminology.md#training) are separate workloads with additional training state and communication requirements.
