# Discovery Brief

You are helping the user translate a discovery meeting transcript along with information about their source data into a structured discovery brief that feeds directly into `/product-plan`. This is a synthesis task, not a transcription task — the brief should be skimmable and opinionated, not a verbatim recap.

## Step 1: Check Prerequisites

First, verify the required inputs exist.

Check for `/docs/intake/intake-meeting.md`. If it doesn't exist:

"I don't see a meeting transcript yet. Please place your intake meeting transcription at `docs/intake/intake-meeting.md` before running this command. You can reference `docs/intake/intake-questions.md` for suggested topics to cover."

Stop here if the transcript is missing.

Check for at least one `.csv` file under `/docs/data/`. If none exist:

"I don't see any source data schemas yet. Please add schema files at `docs/data/[source].csv` following the template at `docs/data/source-template.md`, then run this command again."

Stop here if no source schemas exist.

Note whether `/docs/intake/intake-questions.md` has content beyond its heading — if so, use it in Step 2 as section framing.

## Step 2: Read Inputs

Read, in order:

1. `/docs/intake/intake-meeting.md` — the raw transcript
2. `/docs/intake/intake-questions.md` — the question bank (use its section structure to frame your synthesis)
3. Every `.csv` file under `/docs/data/` — source schemas to cross-reference against metrics and dimensions mentioned in the transcript

Do **not** read anything under `/docs/product/` — the brief precedes product planning and should not be biased by downstream artifacts.

## Step 3: Identify Gaps

Scan the transcript against the sections of the brief template (below). The critical categories are:

- Primary users and sponsor
- Problems to solve
- Desired outcomes
- Key business questions / metrics
- User journeys
- Data sources (cross-referenced with `/docs/data/*.csv`)

If a critical category is materially thin — not just imperfect, but missing enough that `/product-plan` would stall — use the `AskUserQuestion` tool to fill the gap. Cap follow-ups at **3 questions total**. If more than three categories are empty, the user should go back to the client rather than guess here.

If the metrics discussed in the transcript reference data that isn't reflected in any `/docs/data/*.csv` schema, do **not** block — note the mismatch explicitly in the `Open Questions` section of the brief.

## Step 4: Auto-Proceed — Write Brief

Once you have enough material, **immediately proceed** without asking for approval. Write `/docs/intake/discovery-brief.md` using this exact format:

```markdown
# Discovery Brief: [Working Product Name]

## Meeting Summary
[2–4 sentences: who met, what was discussed, decisions reached]

## Client & Stakeholders
- **Sponsor:** [Name, role]
- **Primary users:** [Persona(s) with role and context]
- **Secondary users:** [if any]

## Business Context
[What the organization does; where this product sits in their operations; what prompted the request now]

## Problems to Solve
1. **[Problem]** — [Current pain; what's broken or missing; how they work around it today]
2. **[Problem]** — [...]

## Desired Outcomes
- [Outcome 1 — what "success" looks like post-launch]
- [Outcome 2]

## Key Business Questions
[The questions the report must answer — these become measures and KPIs in the data model]
- [Question]
- [Question]

## User Journeys
[Tasks and decisions the report must support — these seed the page inventory]
- **[Journey]** — [Who, what they need to do, what decision follows]

## Data Sources
[Cross-reference with `/docs/data/*.csv` schemas. Note grain, time horizon, owner, and refresh cadence where known.]
- **[Source name]** — [Grain, time horizon, owner, refresh cadence]
- **[Source name]** — [...]

## Constraints & Non-Goals
- **Timeline:** [Target date, milestones]
- **Technical:** [Infra, access, licensing]
- **Out of scope:** [What was explicitly deferred]

## Open Questions
[Anything unresolved that will need a follow-up before or during `/product-plan`. Include any mismatches between discussed metrics and available source schemas.]
- [Question]
```

**Important:**
- Synthesize — don't transcribe. If the client spent 10 minutes describing one pain point, a one-sentence problem statement plus context is enough.
- Don't invent stakeholders, metrics, or data sources that aren't in the transcript or the `/docs/data/` schemas.
- Omit sections that genuinely have no content rather than filling with placeholder text — but move those items into `Open Questions` so they aren't lost.

## Step 5: Inform the User

After the brief is created:

"I've written the discovery brief for **[Working Product Name]** at `docs/intake/discovery-brief.md`.

Review the brief — especially the `Open Questions` section — and resolve anything critical before the next step. When you're ready, run `/product-plan` to turn this into a product overview, page inventory, and data model."

## Important Notes

- Be conversational and helpful in any follow-up questions, not robotic
- The brief should be skimmable — aim for roughly two pages of markdown
- Flag unresolved items in `Open Questions` rather than burying them in prose
- Do NOT present a draft for approval — write the file immediately and let the user review after
- If the user requests changes after reviewing, update the file immediately
- The format must match exactly so downstream commands can parse it reliably