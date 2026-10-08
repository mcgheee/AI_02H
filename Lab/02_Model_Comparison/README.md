# Model comparison

A sortable, searchable HTML table of AI models. `model_comparison.html` is the viewer, `model_comparison_data.csv` is the included dataset, and `SKILL.md` contains instructions for an AI agent to research and rebuild the dataset. The viewer runs in a browser; generating a new CSV requires an agent with access to current online sources.

## Install the research skill

Use an agentic harness that supports skills (a directory containing a `SKILL.md` file) and has web access. Copy this project's `SKILL.md` into the harness's skills directory under its own folder. For example, from this directory, for a harness that discovers project skills under `.agents/skills/`:

```sh
mkdir -p .agents/skills/rebuild-model-comparison
cp SKILL.md .agents/skills/rebuild-model-comparison/SKILL.md
```

If your harness uses a different skills location, use that location instead and follow its skill-discovery instructions. Leave the file named **`SKILL.md`**: the filename and its frontmatter identify it as a skill. Enable the harness's web research tools and file-writing access before invoking it.

Ask the agent, for example:

> Use the `rebuild-model-comparison` skill to research and regenerate the model comparison CSV. Use `model_comparison_data.csv` as the baseline inventory, verify its entries against current sources, and save the result as `model_comparison.csv` in this directory. Tell me the research date, score provenance, and any unresolved entries.

The skill defines the 12-column schema that the HTML viewer validates, plus coverage, sourcing, scoring, and CSV checks. Researching a refresh can take time; the included data and any newly generated estimates should not be treated as independently verified without checking their sources. The skill's default output is `model_comparison.csv`; it does not update the HTML viewer.

## View the data

**Open directly:** Open `model_comparison.html` in a browser, click **Load CSV**, and select `model_comparison_data.csv` (or a newly generated `model_comparison.csv`). This also works when automatic browser loading is unavailable.

**Serve locally for automatic loading:** Put a file named `model_comparison.csv` beside `model_comparison.html`. To use the included dataset, copy it first:

```sh
cp model_comparison_data.csv model_comparison.csv
python3 -m http.server 8000
```

Then open `http://localhost:8000/model_comparison.html`. Stop the server with Ctrl+C when done. If you generated `model_comparison.csv` with the skill, skip the copy command. When served over HTTP, the page automatically fetches **only** `model_comparison.csv` from the same directory; it does not automatically load `model_comparison_data.csv`. You can still click **Load CSV** to choose a different file.

Click column headings to sort, use the search box to filter models, and click a source icon to visit a model's linked documentation. The CSV must retain the skill's exact 12 column headings and 12 fields per row; the viewer rejects incompatible files. `—` indicates an unavailable value, not zero. Published capability fields and the subjective estimated capability field are distinct; consult the skill and source links before relying on scores for decisions.
