# Page Inventory

You are helping the user create or update their page inventory for their Power BI solution.

## Step 1: Check Current State

First, check if `/docs/product/page-inventory.md` exists.

---

## If Inventory Already Exists (Updating)

Read both:
- `docs/product/product-overview.md`
- `docs/product/page-inventory.md`

Present the current state and ask what to change:

"Your page inventory currently has [N] pages:

1. **[Page 1]** — [Description]
2. **[Page 2]** — [Description]
3. **[Page 3]** — [Description]

What would you like to change?"

Wait for the user's response describing what they want changed. Once you receive their notes, **immediately proceed** to update `docs/product/page-inventory.md` based on their requested changes — do not present a draft for approval.

After updating, inform the user:

"I've updated the page inventory based on your feedback. Review the changes and let me know if you'd like further adjustments."

Stop here — the remaining steps below are for generating a new page inventory from scratch.

---

## If No Inventory Exists (Creating New)

### Check Prerequisites

Read `/docs/product/product-overview.md`. If it doesn't exist:

"Before creating a page inventory, you'll need to plan your product. Please run `/product-plan` first."

Stop here if the product overview is missing.

### Analyze and Generate

Read the product overview and analyze:
- The core description
- The problems being solved
- The key features listed

**Immediately proceed** to create `/docs/product/page-inventory.md` — do not present a draft for approval.

Use this exact format:

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

### Confirm

"I've created your page inventory at `/docs/product/page-inventory.md` with [N] pages:

1. **[Page 1]** — [Description]
2. **[Page 2]** — [Description]
3. **[Page 3]** — [Description]

Review the pages and let me know if you'd like to adjust anything. When you're ready, run `/page-spec` to start building specs for an individual page."

---

## Important Notes

- Pages should be ordered by development priority
- Each page should be self-contained enough to design and build independently
- Page titles become navigation items in the dashboard
- Keep descriptions concise and clear
- Don't create too many pages (3-5 is ideal)
- Do NOT present a draft for approval — generate the file immediately and let the user review after
- If the user requests changes after reviewing, update the file immediately
