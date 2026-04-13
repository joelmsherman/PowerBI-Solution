# Power BI Solution Template

A GitHub template for full lifecycle development and deployment of Power BI Solutions using Claude Code, the [PBIR CLI tool](https://github.com/maxanatsko/pbir.tools) and the exceptional [Power BI Plugins](https://github.com/data-goblin/power-bi-agentic-development) developed by [Kurt Buhler](https://github.com/data-goblin) and [Max Anatsko](https://github.com/maxanatsko).  

## Introduction

This template gives you a ready-to-build Power BI solution scaffolded for agent-assisted development with Claude Code. It combines a PBIP project (TMDL semantic model + PBIR report), a preconfigured Claude Code plugin marketplace, a Best Practice Analyzer validation script, and a `setup.sh` initializer that renames project tokens and wires up SQL Server connection parameters.

It's aimed at Power BI developers who want to move beyond clicking through Power BI Desktop — authoring tables, measures, relationships, themes, and report pages as source code that can be reviewed, diffed, and deployed like any other software artifact. If you already work in PBIP format (or want to), and you'd like Claude to do the heavy lifting on TMDL authoring, DAX tuning, report layout, and deployment, this is for you.

The development model is **TMDL-first, agent-assisted, and BPA-validated**: the semantic model lives as TMDL files under source control; Claude Code plugins handle model authoring, report design, and Fabric deployment through domain-specific skills; and a scripted Best Practice Analyzer pass validates both the model and the report before anything ships to the Power BI Service.

## Requirements

### Claude Code

Install Claude Code per the [official instructions](https://docs.claude.com/en/docs/claude-code/overview).

### Power BI Desktop

Power BI Desktop with Developer Mode enabled:
- In PBI Desktop, go to **File** > **Options and settings** > **Options** > **Preview features**
- Enable **Power BI project (.pbip) save option**

### PBIR-CLI

`pbir-cli` is a Python tool installed via [`uv`](https://docs.astral.sh/uv/):

```bash
uv tool install pbir-cli
```

Verify the installation:

```bash
pbir --version
```

### Claude Code Plugins

The `.claude/settings.json` in this template points to the [`data-goblin/power-bi-agentic-development`](https://github.com/data-goblin/power-bi-agentic-development) marketplace and pre-enables all six plugins:

- `fabric-cli` — Fabric workspace and deployment operations
- `pbi-desktop` — live model interaction via TOM
- `pbip` — PBIP project structure and rename cascading
- `reports` — PBIR report authoring (Deneb, Python, R, SVG, themes)
- `semantic-models` — model review, naming, DAX, Power Query, lineage
- `tabular-editor` — BPA rules and C# scripting

On your first `claude` launch in the cloned project, Claude Code will prompt you to trust the marketplace. Accept it; the plugins install (and auto-update) from there.

### PowerShell 7+

Required for the BPA validation script. Install via [the official instructions](https://learn.microsoft.com/powershell/scripting/install/installing-powershell).

### Fabric CLI (for deployment)

Authenticate before deploying:

```bash
fab auth login
```

## Getting Started

```bash
# Clone from this template
git clone https://github.com/joelmsherman/PowerBISolution.git my-pbi-solution
cd my-pbi-solution

# Remove the template remote
git remote remove origin

# Initialize the PBIP project — renames {{ProjectName}} tokens across
# src/, CLAUDE.md, and expressions.tmdl, and sets the SQL connection params (if applicable)
./setup.sh "ProjectName" "DatabaseName" "ServerName"

# Launch Claude Code (accept the marketplace trust prompt on first run)
claude
```

`./setup.sh` arguments:
- `ProjectName` (required) — name for the PBIP project
- `DatabaseName` (optional, defaults to `ProjectName`) — SQL Server database name
- `ServerName` (optional, defaults to `localhost`) — SQL Server instance

Then open `src/<ProjectName>.pbip` in Power BI Desktop (Developer Mode) to preview the model and report as you develop.

## Workflow

1. **Document requirements** in `docs/requirements.md` — data sources, key metrics, stakeholders, and refresh schedule.

2. **Develop mockups** in `docs/` - See [this repo](https://github.com/joelmsherman/Product-Planning-Design) for more information.

3. **Build the semantic model** — ask Claude to do things like:
- Add dimension and fact tables from your data sources (uses `/tmdl` skill)
- Create relationships between tables (uses `/pbip` skill)
- Write measures and KPIs with DAX (uses `/tmdl` skill)
- Review model quality, performance, and AI-readiness (uses `/review-semantic-model` skill)
- Standardize naming conventions across the model (uses `/standardize-naming-conventions` skill)

4. **Build the report** — ask Claude to do things like:
- Design report pages with visuals, layout, and formatting (uses `/pbi-report-design` skill)
- Create or modify report themes (uses `/modifying-theme-json` skill)
- Add advanced visuals with Deneb/Vega-Lite, Python, R, or SVG (uses dedicated visual skills)
- Review report quality and usage (uses `/review-report` skill)

5. **Validate the report** - Run the Best Practices Analyzer against the semantic model and report layers:
- You can create or customize BPA rules by asking Claude (uses `/bpa-rules` skill)
- First run downloads Tabular Editor and PBI Inspector portables, then validates the semantic model and report against the configured rule sets.
```bash
pwsh src/.bpa/bpa.ps1 -src "src"
```

6. **Deploy to Power BI Service** 
- Authenticate first
```bash
fab auth login 
```
- Ask Claude to deploy to a certain workspace for which you are a member

## Folder Structure

```
.claude/
  settings.json               # Claude Code marketplace + plugin configuration
src/
  {{ProjectName}}.pbip         # Project manifest
  {{ProjectName}}.Report/
    definition.pbir            # Report definition (byPath ref to semantic model)
  {{ProjectName}}.SemanticModel/
    definition.pbism           # Semantic model properties
    definition/
      database.tmdl            # Compatibility level
      model.tmdl               # Model manifest (table refs, culture, options)
      expressions.tmdl         # Parameterized SQL Server connection
      relationships.tmdl       # All model relationships
      tables/
        Calendar.tmdl          # Standard calendar dimension
  .bpa/
    bpa.ps1                    # BPA validation script
    bpa-rules-semanticmodel.json
    bpa-rules-report.json
docs/
  requirements.md              # Business requirements template
```
