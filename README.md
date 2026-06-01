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

- `core.md` defines the Agent Skills-compatible core format.
- `manifest.md` defines the `skill.json` package extension.
- `cli.md` defines reference CLI behavior.
- `language-bindings.md` defines required SDK behaviors.
- `versioning.md` defines version and update rules.
- `security.md` defines capabilities and permission handling.
- `evaluation.md` defines skill evaluation conventions.
- `skill.schema.json` provides a JSON Schema for `skill.json`.
- `evals.schema.json` provides a JSON Schema for evaluation files.
- `minimal-skill` shows the smallest valid skill package.
- `full-skill` shows a registry-ready package with scripts and evaluations.

## Compatibility position

A conforming skill package **must** remain usable as a plain Agent Skill by tools that only understand `SKILL.md`. Tooling-specific extensions must live outside the core agent instructions unless they are also valid Agent Skills frontmatter.
