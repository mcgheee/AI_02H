<p align="center">
  <img src="AI_02H_Cyberpunk_Learningscape.png" alt="AI Zero to Hero" width="100%">
</p>

# Generative AI Zero to Hero

This is a course in the making targeted towards SysAdmins, Homelabbers, & those tech savvy enough to know the underlying concepts or at least be able to research them idependently as they go. The lectures try to stay at a relatively high level, while topics are explained in depth inside the Reference files. The Labs are simply a walkthrough of how I have set things up, including insights I learned along the way. They are *not* a definitive 'right way' to do things, just a guided path. Expect the course to grow and evolve as I learn and the field progresses.


### Disclaimer:

AI is used **heavily** in composing these documents, but always with human review.

# Course Content

## Lectures
1. [Intro to AI Application Stack / CyberInfrastructure](./Lecture/01_AI_App_Stack/README.md)


## Labs
1. [Setting up Ollama for self hosted inference](./Lab/01_Local_Inference_Setup/README.md)


## Reference
1. [AI agents and agentic workflows](./Reference/AI_Agents.md)
2. [Architecture of the AI application stack](./Reference/AI_Stack.md)
3. [How AI guardrails work](./Reference/Guardrails.md)
4. [HPC inference architecture](./Reference/HPC_Inference_Architecture.md)
5. [Model properties and inference resource requirements](./Reference/Model_Properties.md)
6. [AI ecosystem map: products and services](./Reference/Products_and_Services.md)
7. [Prompt engineering examples](./Reference/Prompt_Engineering.md)
8. [Retrieval-augmented generation (RAG) architecture](./Reference/RAG.md)
9. [AI terminology and concepts](./Reference/Terminology.md)
10. [Useful prompts for reviewing and improving course documents](./Reference/Useful_Prompts.md)

# Tooling

I believe one of the best uses of AI is self guided instruction. To that end, all of the documents in this repo are written in MarkDown, making it easy for AI to parse. Clone the repo, point your locally hosted Agent at it using locally hosted inference, and have a conversation with the course itself offline.

As an extension of that, I have used [Marp](https://marp.app/) to render the slide decks, and [Mermaid](https://mermaid.ai/open-source/intro/index.html) for diagrams. As of the writing of this document, Mermaid support is coming to Marp 5 and is available to use in a [preview build](https://github.com/orgs/marp-team/discussions/625#prepare-for-v5). The bash scripts at the root of this repo automate the install of Marp CLI v4.5.1 + Marp Core @next, and the rendering of slide decks.

[Stellar Bloom](./stellar-bloom-marp.css) is my custom theme. If you enjoy it, additional theming can be found in my [KDE Themes repo](https://github.com/mcgheee/kde_themes#stellar-bloom).