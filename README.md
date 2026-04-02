# Power BI Project Template

A template repository for scaffolding new Power BI projects using PBIP format with TMDL semantic models.

## Prerequisites

- **Power BI Desktop** with Developer Mode enabled
- **Claude Code** with the following plugins enabled:
  - `fabric-cli@power-bi-agentic-development`
  - `pbi-desktop@power-bi-agentic-development`
  - `pbip@power-bi-agentic-development`
  - `reports@power-bi-agentic-development`
  - `semantic-models@power-bi-agentic-development`
  - `tabular-editor@power-bi-agentic-development`
- **PowerShell** (for BPA validation)

Claude Code plugins are best-in-class from data-goblin's power-bi-agentic-development marketplace, available for [download here](https://github.com/data-goblin/power-bi-agentic-development/tree/main).

## Quick Start

1. Clone or copy this template repository
2. Run the setup script:

```bash
./setup.sh "MyProject" "MyDatabase" "myserver.database.windows.net"
```

Arguments:
- `ProjectName` (required) - Name for the PBIP project
- `DatabaseName` (optional, defaults to ProjectName) - SQL Server database name
- `ServerName` (optional, defaults to `localhost`) - SQL Server instance

3. Document your requirements in `docs/requirements.md` — data sources, key metrics, stakeholders, and refresh schedule
4. Use Claude Code to develop the project. The plugins provide skills for every stage of development:

   **Semantic Model** — ask Claude to:
   - Add dimension and fact tables from your data sources (uses `/tmdl` skill)
   - Create relationships between tables (uses `/pbip` skill)
   - Write measures and KPIs with DAX (uses `/tmdl` skill)
   - Review model quality, performance, and AI-readiness (uses `/review-semantic-model` skill)
   - Standardize naming conventions across the model (uses `/standardize-naming-conventions` skill)

   **Report** — ask Claude to:
   - Design report pages with visuals, layout, and formatting (uses `/pbi-report-design` skill)
   - Create or modify report themes (uses `/modifying-theme-json` skill)
   - Add advanced visuals with Deneb/Vega-Lite, Python, R, or SVG (uses dedicated visual skills)
   - Review report quality and usage (uses `/review-report` skill)

   **Validation & Deployment** — ask Claude to:
   - Run BPA validation: `pwsh src/.bpa/bpa.ps1 -src "src"`
   - Create or customize BPA rules (uses `/bpa-rules` skill)
   - Deploy to Power BI Service via Fabric CLI (uses `/fabric-cli` skill)

5. Open `src/MyProject.pbip` in Power BI Desktop (Developer Mode) to preview and interact with the model and report as you develop

## Folder Structure

```
.claude/
  settings.json               # Claude Code plugin configuration
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
  changelog.md                 # Change history
```

## BPA Validation

Run Best Practice Analyzer before deployment:

```bash
pwsh src/.bpa/bpa.ps1 -src "src"
```

This downloads Tabular Editor and PBI Inspector portables (first run only) and validates the semantic model and report against the configured rule sets.

## Conventions

See `CLAUDE.md` for full project conventions, naming rules, and plugin skill references.
