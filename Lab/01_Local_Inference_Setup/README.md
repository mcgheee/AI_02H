# Replicating My Setup


## Installing Ollama

1. Download and install [Ollama](https://ollama.com/download)
```bash
curl -fsSL https://ollama.com/install.sh | sh
```
2. Configure Service
> We will configure the service to listen on a specific port on all interfaces, increase the default context window size to 64K, and move models to a larger drive.
   - Create and open a systemd override:
```bash
systemctl edit ollama.service
```
   - Add the following, then save and close the file:
```
[Service]
Environment="OLLAMA_MODELS=/mnt/data/ollama_models"
Environment="OLLAMA_HOST=0.0.0.0:55242"
Environment="OLLAMA_CONTEXT_LENGTH=65536"
```
> By default Ollama only listens on localhost:11434, has a context window of 4k, and stores models in `/usr/share/ollama/.ollama/models`
3. Set OLLAMA_HOST environment variable
```bash
export OLLAMA_HOST="0.0.0.0:55242"
```
> Add this to your shell config file to avoid having to set it every session or on every `ollama` call. The `ollama` command looks for the default location of `localhost:11434`. You *must* set this environment variable for the `ollama` command to look for the systemd service running on a custom port. If you try to run `ollama` and it states a server isn't running, DO NOT try to start one with `ollama serve`. If you do, you will be running a separate instance in the context of your user, and it will create duplicate model files in `~/.ollama/models`.
4. Enable and start the ollama service:
```bash
   sudo systemctl enable ollama.service --now
```
5. Download models:
```bash
ollama pull embeddinggemma
ollama pull gemma4:12B
ollama pull qwen2.5-coder:3b
ollama pull qwen3.8:27b
```
> These models are recommendations and serve different purposes. We will use embeddinggemma in a later project to generate embeddings. [Gemma4](https://ollama.com/library/gemma4) is going to be the default workhorse model. [Qwen2.5-Coder](https://ollama.com/library/qwen2.5-coder) is going to be used for code completions. Both Gemma4 and Qwen2.5-Coder come in various parameter sizes, so pick the ones that will run best on your hardware. The smallest versions are gemma4:e2b and qwen2.5-coder:0.5b. Don't bother with [Qwen3.8](https://ollama.com/library/qwen3.8) unless you have *at least* 24GB of VRAM. If you can run it, as of writing, it is the best in class for that size model.
6. Test to make sure inference is working by running a model:
```bash
ollama run gemma4:12B "Hello! Are all systems nominal?"
```
> Type `/bye` to quit.


## Installing Hermes Agent

Hermes agent is a harness geared more toward being a personal assistant. It's a direct competitor to OpenClaw but comes with the benefit of self improvement via skill curation. It will work fine for a general purpose harness, but I would recommend choosing a more specialized harness for coding.

1. Run the install script:
```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```


## Agentic Configuration




## TTS & VTT




## Image & Video




### Comfy.ui

#### Example prompt
```
Sort the entries in Terminology.md into related categories.
---
Sort the entries in Terminology.md alphabetically, and append the categorie they belonged to as a tag at the end of each entry.

```
# Todo:
Create skill file to recreate model comparison table. (maybe convert to json instead of csv?)
Please change model_comparison.html to load its entries from the model_comparison.csv (JSON) file. Please also add a dark theme and the option to switch.

# Useful Prompts:
## Review Prompt
```
[@GitHub](plugin://github@openai-curated-remote) [https://github.com/mcgheee/AI\_Catchup\_Course](https://github.com/mcgheee/AI_Catchup_Course) I am building a small course for my coworkers to catch them up on the state of the AI industry. They are all system administrators at a high performance computing lab. We are looking into building a new cluster to run AI workflows. They have all interacted with AI chats, but have not worked with agents or tried self hosting. The focus of this course is on the application stack, and how the different pieces fit together. I am trying to keep the course high level enough that I can present it in under an hour, while giving them a deep enough understanding of the current state of the industry, buzzwords, and terms & concepts that they can dig deeper on their own. They should come away understanding the basic architecture of an AI system. I would like the documentation in this repo to supplement the course, and go slightly more in depth than the presentation.

Please do the following:

- Suggest terms and concepts that I am missing
- Check to ensure the content matches my target audience and intended message in depth and breadth. Suggest what I should add, remove, or change.
- Ensure the documents flow logically, and suggest any changes to organization or structure.
- Ignore Replicating\_My\_Setup.md for now
```

Plagiarism Check:
```
Please check for plagiarism in the content. Anywhere you find it, add a citation to the source.
```
