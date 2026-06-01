# Package Manifest: `skill.json`

## Purpose

`skill.json` is the machine-readable package extension for CLI tools, SDKs, registries, update workflows, and language-specific runners. It does not replace `SKILL.md`; it complements it.

A minimal package manifest looks like this:

```json
{
  "schema_version": "0.1.0",
  "name": "code-review",
  "version": "1.0.0",
  "description": "Review code changes and produce actionable findings.",
  "entrypoint": "SKILL.md"
}
```

## Required fields

| Field | Description |
| --- | --- |
| `schema_version` | Version of this manifest schema. |
| `name` | Skill name. Must match the directory and `SKILL.md` frontmatter. |
| `version` | Skill package version using SemVer. |
| `description` | Human-readable package description. |
| `entrypoint` | Relative path to `SKILL.md`. |

## Recommended fields

| Field | Description |
| --- | --- |
| `license` | SPDX license identifier. |
| `authors` | Package authors or maintainers. |
| `keywords` | Search tags. |
| `homepage` | Human-facing project URL. |
| `repository` | Source repository metadata. |
| `capabilities` | Required permissions and security posture. |
| `commands` | CLI-executable package commands. |
| `language_bindings` | SDK support and generated binding metadata. |
| `dependencies` | Skill or system dependencies. |
| `update` | Update channel and policy. |

## Commands

Commands define stable entrypoints that a CLI or SDK can run. A command can have multiple runners for different language environments.

```json
{
  "commands": {
    "validate": {
      "description": "Validate this skill package.",
      "runners": {
        "python": {
          "command": "uv run scripts/validate.py",
          "requires": ["python>=3.11", "uv>=0.4"]
        },
        "node": {
          "command": "npx tsx scripts/validate.ts",
          "requires": ["node>=20"]
        },
        "shell": {
          "command": "bash scripts/validate.sh"
        }
      }
    }
  }
}
```

Command names must use lowercase kebab-case. Runtimes should choose the first supported runner unless the user requests a specific runner.

## Language bindings

`language_bindings` declares generated SDK packages or known compatibility for this skill.

```json
{
  "language_bindings": {
    "typescript": {
      "package": "@agentskills/code-review",
      "module": "@agentskills/code-review",
      "min_runtime": "node>=20"
    },
    "python": {
      "package": "agentskills-code-review",
      "module": "agentskills_code_review",
      "min_runtime": "python>=3.11"
    }
  }
}
```

Bindings should not duplicate agent instructions. They should provide discovery, activation, validation, and command execution APIs around the skill package.

## Capability declarations

Capabilities are explicit permission requests. They are not self-enforcing; runtimes must enforce them.

```json
{
  "capabilities": {
    "filesystem": {
      "read": true,
      "write": false
    },
    "network": false,
    "commands": {
      "execute": true,
      "allowed": ["python", "uv", "bash"]
    },
    "secrets": {
      "reads_secrets": false,
      "writes_secrets": false
    }
  }
}
```

## Source and update metadata

```json
{
  "source": {
    "type": "git",
    "url": "https://github.com/example/skills.git",
    "path": "skills/code-review",
    "revision": "main"
  },
  "update": {
    "strategy": "semver",
    "channel": "stable",
    "allow_major": false,
    "auto_update": false
  }
}
```

Packages distributed through a registry should include a checksum in registry metadata or a lockfile, not only in `skill.json`.
