# Request Walkthrough Animation

Open [the interactive walkthrough](request-walkthrough.html) in a browser. It is a standalone HTML file with inline graphics, styles, and JavaScript. Playback works offline without a server, external fonts, packages, or model credentials.

The illustrative scenario investigates a failed HPC job by reading its log. Twelve steps show one user question, two inference requests, and one tool invocation. The default playback takes about 81 seconds. Timing is for presentation pacing and does not represent measured service latency.

## Presenting

- Use **Play / Pause** for automatic playback, or **Back / Next** to narrate each step yourself.
- Select a chapter or a segment of the timeline to jump directly to it. Jumping pauses playback.
- Use **Restart** to return to the beginning. Playback stops after the final answer.
- Choose **Pace** to change playback speed, or **Fullscreen** for projection.
- Keyboard shortcuts are **Space** for play / pause, **Left / Right** for stepping, and **F** for fullscreen when focus is outside an interactive control.
- Reduced-motion preferences disable packet movement while retaining playback and step navigation.
- Playback waits while the browser tab is hidden.

## What to emphasize

The model produces a structured tool request. The inference server returns that request to the harness. The harness checks permissions and invokes the tool, which accesses the log store using scoped credentials. The tool result returns to the harness and enters the context of a second inference request. Model weights do not change.

The gateway is optional. MCP is a representative tool interface, not a requirement for tool use. The payloads show conceptual messages rather than exact API or MCP wire formats. The job, log excerpt, and answer are fictional. The example ends with an explanation and does not rerun or modify a job.

The diagram combines some architectural roles for readability. The inference engine and model appear inside the inference server. Hardware is identified without a separate compute path. Tool discovery and authentication setup are assumed to have happened before the walkthrough. The application and data service both enforce appropriate permissions.

## Related reference material

- [AI Stack](../../../Reference/AI_Stack.md)
- [AI Agents](../../../Reference/AI_Agents.md)
- [Guardrails](../../../Reference/Guardrails.md)

## Editing

The `steps` array in the HTML contains the narration, illustrative payloads, active components, paths, and duration for every step. Update it to adapt the example or change presentation pacing. Component labels and diagram geometry live in the inline SVG.
