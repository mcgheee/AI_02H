# AI Brownbag

This document is designed to be a longer refernce document to accompany a course designed to get OPs team members up to speed quickly current AI trends over a long lunch break or afternoon.

## Terminology

The agentic AI space has grown rapidly, and like any other area of tech, has generated its own buzzwords and lingo. Before diving any deeper, we need to make sure everyone is on the same page with the terminolgy.

### Gen AI or Generative AI -
Artificial Intelligence systems designed to generate new content, such as text, images, audio, video, or other forms of data. Generative AI includes technologies such as Large Language Models and Diffusion models. 
 
### Model - 
The trained AI system that performs the actual prediction, generation, or analysis. A model contains parameters learned during training and uses those parameters during inference to produce results. Examples of model families include GPT, Claude, Gemini, Llama, Qwen, and Stable Diffusion. A model should not be confused with the application used to interact with it. The same model may be available through multiple harnesses or inference servers. 
 
### LLM or Large Language Model – 
A model that has been trained primarily on text for natural language processing tasks such as answering questions, writing, summarizing, translating, and generating code.
 
### Diffusion Model – 
A type of generative model, typically used for images or video, that generates output by iteratively removing noise from random static.
 
### Multimodal Models - 
AI Models that can process both text and images as input.
 
### Training - 
The process used to create or modify an AI model by exposing it to large amounts of data and adjusting its internal parameters based on patterns in that data.
 
### System Prompt – 
a set of instructions provided to an LLM that defines the model’s behaviour before user interaction. This is typically invisible to the user and are similar to the “you are (an expert in..)” statements that used to be recommended for prompt engineering. The system prompt can be customized to create specialized behaviour without retraining the model, like OpenAI’s Custom GPTs or UT Verse’s AI Assistants. 
 
### Inference -
The process of running a trained AI model to generate or analyze information. When you send a prompt to an LLM and it generates a response, the model is performing inference.
 
### Inference Server –
Software that loads and runs AI models and makes them available to other software, typically through an API. It manages hardware resources, model memory, and inference requests. An inference server generally does not provide the complete user experience. Instead, another application or harness communicates with it. Examples include Ollama, vLLM, llama.cpp server, and OpenVINO Model Server.
 
### Harness –
Software infrastructure that allows users or other software to interact with AI models. A harness sends requests to a model, directly or through an inference server, and may provide additional capabilities such as conversation history, file access, tools, memory, or agentic behavior. Examples include: ChatGPT, Claude, or UT Verse as chat harnesses; Claude Code, Codex, and OpenCode as coding harnesses; and ComfyUI as a harness for image and video generation models.
 
### Agent –
A type of AI system where a harness allows an LLM to operate in a loop. Instead of providing a single response to a prompt, it allows a model to act continually to pursue goals, use tools, and take actions autonomously. This is not to be confused with chatbots that have been customized to provide specific responses (OpenAI’s Custom GPT, or UT Verse’s AI Assistants).
 
### Turn –
A single conversational exchange with an AI where either the user provides input or the AI responds. For example, providing a prompt is one turn and the AI's response is another.
 
### Token –
A unit of text that an LLM reads or generates. It can be as long as a short phrase or as short as a single character. Text is broken up by tokenization before being processed by a model. 
 
### Context Window –
The working memory available to an LLM, measured in tokens. It limits how much information the model can consider at once, including conversation history, prompts, documents, and tool results. Larger context windows allow models to process longer inputs.
 
### Context Compaction –
techniques used by AI harnesses to reduce the utilization of a context window. An example would be summarizing and pruning messages from a conversation to allow longer chats without losing context of the conversation.
 
### Thinking –
An informal term for additional processing an AI model performs before producing its final response. It usually refers to the model generating or evaluating intermediate reasoning steps during inference and should not be interpreted as human-like thought or consciousness
 
### Reasoning –
The process an AI model uses to work through a problem before producing a final response. Reasoning models are designed to spend additional computation analyzing a problem, considering intermediate steps, or evaluating possible solutions before answering. More reasoning can improve performance on complex tasks like mathematics, coding, planning, and troubleshooting, but generally increases response time and computational cost.
 
### Vision –
The ability of an AI model to process visual information such as images, screenshots, diagrams, charts, and document pages.
 
### Quantization -
A technique that reduces the precision of a model’s numerical parameters so it uses less memory and can run faster. Lower quantization levels can make large models easier to run on limited hardware, but may reduce model quality or accuracy.
 
### RAG or Retrieval-Augmented Generation –
Techniques that enable LLMs to incorporate information from external data sources after training. An example would be searching provided documentation and adding relevant information to the model's context before answering a question.
 
### Tools –
External capabilities provided to a model by a harness. Tools allow a model to perform actions that it could not perform using the model alone, such as searching the web, reading files, executing code, querying databases, or interacting with APIs.
 
### Tool Use -
The process of a model requesting that the harness use a tool, receiving the result, and using that information to continue its task or generate a response.
 
### MCP Server –
Software that exposes tools or resources, such as web browsers, documentation, databases, or APIs, to AI harnesses using the standardized Model Context Protocol. 
 
 




# Cyber-Infrastructure & Scaffolding

## How parts of an AI application work together
A modern AI application might operate like this:
 User asks a question
 ↓
 Harness:
•	manages the conversation
•	constructs the model's context
•	applies the system prompt
•	provides tools
•	performs context compaction
•	manages agent loops
 ↓
 Inference Server
•	loads the model
•	manages CPU/GPU resources
•	performs inference requests
 ↓
 Model:
•	processes tokens
•	performs reasoning
•	generates responses
•	decides when available tools should be used
 ↓
 Tools / MCP Servers / RAG Sources:
•	provide external information
•	execute actions
•	return results to the harness and model
 ↓
 Harness presents the final response to the user
 
This distinction is important because an AI application's capabilities come from the combination of the model and the software surrounding it, rather than from the model alone.

## Frontier Providers & Services

### OpenAI
  - ChatGPT (web)
  - ChatGPT (desktop)
  - Codex (cli)

### Anthropic
  - Claude (web)
  - Claude Code (cli)
  - Claude Cowork (desktop)

### Grok
  - Grok (web)
  - Grok Bot
  - 

### Google
  - Gemini
  - Antigravity
  - NotebookLM

## Open Providers & Routers
- OpenRouter
- Nous Portal

## Local Inference Servers
- ollama
- lmstudio
- vllm

## All-in-one solutions & desktop apps
- localai
- unsloth
- jan
- anythingllm
- lemonade-server.ai

## Agents & Harnesses

### Agentic Concepts
- Plugins
- Skills
- MCP
- ACP
- .agents file
- Memory

### Agents
- openclaw
- hermes

### Coding Harnesses
- pi
- oh my pi / lazy pi
- opencode
- kiro
- cursor
- windsurf
- cline

## TTS & VTT

## Image & Video
### Comfy.ui

## Replicating My Setup
### Installing Ollama
### Installing Hermes Agent
### Agentic Configuration
