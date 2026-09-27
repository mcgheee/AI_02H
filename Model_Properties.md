# Model Properties
LLM serving requires memory for model weights and runtime state, along with compute capacity to process requests. Resource requirements depend on the model, request lengths, concurrency, and scheduling.

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

