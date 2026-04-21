# Product Plan

You are helping the user define their product vision and overall plan for a new Power BI solution. This is a conversational process that results in three files: Product Overview, Page Inventory, and Data Model.

## Step 1: Gather Initial Input

First, ask the user to share their discovery brief or thoughts about the product they want to build. Be warm and open-ended:

"I'd love to help you define your product vision. Tell me about the Power BI product you're building - share any notes, ideas, or rough thoughts you have. What problem are you trying to solve? Who is it for? Don't worry about structure yet, just share what's on your mind."

Wait for their response before proceeding.

## Step 2: Ask Clarifying Questions

After receiving their input, use the AskUserQuestion tool to ask targeted questions covering all three areas. Ask questions one or two at a time, conversationally, with follow-ups as needed.

### Product Overview Questions

Shape the core product definition:

- **The product name** - A clear, concise name for the product
- **The core product description** (1-3 sentences that capture the essence)
- **The key problems** the product solves (1-5 specific pain points)
- **How the product solves each problem** (concrete solutions)
- **The main features** that make this possible

**Important:** If the user hasn't already provided a product name, ask them:
- "What would you like to call this product? (A short, memorable name)"

Example questions (adapt based on their input):
- "Who is the primary user of this product? Can you describe them?"
- "What's the single biggest pain point you're addressing?"
- "How do people currently solve this problem without your product?"
- "What makes your approach different or better?"
- "What are the 3-5 most essential features?"

### Page Inventory Questions

Identify the separate pages of the Power BI report and their function:

- "What are the user journeys that drive the report's design?"
- "What are the report pages and their core functionalities that support these user journeys?"

### Data Model Questions

First, check whether [source].csv source data file schemas exist at `/docs/data/`. If there are none:

"I don't see any source data information yet. Please place info about your data sources in `/docs/data/`. Make sure they are csv files named like `[source].csv` and follow the template at `docs/data/source-template.md`"

Stop here if no source data file schemas exist.

Second, Identify the facts and dimensions of the data model, and roughly how they relate:

- "What are the key measures and KPIs that users need to see?"
- "What are the categories or items that users will need to filter or slice the key measures and KPIs?

The goal is to gather enough information for all three files before proceeding.

## Step 3: Auto-Proceed — Create All Three Files

Once you have enough information from the clarifying questions or user-provided documentation, **immediately proceed** without asking for approval. Write all three files uninterrupted:

### 3a: Create Product Overview

Create the file at `/docs/product/product-overview.md` with this exact format:

```markdown
# [Product Name]

## Description
[The finalized 1-3 sentence description]

## Problems & Solutions

### Problem 1: [Problem Title]
[How the product solves it in 1-2 sentences]

### Problem 2: [Problem Title]
[How the product solves it in 1-2 sentences]

[Add more as needed, up to 5]

## Key Features
- [Feature 1]
- [Feature 2]
- [Feature 3]
[Add more as needed]
```

### 3b: Create Page Inventory

Create `/docs/product/page-inventory.md` with this exact format:

```markdown
# Page Inventory

## Pages

### 1. [Page Title]
[Short description]

### 2. [Page Title]
[Short description]

### 3. [Page Title]
[Short description]
```

Pages should be ordered by development priority.

### 3c: Create Data Model

Create `/docs/product/data-model.md` with this format:

```markdown
# Data Model

## Facts

### [Fact1]
[Plain-language description of the numerical fields provided by the entity, and how those will support the key measures and KPIs users will need in the product]

### [Fact2]
[Add more facts as needed but the ideal data model contains a single fact table; only add additional fact entities if numeric data from multiple data source tables cannot be combined into a single view, upstream]

## Dimensions

### [Dimension1]
[Plain-language description of the categorical fields provided by the entity]

### [Dimension2]
[Add more dimensions as needed but try to group like categorical data source fields with like]

## Relationships

- [Dimension1] has many [Fact1]
- [Dimension2] has many [Fact1]
[Add more relationships as needed]
```

The ideal Power BI semantic model is a star-schema with single-direction, one-to-many relationships between dimensions and facts. All entities in import-mode.

### 3d: Inform the User

After all three files are created, present a summary:

"I've set up the plan for **[Product Name]**:

1. **Product Overview** — `docs/product/product-overview.md`
2. **Page Inventory** — `docs/product/page-inventory.md`
3. **Data Model** — `docs/product/data-model.md`

Review these files and let me know if you'd like to adjust anything. When you're ready, run `/page-spec` to start building specs for an individual page"

## Important Notes

- Be conversational and helpful, not robotic
- Ask follow-up questions when answers are vague
- Help the user think through their product, don't just transcribe
- Keep the final output concise and clear
- The format must match exactly for the app to parse it correctly
- **Always ensure the product has a name** - if user didn't provide one, ask for it
- Do NOT present a draft for approval — go straight to writing all three files after gathering enough info
- If the user requests changes after reviewing, update the relevant files immediately
