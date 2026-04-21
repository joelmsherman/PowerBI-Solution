# Source Data Schema Template

- Must be a csv file named `[Source].csv`
- Must exist at `/docs/data/`
- Must follow this template:

| Column Name | Column Type | Top 5 Values (comma separated) | Source Type | Source Name |
|-------------|-------------|--------------------------------|-------------|-------------|
|             |             |                                |             |             |

- Source Type: e.g. Excel, database table, database view
- Source Name: Name of the flat file or else the call-sign of the database entity `[WarehouseName].[schema].[ObjectName]`