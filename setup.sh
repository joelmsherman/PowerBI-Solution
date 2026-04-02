#!/bin/bash
# setup.sh - Initialize a new Power BI project from this template
# Usage: ./setup.sh <ProjectName> [DatabaseName] [ServerName]

set -e

PROJECT_NAME="${1:?Usage: ./setup.sh <ProjectName> [DatabaseName] [ServerName]}"
DB_NAME="${2:-$PROJECT_NAME}"
SERVER_NAME="${3:-localhost}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "Initializing Power BI project: $PROJECT_NAME"
echo "  Database: $DB_NAME"
echo "  Server:   $SERVER_NAME"
echo ""

# Rename directories
mv "src/{{ProjectName}}.Report" "src/${PROJECT_NAME}.Report"
mv "src/{{ProjectName}}.SemanticModel" "src/${PROJECT_NAME}.SemanticModel"
mv "src/{{ProjectName}}.pbip" "src/${PROJECT_NAME}.pbip"

# Replace {{ProjectName}} tokens in all relevant files
find src/ -type f \( -name "*.pbip" -o -name "*.pbir" -o -name "*.pbism" -o -name "*.tmdl" \) \
  -exec sed -i "s/{{ProjectName}}/${PROJECT_NAME}/g" {} +

# Replace tokens in CLAUDE.md
sed -i "s/{{ProjectName}}/${PROJECT_NAME}/g" CLAUDE.md

# Update connection parameters in expressions.tmdl
EXPR_FILE="src/${PROJECT_NAME}.SemanticModel/definition/expressions.tmdl"
sed -i "s/\"localhost\"/\"${SERVER_NAME}\"/g" "$EXPR_FILE"
sed -i "s/\"${PROJECT_NAME}\"/\"${DB_NAME}\"/g" "$EXPR_FILE"

echo "Project '$PROJECT_NAME' initialized successfully."
echo ""
echo "  Semantic Model: src/${PROJECT_NAME}.SemanticModel/"
echo "  Report:         src/${PROJECT_NAME}.Report/"
echo "  BPA Rules:      src/.bpa/"
echo "  Documentation:  docs/"
echo ""
echo "Next steps:"
echo "  1. Update docs/requirements.md with business requirements"
echo "  2. Add dimension and fact tables to src/${PROJECT_NAME}.SemanticModel/definition/tables/"
echo "  3. Add relationships in src/${PROJECT_NAME}.SemanticModel/definition/relationships.tmdl"
echo "  4. Open src/${PROJECT_NAME}.pbip in Power BI Desktop (Developer Mode)"
echo "  5. Run BPA: pwsh src/.bpa/bpa.ps1 -src \"src\""
