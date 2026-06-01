# Full Skill Workflow Reference

A full package keeps the agent-facing entrypoint concise while moving details into supporting resources.

- `SKILL.md` explains when to use the skill and the primary workflow.
- `skill.json` exposes versioning, commands, capabilities, update policy, and language binding metadata.
- `references/` stores detailed instructions that should only be loaded when relevant.
- `scripts/` stores deterministic helpers.
- `assets/` stores templates and other output resources.
- `evals/` stores prompts, fixtures, and assertions.
