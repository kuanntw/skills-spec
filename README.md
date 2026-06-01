# Skills Package Specification

The Skills Package Specification defines a portable package format for AI skills. It is designed to be compatible with the Agent Skills / Claude Skills core format while adding conventions for versioning, CLI behavior, language bindings, updates, security declarations, and evaluation.

## Design goals

- Preserve compatibility with existing Agent Skills implementations that read `SKILL.md`.
- Keep agent-facing instructions concise through progressive disclosure.
- Provide machine-readable metadata for CLI tools, SDKs, registries, and update workflows.
- Support deterministic helper code in multiple programming languages when a skill needs scripts.
- Make skills versioned, testable, distributable, and safe to install.

## Specification layers

1. **Core skill format**: a directory containing `SKILL.md` with YAML frontmatter.
2. **Package manifest**: optional-but-recommended `skill.json` metadata for packaging and tooling.
3. **CLI behavior**: common commands for validation, installation, activation, update, and execution.
4. **Language bindings**: common SDK behaviors for TypeScript, Python, Go, Rust, and other clients.
5. **Distribution and security**: registry metadata, checksums, update policy, and capability declarations.

## Repository layout

- `docs/core.md` defines the Agent Skills-compatible core format.
- `docs/manifest.md` defines the `skill.json` package extension.
- `docs/cli.md` defines reference CLI behavior.
- `docs/language-bindings.md` defines required SDK behaviors.
- `docs/versioning.md` defines version and update rules.
- `docs/security.md` defines capabilities and permission handling.
- `docs/evaluation.md` defines skill evaluation conventions.
- `schemas/skill.schema.json` provides a JSON Schema for `skill.json`.
- `schemas/evals.schema.json` provides a JSON Schema for evaluation files.
- `examples/minimal-skill/` shows the smallest valid skill package.
- `examples/full-skill/` shows a registry-ready package with scripts and evaluations.

## Compatibility position

A conforming skill package **must** remain usable as a plain Agent Skill by tools that only understand `SKILL.md`. Tooling-specific extensions must live outside the core agent instructions unless they are also valid Agent Skills frontmatter.
