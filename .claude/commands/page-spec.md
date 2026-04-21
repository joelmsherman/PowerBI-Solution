# Page Spec

You are helping the user define the specification for a page of their Power BI product. This is a conversational process to establish the scope of functionality, user flows, and UI requirements — then automatically generate the spec.

## Step 1: Check Prerequisites

First, verify that `/docs/product/page-inventory.md` exists. If it doesn't:

"I don't see a page inventory defined yet. Please run `/page-inventory` first to define your product pages, then come back to shape individual pages."

Stop here if the inventory doesn't exist.

## Step 2: Identify the Target Page

Read `/docs/product/page-inventory.md` to get the list of report pages.

If there's only one page, auto-select it. If there are multiple pages, use the AskUserQuestion tool to ask which page the user wants to work on:

"Which page would you like to define the specification for?"

Present the available pages as options.

## Step 3: Gather Initial Input

Once the page is identified, invite the user to share any initial thoughts:

"Let's define the scope and requirements for **[Page Title]**.

Do you have any notes or ideas about what this page should include? Share any thoughts about the features, user flows, or UI patterns you're envisioning. If you're not sure yet, we can start with questions."

Wait for their response. The user may provide raw notes or ask to proceed with questions.

## Step 4: Ask Clarifying Questions

Use the AskUserQuestion tool to ask 4-6 targeted questions to define:

- **Main user actions/tasks** - What can users do on this page?
- **Information to display** - What data and content needs to be shown?
- **Key user flows** - What are the step-by-step interactions?
- **UI patterns** - Any specific interactions, layouts, or visuals needed?
- **Scope boundaries** - What should be explicitly excluded?

Example questions (adapt based on their input and the section):
- "What are the main actions a user can take on this page?"
- "What information needs to be displayed?"
- "Walk me through the main user flow - what happens step by step?"
- "Are there any specific UI patterns or visuals you want to use (e.g., tables, cards, modals)?"
- "What's intentionally out of scope for this section?"

Ask questions one or two at a time, conversationally. Focus on user experience and interface requirements.

## Step 5: Auto-Proceed — Create Spec

Once you have enough information from the clarifying questions or user-provided materials, **immediately proceed** to create the file at `/docs/product/pages/[page-title]-spec.md` with this exact format:

```markdown
# [Page Title] Specification

## Overview
[2-3 sentence summary of what this page does]

## User Flows
- [Flow 1]
- [Flow 2]
- [Flow 3]
[Add all flows discussed]

## UI Requirements
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]
[Add all requirements discussed]
```

**Important:**
- Don't add features that weren't discussed. Don't leave out features that were discussed.

## Step 6: Inform the User

After the specification file is created:

"I've created the specification for **[Page Title]** at: `docs/product/pages/[page-title]-spec.md`

Feel free to review this file, and let me know if you'd like to adjust anything. When you're ready, design a mockup for the page and manually upload to `docs/product/pages/[page-title]-mock.png`"

## Important Notes

- Be conversational and helpful, not robotic
- Ask follow-up questions when answers are vague
- Focus on UX and UI
- Keep the spec concise - only include what was discussed, no bloat
- Do NOT present a draft for approval — go straight to writing the files after gathering enough info
- If the user requests changes after reviewing, update the relevant files immediately