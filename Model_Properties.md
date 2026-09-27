# Model Properties
LLM serving requires memory for model weights and runtime state, along with compute capacity to process requests. Resource requirements depend on the model, request lengths, concurrency, and scheduling.

## What Gets Deployed

A model is not normally deployed as one self-contained executable. An operator obtains a collection of [model artifacts](Terminology.md#model-artifact) and configures an [inference engine](Terminology.md#inference-engine) that knows how to load them. A typical model repository might look like this:

```text
Model repository
├── model configuration
├── tokenizer configuration and files
├── model weights, possibly split into multiple files
├── generation configuration
├── model card
└── license
```

This is a conceptual example, not a required layout. Repositories vary by model type, framework, and publisher. A repository may omit some items, add custom code or preprocessing files, provide several weight representations, or link licensing information elsewhere. Operators should inspect the repository rather than assume that a familiar filename has a fixed meaning.

### Architecture, Weights, and Checkpoints

The **model architecture** defines the computation graph and the arrangement of components such as layers, attention mechanisms, and, where applicable, routed experts. The **model weights** are the learned parameter values used by that architecture. Inference requires a compatible implementation of the architecture and a particular set of weights.

A **checkpoint** is the saved state of a model at a particular point in training or fine-tuning. In deployment discussions, the term often refers to a particular released set of weights together with enough configuration to load it. Training checkpoints can also contain optimizer and training state that an inference deployment does not need.

A **model artifact** is any file or packaged object needed to distribute, load, describe, or operate a model. Weight files are artifacts, but the term can also include configuration, tokenizer files, and documentation. At startup, the inference engine reads the configuration, constructs or selects an implementation of the architecture, loads the weights into host or accelerator memory, and allocates runtime state. The artifact files themselves do not accept requests.

These layers should not be conflated:

| Name | Architectural role |
|---|---|
| Qwen | Model family and developer ecosystem |
| A specific Qwen3 model release | Particular model or checkpoint |
| Files in that release's repository | Model artifacts |
| Hugging Face Hub | Model distribution and registry service |
| vLLM | Inference engine and server |
| KServe | Serving and orchestration platform |

A **model family** groups related architectures and releases. A named release within that family identifies a more specific architecture, size, modality, training stage, and weight set. Even then, multiple artifact variants can represent that release, such as full-precision and quantized weights. Runtime compatibility depends on the exact variant, not only the family name.

### Tokenizer and Configuration

For a text model, the [tokenizer](Terminology.md#tokenizer) converts text into the token IDs the model consumes and converts generated IDs back into text. Its vocabulary, normalization rules, special tokens, and chat template must match the checkpoint's expectations. Substituting a tokenizer merely because it belongs to the same broad family can produce incorrect token IDs or malformed prompts.

The **model configuration** records the structural settings needed to instantiate the model, such as architecture identifier, layer dimensions, vocabulary size, and data types. The exact fields are implementation-specific. A separate **generation configuration** can provide default inference behavior such as sampling settings and end-of-sequence token IDs. Applications and inference servers may override generation defaults per request. Neither configuration contains the learned capability represented by the weights.

The **model card** documents the release. It can describe intended uses, limitations, evaluation results, training context, and usage examples. It is operational documentation, not a machine-enforced policy. The **model license** states the legal terms for using and redistributing the artifacts. Access to a repository does not by itself establish that a model is permitted for every organizational or commercial use. Operators need to review the license and any applicable use restrictions.

### Weight Formats and Quantized Artifacts

**Safetensors** is a format for storing tensors. It is designed for safe, efficient tensor serialization and is commonly used for weight files in model repositories. A large checkpoint may be sharded across several Safetensors files with an index that maps tensors to shards. The format does not define the model architecture, tokenizer, license, or serving API. Those arrive through other artifacts and runtime support. See the [Safetensors documentation](https://huggingface.co/docs/safetensors/en/index) for its supported frameworks and format details.

**GGUF** is a file format from the GGML ecosystem that packages tensors together with metadata needed by compatible runtimes. It is commonly encountered with locally run and quantized models. A GGUF file is still not an inference engine, and compatibility depends on whether the chosen runtime supports the model architecture and the file's quantization types. The [upstream GGUF specification](https://github.com/ggml-org/ggml/blob/master/docs/gguf.md) documents the format.

A **quantized model artifact** contains weights converted to a lower-precision representation for deployment. It is derived from a checkpoint, but it is a distinct artifact with its own accuracy, memory, hardware, and runtime-compatibility characteristics. Labels such as “4-bit” are not sufficient to establish that two files use the same quantization scheme or will perform identically. Quantization may also be performed while loading rather than distributed as a pre-quantized artifact.

### Repositories, Registries, and Hubs

A **model repository** is a versioned collection of model artifacts and metadata. A **model registry** or **model hub** provides discovery, distribution, versioning, access controls, and related metadata for repositories. The terms overlap in practice. Some registries are internal lifecycle systems, while public hubs emphasize publishing and collaboration.

[Hugging Face Hub](https://huggingface.co/docs/hub/en/models-the-hub) is a major public and private distribution ecosystem for model repositories. It hosts artifacts and metadata and provides APIs and client libraries for obtaining them. Hugging Face is an organization and platform, not itself a model or an inference engine. Downloading from the Hub does not determine which engine will serve a model, and the presence of a repository does not guarantee compatibility with every runtime.

Production deployments often copy approved artifacts from an external hub into internal object storage, a shared filesystem, or a controlled registry. Nodes may then populate a local cache before the engine loads weights into memory. Pinning an immutable revision, recording provenance, verifying integrity, scanning any included executable code, and controlling registry credentials make deployment repeatable and reduce supply-chain risk.

## Runtime Resource Properties

### Weight Memory and Runtime Memory
Approximate storage for weights only is:

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

- [KV cache](Terminology.md#kv-cache).
- Temporary activations and execution workspaces.
- Inference-runtime overhead, including buffers and allocator reservations.
- Additional cache and working memory for batching/concurrent requests.
- Multimodal components, such as vision/audio encoders and their intermediate representations, where applicable.

For both [dense](Terminology.md#dense-model) and [Mixture-of-Experts (MoE)](Terminology.md#mixture-of-experts-moe) models, the weight-storage estimate uses [total parameters](Terminology.md#total-parameters), not [active parameters per token](Terminology.md#active-parameters).

### KV Cache
Capacity planning must reserve space for the [KV cache](Terminology.md#kv-cache) in addition to model weights. A model whose weights fit in GPU memory can still run out of memory under long-context or highly concurrent workloads. Engines may reduce cache usage by sharing common prompt prefixes across requests.

### Prefill and Decode
[Prefill](Terminology.md#prefill) is generally highly parallel and compute-intensive, while [decode](Terminology.md#decode) at low batch sizes is often limited by memory bandwidth. These phases can therefore benefit from different scheduling and resource allocations.

[Time to first token (TTFT)](Terminology.md#time-to-first-token-ttft) and [inter-token latency (ITL)](Terminology.md#inter-token-latency-itl) help distinguish prompt-processing delays from slow generation when evaluating a service.

### Batching
[Batching](Terminology.md#batching) policies depend on the workload: interactive services generally prioritize low latency, while batch jobs prioritize aggregate throughput. [Continuous batching](Terminology.md#continuous-batching) is useful when requests have different prompt and output lengths. Batch limits must leave enough memory for active requests and avoid excessive queueing.

Benchmarks reported in [tokens per second (TPS)](Terminology.md#tokens-per-second-tps) need comparable request lengths, concurrency, and latency targets to support capacity decisions.
