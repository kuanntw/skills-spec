# Core Skill Format

## Overview

The core skill format is intentionally small. A skill is a directory whose primary entrypoint is `SKILL.md`. This layer is compatible with Agent Skills / Claude Skills-style clients that discover skills by reading the `name` and `description` frontmatter fields.

## Required directory shape

```text
skill-name/
  SKILL.md
```

Additional resources are optional:

```text
skill-name/
  SKILL.md
  references/
  scripts/
  assets/
```

## Naming rules

The package directory name, `SKILL.md` frontmatter `name`, and `skill.json` `name` field must be identical.

Skill names must:

- Use lowercase kebab-case.
- Contain only lowercase ASCII letters, digits, and hyphens.
- Be no longer than 64 characters.
- Start and end with a letter or digit.
- Not contain consecutive hyphens.

Recommended validation pattern:

```regex
^[a-z0-9](?:[a-z0-9-]{0,62}[a-z0-9])?$
```

## `SKILL.md`

`SKILL.md` must contain YAML frontmatter followed by Markdown instructions.

```markdown
---
name: code-review
description: Review code changes and produce actionable findings when asked to assess a diff, pull request, or repository change.
---

# Code Review

Use this skill when the user asks for a code review.
```

### Required frontmatter fields

| Field | Required | Description |
| --- | --- | --- |
| `name` | Yes | Stable skill identifier. Must match the directory name. |
| `description` | Yes | Short description of what the skill does and when the agent should use it. |

### Optional frontmatter fields

| Field | Description |
| --- | --- |
| `license` | SPDX license identifier. |
| `compatibility` | Human-readable compatibility note. |
| `metadata` | Map for implementation-specific metadata. |
| `allowed-tools` | Compatibility hint for clients that support tool allowlists in frontmatter. |

`allowed-tools` is only a hint. Security-sensitive permission decisions must be enforced by the runtime or CLI using the capability declarations in `skill.json`.

## Progressive disclosure

Skill packages should follow a three-stage loading model:

1. **Catalog loading**: clients load only `name` and `description` at session start.
2. **Instruction loading**: clients load the full `SKILL.md` body only after the skill is selected.
3. **Resource loading**: clients read or execute `references/`, `scripts/`, and `assets/` only when needed.

Keep `SKILL.md` concise. Put detailed reference material in `references/`, deterministic helper code in `scripts/`, and output templates or binary resources in `assets/`.

## Standard resource directories

| Directory | Purpose |
| --- | --- |
| `references/` | Markdown or text references loaded only when relevant. |
| `scripts/` | Executable helpers used by agents or CLI commands. |
| `assets/` | Templates, examples, images, fonts, or other files used in generated outputs. |

## Discovery locations

Portable clients should support `.agents/skills/` as the neutral location and may scan compatibility locations.

Recommended precedence from highest to lowest:

1. Explicitly configured paths.
2. Project `.agents/skills/`.
3. Project `.claude/skills/` compatibility path.
4. User `~/.agents/skills/`.
5. User `~/.claude/skills/` compatibility path.

When the same skill name appears in multiple scopes, project scope should override user scope.
