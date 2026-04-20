# {{ProjectName}} - Power BI Project

## Project Type

Power BI semantic model and report developed in PBIP format using TMDL.

## Project Structure

```
src/
  {{ProjectName}}.pbip                    # Project manifest
  {{ProjectName}}.Report/                 # PBIR report definition
    definition.pbir
    StaticResources/
      RegisteredResources/
        Light.json                        # Default custom theme (PowerUI)
        Dark.json                         # Alternate custom theme (PowerUI)
  {{ProjectName}}.SemanticModel/          # TMDL semantic model
    definition.pbism
    definition/
      database.tmdl
      model.tmdl                          # Model manifest (ref tables, roles, etc.)
      expressions.tmdl                    # Parameterized connections
      relationships.tmdl                  # All model relationships
      tables/                             # One .tmdl file per table
        Calendar.tmdl
  .bpa/                                   # Best Practice Analyzer
    bpa.ps1
    bpa-rules-semanticmodel.json
    bpa-rules-report.json
docs/
  requirements.md                         # Business requirements
  changelog.md                            # Change history
```

## Conventions

### Naming
- **Tables**: lowercase singular for dimensions (`customer`, `product`), plural for facts (`sales`, `purchases`)
- **Columns**: lowercase with spaces (`customer key`, `order date`, `total amount`)
- **Measures**: Title Case with spaces (`Total Sales`, `YTD Revenue`, `Customer Count`)
- **Keys**: suffix with `key` (`customer key`, `product key`), set `isHidden: true`
- **Parameters**: prefix with `Parameter_` in Title Case (`Parameter_Server`, `Parameter_Database`)
- **TMDL files**: lowercase matching table names (`customer.tmdl`, `sales.tmdl`)

### Model Design
- Star schema: denormalized dimensions, normalized facts
- Import mode for all tables
- Parameterized SQL Server connections via `expressions.tmdl`
- Measures defined in their source fact table TMDL files
- Calendar table as the standard date dimension

### Documentation
- Triple-slash comments (`///`) on all tables, columns, and measures with business context
- Inline comments for complex DAX explaining business logic
- Keep `docs/requirements.md` updated with business requirements and data sources

### TMDL Formatting
- 2 spaces for TMDL properties, 4 spaces for DAX expressions within triple backticks
- Property order: declaration, documentation (///), properties (type, isKey, isHidden, formatString), source/partition last
- One table per `.tmdl` file in `/definition/tables/`

### Themes
- Two PowerUI-authored custom themes ship with the project: `Light.json` (default) and `Dark.json`, at `<ProjectName>.Report/StaticResources/RegisteredResources/`
- **When creating `definition/report.json` for the first time**, register both themes in `resourcePackages` (entries of `type: CustomTheme` under a `RegisteredResources` package) and set `themeCollection.customTheme` to `{ "name": "Light.json", "type": "RegisteredResources" }`. Preserve the `SharedResources` entry — do not overwrite it
- Do **not** author a new custom theme or invoke the `/modifying-theme-json` skill to generate one unless the user explicitly asks for a theme distinct from Light/Dark
- To swap themes, update only `themeCollection.customTheme.name` in `definition/report.json` to `Light.json` or `Dark.json` — do not regenerate the theme
- To tweak a theme, edit `Light.json` or `Dark.json` in place

## Quality Assurance

Run BPA before deployment:
```bash
pwsh src/.bpa/bpa.ps1 -src "src"
```

## Plugin Skills Reference

The following plugin skills are available for deeper guidance on specific topics:

| Skill | Purpose |
|-------|---------|
| `/tmdl` | TMDL syntax, properties, file examples |
| `/pbip` | PBIP project structure, file types, rename cascading |
| `/pbir-format` | PBIR report JSON structure, field references, expressions |
| `/standardize-naming-conventions` | Naming convention audit and bulk standardization |
| `/review-semantic-model` | Model quality, performance, and AI-readiness review |
| `/bpa-rules` | BPA rule authoring and validation |
| `/pbi-report-design` | Report layout, KPIs, tables, visual hierarchy, colors |
| `/modifying-theme-json` | Theme creation, compliance, visual type overrides |
| `/c-sharp-scripting` | Bulk model changes via Tabular Editor C# scripts |
| `/fabric-cli` | Deployment, workspace management, Fabric API |
| `/connect-pbid` | Live model interaction via TOM/Power BI Desktop |
| `/refreshing-semantic-model` | Refresh operations, monitoring, troubleshooting |
| `/lineage-analysis` | Downstream report dependency tracing |

## Workflows

- **Adding a table**: create TMDL in `definition/tables/`, add `ref table` in `model.tmdl`, add relationships in `relationships.tmdl`
- **Adding measures**: define in the source fact table TMDL file with `///` documentation
- **Adding a report page**: use Power BI Desktop (Developer Mode) or `/pbir-format` skill; when creating `definition/report.json` for the first time, register `Light.json` and `Dark.json` per the Themes convention above
- **Switching theme**: update `themeCollection.customTheme.name` in `definition/report.json` to `Light.json` or `Dark.json`
- **Reviewing model**: use `/review-semantic-model` skill
- **Deploying**: use `/fabric-cli` skill for workspace and deployment pipeline operations
